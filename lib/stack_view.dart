import 'package:atlantas_android/second.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';

import 'attribute.dart';
import 'items.dart';

class StackViewPage extends StatefulWidget {
  final Items item;
  final List<Attribute> listS;
  final int imgIndex;
  final int indexofhero;
  const StackViewPage(
      {required this.item,
      required this.listS,
      required this.imgIndex,
      required this.indexofhero,
      Key? key})
      : super(key: key);

  @override
  State<StackViewPage> createState() => _StackViewPageState();
}

class _StackViewPageState extends State<StackViewPage> {
  @override
  bool operator ==(Object other) {
    return hashCode == other.hashCode;
  }

  @override
  Widget build(BuildContext context) {
    List<TextEditingController> _controller =
        List.generate(widget.item.item.length, (i) => TextEditingController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 16, 82, 249),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Atlantas XML"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: (widget.imgIndex != -1)
                  ? Hero(
                      tag: "IMAGE" + widget.indexofhero.toString(),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        progressIndicatorBuilder: (context, url, progress) =>
                            Center(
                          child: CircularProgressIndicator(
                            value: progress.progress,
                          ),
                        ),
                        imageUrl: (Uri.parse(
                                    widget.item.item[widget.imgIndex].atribute)
                                .isAbsolute)
                            ? widget.item.item[widget.imgIndex].atribute
                            : "https://i.stack.imgur.com/6M513.png",
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ))
                  : Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color.fromARGB(255, 16, 82, 249),
                          Colors.white
                        ],
                      )),
                      child: const Center(
                          child: AutoSizeText(
                        "Image has not been set yet",
                        style: TextStyle(fontSize: 30),
                        maxLines: 1,
                      )),
                    ),
            ),
            Expanded(
                flex: 4,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.item.item.length,
                    itemBuilder: (BuildContext context, int index) {
                      _controller[index].text =
                          widget.item.item[index].atribute;

                      var arr2 =
                          widget.listS[index].atribute.toString().split('|');

                      if (arr2[0] == "MultiSelect") {
                        var arr3 = [];
                        for (int i = 1; i < arr2.length; i++) {
                          arr3.add(arr2[i]);
                        }
                        var arr = widget.item.item[index].atribute
                            .toString()
                            .split(',');

                        List<SelectItems> selectList = [];
                        List<SelectItems> selectList2 = [];

                        arr3.asMap().forEach((index, value) =>
                            {selectList2.add(SelectItems(index + 1, value))});
                        final selectableItems2 = selectList2
                            .map((element) => MultiSelectItem<SelectItems>(
                                element, element.name))
                            .toList();

                        for (int i = 0; i < arr.length; i++) {
                          selectList.add(SelectItems(i + 1, arr[i]));
                        }

                        return Card(
                          child: Row(
                            children: [
                              Expanded(
                                child: MultiSelectChipField(
                                    items: selectableItems2,
                                    initialValue: //selectList2,
                                        initialValueSelect(
                                            selectList, selectList2),
                                    title: Text(widget.item.item[index].name
                                        .toString()),
                                    headerColor:
                                        const Color.fromARGB(255, 16, 82, 249)
                                            .withOpacity(0.5),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 16, 82, 249),
                                          width: 1.5),
                                    ),
                                    selectedChipColor:
                                        const Color.fromARGB(255, 16, 82, 249)
                                            .withOpacity(0.5),
                                    selectedTextStyle: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 16, 82, 249)),
                                    onTap: null),
                              )
                            ],
                          ),
                        );
                      }

                      return Card(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                //constraints: const BoxConstraints.expand(),
                                //height: 51,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 16, 82, 249)
                                            .withOpacity(0.5),
                                    border: const Border(
                                      top: BorderSide(
                                          width: 1.5,
                                          color:
                                              Color.fromARGB(255, 16, 82, 249)),
                                      left: BorderSide(
                                          width: 1.5,
                                          color:
                                              Color.fromARGB(255, 16, 82, 249)),
                                      bottom: BorderSide(
                                          width: 1.5,
                                          color:
                                              Color.fromARGB(255, 16, 82, 249)),
                                    )),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                  child: AutoSizeText(
                                    widget.item.item[index].name.toString(),
                                    style: TextStyle(fontSize: 18),
                                    minFontSize: 2,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 6,
                                child: Container(
                                  alignment: Alignment.center,
                                  //height: 55,
                                  decoration: const BoxDecoration(
                                      border: Border(
                                    top: BorderSide(
                                        width: 1.5,
                                        color:
                                            Color.fromARGB(255, 16, 82, 249)),
                                    right: BorderSide(
                                        width: 1.5,
                                        color:
                                            Color.fromARGB(255, 16, 82, 249)),
                                    bottom: BorderSide(
                                        width: 1.5,
                                        color:
                                            Color.fromARGB(255, 16, 82, 249)),
                                  )),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: AutoSizeText(
                                      widget.item.item[index].atribute
                                          .toString(),
                                      style: TextStyle(fontSize: 18),
                                      minFontSize: 2,
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      );
                    })),
          ],
        ),
      ),
    );
  }

  List<SelectItems?> initialValueSelect(
      List<SelectItems> temp, List<SelectItems> temp2) {
    List<SelectItems> temp3 = [];
    for (int i = 0; i < temp2.length; i++) {
      //print("i = ${temp2[i].name}");
      for (int j = 0; j < temp.length; j++) {
        if (temp[j].name == temp2[i].name) {
          //print("j = ${temp[j].name}");
          //print(temp[j].name == temp2[i].name);
          temp3.add(temp2[i]);
        }
      }
    }
    return temp3;
  }
}
