import 'dart:convert';
import 'dart:io';

import 'package:atlantas_android/stack_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:firedart/firedart.dart';
import 'package:flutter/services.dart';

//import 'package:flutter/foundation.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';

import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

//import 'package:flutter_test2/main.dart';

import 'package:path_provider/path_provider.dart';

import './items.dart';
import './database.dart';
//import 'package:hovering/hovering.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'attribute.dart';

import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:clickable_list_wheel_view/measure_size.dart';
//import 'package:expandable/expandable.dart';

//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutterfire_ui/auth.dart';

int indexNav = 1;
int scrollIndex = 0;

class SecondPage extends StatefulWidget {
  final group1 = AutoSizeGroup();
  final group2 = AutoSizeGroup();

  List<Items> listitems;
  List<Items> listd;
  List<Attribute> listS;
  List<String> typeList = [
    "TextField",
    "MultiSelect",
    "Name",
    "Stock",
    "Image",
  ];
  String droptype = "TextField";
  Attribute dropdownValue;
  SecondPage(
      {required this.listitems,
      required this.listd,
      required this.listS,
      required this.dropdownValue,
      Key? key})
      : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class SelectItems {
  int id;
  String name;

  SelectItems(this.id, this.name);
}

// List<SelectItems> selectList = [
//   SelectItems(1, "one"),
//   SelectItems(2, "tow"),
//   SelectItems(3, "three")
// ];

class _SecondPageState extends State<SecondPage> {
  // final selectableItems = selectList
  //     .map((element) => MultiSelectItem<SelectItems>(element, element.name))
  //     .toList();
  var idk = [];
  Items selected = Items();
  int selectedIndex = -1;
  double? heightC = 0;
  bool isExpanded = false;

  bool deleteAt = false;

  List<int> indexes = [-1, -1, -1];
  @override
  bool operator ==(Object other) {
    return hashCode == other.hashCode;
  }

  @override
  void initState() {
    //print(widget.listS);
    //print("test");
    widget.listS.asMap().forEach((key, value) {
      if (value.atribute == "Name") {
        indexes[0] = key;
        //print("test0");
      }
      if (value.atribute == "Stock") {
        indexes[1] = key;
        //print("test1");
        //print(indexes[1]);
      }
      if (value.atribute == "Image") {
        indexes[2] = key;
        //print(key);
        //print(value.atribute);
        //print("test2");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.listS);
    // widget.listS.asMap().forEach((key, value) {
    //   if (value.atribute == "Stock") {
    //     indexes[2] = key;
    //     //print("found1");
    //   }
    //   if (value.atribute == "Name") {
    //     nameIndex = key;
    //     print("found2");
    //   }
    //   if (value.atribute == "Image") {
    //     imgIndex = key;
    //     //print("found3");
    //   }
    // });
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 16, 82, 249),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Atlantas XML"),
      ),
      backgroundColor: const Color.fromARGB(255, 17, 21, 24),
      bottomNavigationBar: SafeArea(
        child: CurvedNavigationBar(
          index: indexNav,
          backgroundColor: Colors.transparent,
          color: const Color.fromARGB(255, 16, 82, 249),
          buttonBackgroundColor: const Color.fromARGB(255, 16, 82, 249),
          animationDuration: const Duration(milliseconds: 300),
          items: const <Widget>[
            Icon(
              Icons.settings,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.list,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.save,
              size: 30,
              color: Colors.white,
            ),
          ],
          onTap: (index) {
            if (indexNav != index) {
              setState(() {
                indexNav = index;
                //print(indexNav);
              });
            }
          },
          height: 60,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Expanded(
                //   flex: 2,
                //   child: Builder(builder: (BuildContext context) {
                //     return _searchList();
                //   }),
                // ),
                Expanded(
                  flex: 15,
                  child: Column(
                    children: [
                      //
                      Expanded(
                        child: IndexedStack(index: indexNav, children: [
                          Builder(builder: (context) {
                            List<Widget> widgetList = [];
                            for (int i = 0; i < widget.listitems.length; i++) {
                              widgetList.add(Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              width: 5,
                                              color: const Color.fromARGB(
                                                  255, 16, 82, 249)),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20))),
                                      height: 200,
                                      child: Card(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            AutoSizeText(
                                              (indexes[0] != -1)
                                                  ? widget.listitems[i]
                                                      .item[indexes[0]].atribute
                                                  : "Name has not been set yet",
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 16, 82, 249),
                                                fontSize: 30,
                                              ),
                                              minFontSize: 5,
                                              overflowReplacement:
                                                  const AutoSizeText(
                                                      "Name is too long to show up.."),
                                            ),
                                            AutoSizeText(
                                              indexes[1] != -1
                                                  ? "Stock : ${widget.listitems[i].item[indexes[1]].atribute.toString()}"
                                                  : "Stock has not been set yet!",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  backgroundColor: (indexes[
                                                              1] ==
                                                          -1)
                                                      ? const Color.fromARGB(
                                                          255, 16, 82, 249)
                                                      : (int.tryParse(widget
                                                                  .listd[i]
                                                                  .item[indexes[
                                                                      1]]
                                                                  .atribute)! >
                                                              10
                                                          ? Colors.green
                                                          : int.tryParse(widget
                                                                      .listd[i]
                                                                      .item[
                                                                          indexes[
                                                                              1]]
                                                                      .atribute)! >
                                                                  5
                                                              ? Colors.orange
                                                              : Colors.red),
                                                  color: Colors.white),
                                              maxLines: 1,
                                              overflowReplacement:
                                                  const AutoSizeText(
                                                      "Stock is too long to show up.."),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ));
                            }
                            return Row(
                              children: [
                                Expanded(
                                  flex: 15,
                                  child: Stack(children: [
                                    ListWheelScrollView(
                                        physics:
                                            const FixedExtentScrollPhysics(),
                                        onSelectedItemChanged: (index) {
                                          scrollIndex = index;
                                        },
                                        offAxisFraction: 1,
                                        squeeze: 0.9,
                                        itemExtent: 200,
                                        children: widgetList),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(flex: 1, child: Container()),
                                        Expanded(
                                          flex: 8,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    if (indexes[1] != -1) {
                                                      if (widget
                                                                  .listitems[
                                                                      scrollIndex]
                                                                  .item[indexes[
                                                                      1]]
                                                                  .atribute ==
                                                              "" ||
                                                          (int.parse(widget
                                                                  .listitems[
                                                                      scrollIndex]
                                                                  .item[indexes[
                                                                      1]]
                                                                  .atribute) <
                                                              1)) {
                                                        setState(() {
                                                          widget
                                                              .listitems[
                                                                  scrollIndex]
                                                              .item[indexes[1]]
                                                              .atribute = "0";
                                                        });
                                                      } else {
                                                        setState(() {
                                                          widget
                                                              .listitems[
                                                                  scrollIndex]
                                                              .item[indexes[1]]
                                                              .atribute = (int.parse(widget
                                                                      .listitems[
                                                                          scrollIndex]
                                                                      .item[
                                                                          indexes[
                                                                              1]]
                                                                      .atribute) -
                                                                  1)
                                                              .toString();
                                                        });
                                                      }
                                                    }
                                                  },
                                                  onLongPress: () {
                                                    if (indexes[1] != -1) {
                                                      if (widget
                                                                  .listitems[
                                                                      scrollIndex]
                                                                  .item[indexes[
                                                                      1]]
                                                                  .atribute ==
                                                              "" ||
                                                          (int.parse(widget
                                                                  .listitems[
                                                                      scrollIndex]
                                                                  .item[indexes[
                                                                      1]]
                                                                  .atribute) <
                                                              11)) {
                                                        setState(() {
                                                          widget
                                                              .listitems[
                                                                  scrollIndex]
                                                              .item[indexes[1]]
                                                              .atribute = "0";
                                                        });
                                                      } else {
                                                        setState(() {
                                                          widget
                                                              .listitems[
                                                                  scrollIndex]
                                                              .item[indexes[1]]
                                                              .atribute = (int.parse(widget
                                                                      .listitems[
                                                                          scrollIndex]
                                                                      .item[
                                                                          indexes[
                                                                              1]]
                                                                      .atribute) -
                                                                  10)
                                                              .toString();
                                                        });
                                                      }
                                                    }
                                                  },
                                                  child: Ink(
                                                      child: const Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Icon(
                                                      Icons.remove_circle,
                                                      color: Color.fromARGB(
                                                          255, 16, 82, 249),
                                                      size: 50,
                                                    ),
                                                  )),
                                                ),
                                              ),
                                              Expanded(child: Container()),
                                              Expanded(
                                                child: InkWell(
                                                    onTap: () {
                                                      if (indexes[1] != -1) {
                                                        if (widget
                                                                .listitems[
                                                                    scrollIndex]
                                                                .item[
                                                                    indexes[1]]
                                                                .atribute ==
                                                            "") {
                                                          setState(() {
                                                            widget
                                                                .listitems[
                                                                    scrollIndex]
                                                                .item[
                                                                    indexes[1]]
                                                                .atribute = "1";
                                                          });
                                                        } else {
                                                          setState(() {
                                                            widget
                                                                .listitems[
                                                                    scrollIndex]
                                                                .item[
                                                                    indexes[1]]
                                                                .atribute = (int.parse(widget
                                                                        .listitems[
                                                                            scrollIndex]
                                                                        .item[indexes[
                                                                            1]]
                                                                        .atribute) +
                                                                    1)
                                                                .toString();
                                                          });
                                                        }
                                                      }
                                                    },
                                                    onLongPress: () {
                                                      if (indexes[1] != -1) {
                                                        if (widget
                                                                .listitems[
                                                                    scrollIndex]
                                                                .item[
                                                                    indexes[1]]
                                                                .atribute ==
                                                            "") {
                                                          setState(() {
                                                            widget
                                                                .listitems[
                                                                    scrollIndex]
                                                                .item[
                                                                    indexes[1]]
                                                                .atribute = "10";
                                                          });
                                                        } else {
                                                          setState(() {
                                                            widget
                                                                .listitems[
                                                                    scrollIndex]
                                                                .item[
                                                                    indexes[1]]
                                                                .atribute = (int.parse(widget
                                                                        .listitems[
                                                                            scrollIndex]
                                                                        .item[indexes[
                                                                            1]]
                                                                        .atribute) +
                                                                    10)
                                                                .toString();
                                                          });
                                                        }
                                                      }
                                                    },
                                                    child: Ink(
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Icon(
                                                          Icons.add_circle,
                                                          color: Color.fromARGB(
                                                              255, 16, 82, 249),
                                                          size: 50,
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ]),
                                ),
                                Expanded(flex: 1, child: Container()),
                              ],
                            );
                          }),
                          GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      mainAxisExtent: 200,
                                      maxCrossAxisExtent: 200,
                                      childAspectRatio: 3 / 2,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 8),
                              controller: ScrollController(),
                              shrinkWrap: true,
                              itemCount: widget.listitems.length,
                              itemBuilder: (BuildContext context, int index) {
                                return _listItem(index, context);
                              }),
                          Text("test"),
                        ]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _listItem(index, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => StackViewPage(
                    item: widget.listitems[index],
                    listS: widget.listS,
                    imgIndex: indexes[2],
                    indexofhero: index,
                  )),
        );
      },
      child: Stack(
        fit: StackFit.expand,
        //height: 85,
        children: [
          (indexes[2] != -1)
              ? Hero(
                  tag: "IMAGE" + index.toString(),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    progressIndicatorBuilder: (context, url, progress) =>
                        Center(
                      child: CircularProgressIndicator(
                        value: progress.progress,
                      ),
                    ),
                    imageUrl: (Uri.parse(widget
                                .listitems[index].item[indexes[2]].atribute)
                            .isAbsolute)
                        ? widget.listitems[index].item[indexes[2]].atribute
                        : "https://i.stack.imgur.com/6M513.png",
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ))
              : Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Color.fromARGB(255, 16, 82, 249), Colors.white],
                  )),
                  // child: const Center(
                  //     child: AutoSizeText(
                  //   "Image has not been set yet",
                  //   style: TextStyle(fontSize: 30),
                  //   maxLines: 1,
                  // )),
                ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                // gradient: LinearGradient(
                //     begin: Alignment.topLeft,
                //     end: Alignment.bottomRight,
                //     colors: [
                //   Colors.white.withOpacity(0.7),
                //   Colors.transparent.withOpacity(0.2)
                // ],
                //     stops: [
                //   0.0,
                //   1.0
                // ])
                color: Colors.white.withOpacity(0.5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AutoSizeText(
                  indexes[0] != -1
                      ? (widget.listitems[index].item[indexes[0]].atribute
                          .toString())
                      : "Name has not been set yet!",
                  style: const TextStyle(fontSize: 20, color: Colors.black),
                  maxFontSize: 20,
                  minFontSize: 3,
                  textAlign: TextAlign.center,
                  overflowReplacement: Text('Sorry String too long'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  var textfromsearch = "";
  final mycontroller = TextEditingController();
  _searchList() {
    //widget.dropdownValue=widget.listS[0];
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                width: 5, color: const Color.fromARGB(255, 16, 82, 249)),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<Attribute>(
                value: widget.dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Color.fromARGB(255, 16, 82, 249)),
                underline: Container(
                  height: 2,
                  color: const Color.fromARGB(255, 16, 82, 249).withOpacity(0),
                ),
                onChanged: (Attribute? newValue) {
                  setState(() {
                    widget.dropdownValue = newValue!;
                    _updateList(textfromsearch);
                  });
                },
                items: widget.listS
                    .map<DropdownMenuItem<Attribute>>((Attribute value) {
                  return DropdownMenuItem<Attribute>(
                    value: value,
                    child: Text(value.name.toString()),
                  );
                }).toList(),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: mycontroller,
                  decoration: InputDecoration(hintText: "Search... "),
                  onChanged: (text) {
                    text = text.toLowerCase();
                    textfromsearch = text;
                    setState(() {
                      _updateList(text);
                    });
                  },
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (!isExpanded) {
                    var temp = widget.listS.length * 0.04;
                    heightC = MediaQuery.of(context).size.height / 100 * 30;
                    isExpanded = !isExpanded;
                  } else {
                    heightC = 0;
                    isExpanded = !isExpanded;
                  }
                });
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Add/Remove Attributes'),
              ),
              style: ElevatedButton.styleFrom(shape: StadiumBorder()),
            ),
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) =>
      DropdownMenuItem(child: Text(item));

  _updateList(String text) {
    widget.listitems = widget.listitems;
    if (text != Null || text != "") {
      widget.listitems = widget.listitems.where((item) {
        var listtitle = item
            .item[widget.listS.indexOf(widget.dropdownValue)].atribute
            .toString()
            .toLowerCase();
        return listtitle.contains(text);
      }).toList();
      selectedIndex = widget.listitems.indexOf(selected);
    } else {
      widget.listitems = widget.listitems;
      selectedIndex = widget.listitems.indexOf(selected);
    }
    setState(() {});
  }

  _updateAttributes(String name, String type, String multiSelectTemp) {
    if (type == "Name") {
      indexes[0] = widget.listS.length;
    }
    if (type == "Stock") {
      indexes[1] = widget.listS.length;
    }
    if (type == "Image") {
      indexes[2] = widget.listS.length;
    }

    if (type == "MultiSelect") {
      multiSelectTemp = multiSelectTemp.replaceAll(",", "|");
      type += "|" + multiSelectTemp;
    }
    //print(type);
    setState(() {
      widget.listS.add(Attribute(name, type));
    });
  }

  Future openDialog(BuildContext context, Items item) => showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        List<TextEditingController> _controller =
            List.generate(item.item.length, (i) => TextEditingController());
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              side:
                  BorderSide(color: Color.fromARGB(255, 16, 82, 249), width: 5),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          title: Padding(
            padding: const EdgeInsets.fromLTRB(25, 20, 25, 50),
            child: Text(item.item[0].atribute.toString()),
          ),
          content: Container(
            height: height * 0.7,
            width: width * 0.7,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: item.item.length,
                          itemBuilder: (BuildContext context, int index) {
                            _controller[index].text = item.item[index].atribute;

                            var arr2 = widget.listS[index].atribute
                                .toString()
                                .split('|');

                            if (arr2[0] == "Stock") {
                              ValueNotifier<bool> _currentSwitchValue =
                                  ValueNotifier(true);
                              ValueNotifier<double> _animatedW =
                                  ValueNotifier(0);
                              ValueNotifier<String> addRemove =
                                  ValueNotifier("+");

                              TextEditingController _controller2 =
                                  TextEditingController();

                              return Card(
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1.5,
                                          color: const Color.fromARGB(
                                              255, 16, 82, 249))),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 55,
                                        color: const Color.fromARGB(
                                                255, 16, 82, 249)
                                            .withOpacity(0.5),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 10, 10, 10),
                                          child: Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    Clipboard.setData(
                                                        ClipboardData(
                                                            text: item
                                                                .item[index]
                                                                .atribute
                                                                .toString()));
                                                  },
                                                  icon:
                                                      Icon(Icons.content_copy)),
                                              Text(item.item[index].name
                                                  .toString()),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 0, 0),
                                        child: TextField(
                                          controller: _controller[index],
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: item
                                                  .item[index].atribute
                                                  .toString()),
                                        ),
                                      )),
                                      Tooltip(
                                        message: "Long Press for -10",
                                        child: InkWell(
                                          onTap: () {
                                            if (_controller[index].text == "" ||
                                                (int.parse(_controller[index]
                                                        .text) <
                                                    1)) {
                                              setState(() {
                                                _controller[index].text = "0";
                                              });
                                            } else {
                                              setState(() {
                                                _controller[index]
                                                    .text = (int.parse(
                                                            _controller[index]
                                                                .text) -
                                                        1)
                                                    .toString();
                                              });
                                            }
                                          },
                                          onLongPress: () {
                                            if (_controller[index].text == "" ||
                                                (int.parse(_controller[index]
                                                        .text) <
                                                    11)) {
                                              setState(() {
                                                _controller[index].text = "0";
                                              });
                                            } else {
                                              setState(() {
                                                _controller[index]
                                                    .text = (int.parse(
                                                            _controller[index]
                                                                .text) -
                                                        10)
                                                    .toString();
                                              });
                                            }
                                          },
                                          child: Ink(
                                            child: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child:
                                                  Icon(Icons.exposure_minus_1),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Tooltip(
                                        message: "Long Press for +10",
                                        child: InkWell(
                                          onTap: () {
                                            if (_controller[index].text == "") {
                                              setState(() {
                                                _controller[index].text = "1";
                                              });
                                            } else {
                                              setState(() {
                                                _controller[index]
                                                    .text = (int.parse(
                                                            _controller[index]
                                                                .text) +
                                                        1)
                                                    .toString();
                                              });
                                            }
                                          },
                                          onLongPress: () {
                                            if (_controller[index].text == "") {
                                              setState(() {
                                                _controller[index].text = "10";
                                              });
                                            } else {
                                              setState(() {
                                                _controller[index]
                                                    .text = (int.parse(
                                                            _controller[index]
                                                                .text) +
                                                        10)
                                                    .toString();
                                              });
                                            }
                                          },
                                          child: Ink(
                                            child: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child:
                                                  Icon(Icons.exposure_plus_1),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (_animatedW.value == 0) {
                                            _animatedW.value = 185;
                                          } else {
                                            _animatedW.value = 0;
                                          }
                                        },
                                        onLongPress: () {},
                                        child: Ink(
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(Icons.exposure_rounded),
                                          ),
                                        ),
                                      ),
                                      MultiValueListenableBuilder(
                                        valueListenables: [
                                          _animatedW,
                                          _currentSwitchValue,
                                          addRemove
                                        ],
                                        builder: (context, values, child) {
                                          return AnimatedContainer(
                                            duration:
                                                Duration(milliseconds: 300),
                                            width: values.elementAt(0),
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                    border: Border(
                                                        left: BorderSide(
                                                            color: Colors
                                                                .blueAccent))),
                                                child: Row(
                                                  children: [
                                                    Switch(
                                                        value:
                                                            values.elementAt(1),
                                                        onChanged: (value) {
                                                          _currentSwitchValue
                                                              .value = value;
                                                          value
                                                              ? addRemove
                                                                  .value = "+"
                                                              : addRemove
                                                                  .value = "-";
                                                        }),
                                                    SizedBox(
                                                        width: 10,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  0, 0, 0, 10),
                                                          child: Text(
                                                              values
                                                                  .elementAt(2),
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          25)),
                                                        )),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          10, 0, 0, 0),
                                                      child: SizedBox(
                                                          width: 60,
                                                          child: TextField(
                                                            controller:
                                                                _controller2,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                              FilteringTextInputFormatter
                                                                  .digitsOnly
                                                            ],
                                                            decoration:
                                                                const InputDecoration(
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    hintText:
                                                                        "000000"),
                                                          )),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        if (_controller2.text !=
                                                            "") {
                                                          int tempN = int.parse(
                                                              _controller2
                                                                  .text);
                                                          _currentSwitchValue
                                                                  .value
                                                              ? {}
                                                              : {
                                                                  tempN = -tempN
                                                                };
                                                          if (_controller[index]
                                                                  .text ==
                                                              "") {
                                                            if (tempN > 0) {
                                                              setState(() {
                                                                _controller[index]
                                                                        .text =
                                                                    tempN
                                                                        .toString();
                                                              });
                                                            } else {
                                                              setState(() {
                                                                _controller[
                                                                        index]
                                                                    .text = "0";
                                                              });
                                                            }
                                                          } else {
                                                            if (int.parse(_controller[
                                                                            index]
                                                                        .text) +
                                                                    tempN <
                                                                0) {
                                                              _controller[index]
                                                                  .text = "0";
                                                            } else {
                                                              setState(() {
                                                                _controller[
                                                                        index]
                                                                    .text = (int.parse(
                                                                            _controller[index].text) +
                                                                        tempN)
                                                                    .toString();
                                                              });
                                                            }
                                                          }
                                                        }
                                                      },
                                                      icon: const Icon(Icons
                                                          .arrow_circle_right),
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 16, 82, 249),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            } else if (arr2[0] == "MultiSelect") {
                              var arr3 = [];
                              for (int i = 1; i < arr2.length; i++) {
                                arr3.add(arr2[i]);
                              }
                              var arr = item.item[index].atribute
                                  .toString()
                                  .split(',');

                              List<SelectItems> selectList = [];
                              List<SelectItems> selectList2 = [];

                              arr3.asMap().forEach((index, value) => {
                                    selectList2
                                        .add(SelectItems(index + 1, value))
                                  });
                              final selectableItems2 = selectList2
                                  .map((element) =>
                                      MultiSelectItem<SelectItems>(
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
                                        initialValue: initialValueSelect(
                                            selectList, selectList2),
                                        title: Text(
                                            item.item[index].name.toString()),
                                        headerColor: const Color.fromARGB(
                                                255, 16, 82, 249)
                                            .withOpacity(0.5),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color.fromARGB(
                                                  255, 16, 82, 249),
                                              width: 1.5),
                                        ),
                                        selectedChipColor: const Color.fromARGB(
                                                255, 16, 82, 249)
                                            .withOpacity(0.5),
                                        selectedTextStyle: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 16, 82, 249)),
                                        onTap: (values) {
                                          String temp = "";
                                          for (int i = 0;
                                              i < values.length;
                                              i++) {
                                            var element = values[i];
                                            final args = element as SelectItems;
                                            if (i < values.length - 1) {
                                              temp += "${args.name},";
                                            } else {
                                              temp += args.name;
                                            }
                                          }

                                          _controller[index].text = temp;
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }

                            return Card(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      //constraints: const BoxConstraints.expand(),
                                      height: 51,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                                  255, 16, 82, 249)
                                              .withOpacity(0.5),
                                          border: const Border(
                                            top: BorderSide(
                                                width: 1.5,
                                                color: Color.fromARGB(
                                                    255, 16, 82, 249)),
                                            left: BorderSide(
                                                width: 1.5,
                                                color: Color.fromARGB(
                                                    255, 16, 82, 249)),
                                            bottom: BorderSide(
                                                width: 1.5,
                                                color: Color.fromARGB(
                                                    255, 16, 82, 249)),
                                          )),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 0, 8, 0),
                                        child: Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  Clipboard.setData(
                                                      ClipboardData(
                                                          text: item.item[index]
                                                              .atribute
                                                              .toString()));
                                                },
                                                icon: const Icon(
                                                    Icons.content_copy)),
                                            AutoSizeText(
                                              item.item[index].name.toString(),
                                              overflowReplacement:
                                                  Text('Sorry String too long'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 5,
                                      child: Container(
                                        alignment: Alignment.center,
                                        //height: 55,
                                        decoration: const BoxDecoration(
                                            border: Border(
                                          top: BorderSide(
                                              width: 1.5,
                                              color: Color.fromARGB(
                                                  255, 16, 82, 249)),
                                          right: BorderSide(
                                              width: 1.5,
                                              color: Color.fromARGB(
                                                  255, 16, 82, 249)),
                                          bottom: BorderSide(
                                              width: 1.5,
                                              color: Color.fromARGB(
                                                  255, 16, 82, 249)),
                                        )),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 0, 0),
                                          child: TextField(
                                            keyboardType:
                                                TextInputType.multiline,
                                            textInputAction:
                                                TextInputAction.newline,
                                            minLines: 1,
                                            maxLines: 4,
                                            controller: _controller[index],
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: item
                                                    .item[index].atribute
                                                    .toString()),
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
          ),
          actions: [
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      savealert(context, item, _controller);
                    },
                    child: const Text("Save")),
                TextButton(
                    onPressed: () {
                      closealert(context);
                    },
                    child: const Text("Cancel")),
              ],
            )
          ],
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
        );
      });

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

  Future openNewDialog(BuildContext context) => showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        List<TextEditingController> _controller = List.generate(
            widget.listitems[0].item.length, (i) => TextEditingController());
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              side:
                  BorderSide(color: Color.fromARGB(255, 16, 82, 249), width: 5),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          title: const Padding(
            padding: EdgeInsets.fromLTRB(25, 20, 25, 50),
            child: Text("New Item"),
          ),
          content: Container(
            height: height * 0.7,
            width: width * 0.7,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _controller.length,
                          itemBuilder: (BuildContext context, int index) {
                            _controller[index].text = "";

                            var arr2 = widget.listS[index].atribute
                                .toString()
                                .split('|');

                            if (arr2[0] == "Stock") {
                              ValueNotifier<bool> _currentSwitchValue =
                                  ValueNotifier(true);
                              ValueNotifier<double> _animatedW =
                                  ValueNotifier(0);
                              ValueNotifier<String> addRemove =
                                  ValueNotifier("+");

                              TextEditingController _controller2 =
                                  TextEditingController();

                              return Card(
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1.5,
                                          color: const Color.fromARGB(
                                              255, 16, 82, 249))),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 55,
                                        color: const Color.fromARGB(
                                                255, 16, 82, 249)
                                            .withOpacity(0.5),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 10, 10, 10),
                                          child: Row(
                                            children: [
                                              // IconButton(
                                              //     onPressed: () {
                                              //       // Clipboard.setData(
                                              //       //     ClipboardData(
                                              //       //         text: item
                                              //       //             .item[index]
                                              //       //             .atribute
                                              //       //             .toString())
                                              //       //             );
                                              //     },
                                              //     icon:
                                              //         Icon(Icons.content_copy)),
                                              Text(widget
                                                  .listitems[0].item[index].name
                                                  .toString()),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 0, 0),
                                        child: TextField(
                                          controller: _controller[index],
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "",
                                          ),
                                        ),
                                      )),
                                      Tooltip(
                                        message: "Long Press for -10",
                                        child: InkWell(
                                          onTap: () {
                                            if (_controller[index].text == "" ||
                                                (int.parse(_controller[index]
                                                        .text) <
                                                    1)) {
                                              setState(() {
                                                _controller[index].text = "0";
                                              });
                                            } else {
                                              setState(() {
                                                _controller[index]
                                                    .text = (int.parse(
                                                            _controller[index]
                                                                .text) -
                                                        1)
                                                    .toString();
                                              });
                                            }
                                          },
                                          onLongPress: () {
                                            if (_controller[index].text == "" ||
                                                (int.parse(_controller[index]
                                                        .text) <
                                                    11)) {
                                              setState(() {
                                                _controller[index].text = "0";
                                              });
                                            } else {
                                              setState(() {
                                                _controller[index]
                                                    .text = (int.parse(
                                                            _controller[index]
                                                                .text) -
                                                        10)
                                                    .toString();
                                              });
                                            }
                                          },
                                          child: Ink(
                                            child: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child:
                                                  Icon(Icons.exposure_minus_1),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Tooltip(
                                        message: "Long Press for +10",
                                        child: InkWell(
                                          onTap: () {
                                            if (_controller[index].text == "") {
                                              setState(() {
                                                _controller[index].text = "1";
                                              });
                                            } else {
                                              setState(() {
                                                _controller[index]
                                                    .text = (int.parse(
                                                            _controller[index]
                                                                .text) +
                                                        1)
                                                    .toString();
                                              });
                                            }
                                          },
                                          onLongPress: () {
                                            if (_controller[index].text == "") {
                                              setState(() {
                                                _controller[index].text = "10";
                                              });
                                            } else {
                                              setState(() {
                                                _controller[index]
                                                    .text = (int.parse(
                                                            _controller[index]
                                                                .text) +
                                                        10)
                                                    .toString();
                                              });
                                            }
                                          },
                                          child: Ink(
                                            child: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child:
                                                  Icon(Icons.exposure_plus_1),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (_animatedW.value == 0) {
                                            _animatedW.value = 185;
                                          } else {
                                            _animatedW.value = 0;
                                          }
                                        },
                                        onLongPress: () {},
                                        child: Ink(
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(Icons.exposure_rounded),
                                          ),
                                        ),
                                      ),
                                      MultiValueListenableBuilder(
                                        valueListenables: [
                                          _animatedW,
                                          _currentSwitchValue,
                                          addRemove
                                        ],
                                        builder: (context, values, child) {
                                          return AnimatedContainer(
                                            duration:
                                                Duration(milliseconds: 300),
                                            width: values.elementAt(0),
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                    border: Border(
                                                        left: BorderSide(
                                                            color: Colors
                                                                .blueAccent))),
                                                child: Row(
                                                  children: [
                                                    Switch(
                                                        value:
                                                            values.elementAt(1),
                                                        onChanged: (value) {
                                                          _currentSwitchValue
                                                              .value = value;
                                                          value
                                                              ? addRemove
                                                                  .value = "+"
                                                              : addRemove
                                                                  .value = "-";
                                                        }),
                                                    SizedBox(
                                                        width: 10,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  0, 0, 0, 10),
                                                          child: Text(
                                                              values
                                                                  .elementAt(2),
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          25)),
                                                        )),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          10, 0, 0, 0),
                                                      child: SizedBox(
                                                          width: 60,
                                                          child: TextField(
                                                            controller:
                                                                _controller2,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                              FilteringTextInputFormatter
                                                                  .digitsOnly
                                                            ],
                                                            decoration:
                                                                const InputDecoration(
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    hintText:
                                                                        "000000"),
                                                          )),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        if (_controller2.text !=
                                                            "") {
                                                          int tempN = int.parse(
                                                              _controller2
                                                                  .text);
                                                          _currentSwitchValue
                                                                  .value
                                                              ? {}
                                                              : {
                                                                  tempN = -tempN
                                                                };
                                                          if (_controller[index]
                                                                  .text ==
                                                              "") {
                                                            if (tempN > 0) {
                                                              setState(() {
                                                                _controller[index]
                                                                        .text =
                                                                    tempN
                                                                        .toString();
                                                              });
                                                            } else {
                                                              setState(() {
                                                                _controller[
                                                                        index]
                                                                    .text = "0";
                                                              });
                                                            }
                                                          } else {
                                                            if (int.parse(_controller[
                                                                            index]
                                                                        .text) +
                                                                    tempN <
                                                                0) {
                                                              _controller[index]
                                                                  .text = "0";
                                                            } else {
                                                              setState(() {
                                                                _controller[
                                                                        index]
                                                                    .text = (int.parse(
                                                                            _controller[index].text) +
                                                                        tempN)
                                                                    .toString();
                                                              });
                                                            }
                                                          }
                                                        }
                                                      },
                                                      icon: const Icon(Icons
                                                          .arrow_circle_right),
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 16, 82, 249),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            } else if (arr2[0] == "MultiSelect") {
                              var arr3 = [];
                              for (int i = 1; i < arr2.length; i++) {
                                arr3.add(arr2[i]);
                              }
                              // var arr = item.item[index].atribute
                              //     .toString()
                              //     .split(',');

                              List<SelectItems> selectList = [];
                              List<SelectItems> selectList2 = [];

                              arr3.asMap().forEach((index, value) => {
                                    selectList2
                                        .add(SelectItems(index + 1, value))
                                  });
                              final selectableItems2 = selectList2
                                  .map((element) =>
                                      MultiSelectItem<SelectItems>(
                                          element, element.name))
                                  .toList();

                              // for (int i = 0; i < arr.length; i++) {
                              //   selectList.add(SelectItems(i + 1, arr[i]));
                              // }

                              return Card(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: MultiSelectChipField(
                                        items: selectableItems2,
                                        initialValue: initialValueSelect(
                                            selectList, selectList2),
                                        title: Text(widget
                                            .listitems[0].item[index].name
                                            .toString()),
                                        headerColor: const Color.fromARGB(
                                                255, 16, 82, 249)
                                            .withOpacity(0.5),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color.fromARGB(
                                                  255, 16, 82, 249),
                                              width: 1.5),
                                        ),
                                        selectedChipColor: const Color.fromARGB(
                                                255, 16, 82, 249)
                                            .withOpacity(0.5),
                                        selectedTextStyle: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 16, 82, 249)),
                                        onTap: (values) {
                                          String temp = "";
                                          for (int i = 0;
                                              i < values.length;
                                              i++) {
                                            var element = values[i];
                                            final args = element as SelectItems;
                                            if (i < values.length - 1) {
                                              temp += "${args.name},";
                                            } else {
                                              temp += args.name;
                                            }
                                          }

                                          _controller[index].text = temp;
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }

                            return Card(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      //constraints: const BoxConstraints.expand(),
                                      height: 51,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                                  255, 16, 82, 249)
                                              .withOpacity(0.5),
                                          border: const Border(
                                            top: BorderSide(
                                                width: 1.5,
                                                color: Color.fromARGB(
                                                    255, 16, 82, 249)),
                                            left: BorderSide(
                                                width: 1.5,
                                                color: Color.fromARGB(
                                                    255, 16, 82, 249)),
                                            bottom: BorderSide(
                                                width: 1.5,
                                                color: Color.fromARGB(
                                                    255, 16, 82, 249)),
                                          )),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 0, 8, 0),
                                        child: Row(
                                          children: [
                                            // IconButton(
                                            //     onPressed: () {
                                            //       // Clipboard.setData(
                                            //       //     ClipboardData(
                                            //       //         text: item.item[index]
                                            //       //             .atribute
                                            //       //             .toString()));
                                            //     },
                                            //     icon: const Icon(
                                            //         Icons.content_copy)),
                                            AutoSizeText(
                                              widget
                                                  .listitems[0].item[index].name
                                                  .toString(),
                                              overflowReplacement:
                                                  Text('Sorry String too long'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 5,
                                      child: Container(
                                        alignment: Alignment.center,
                                        //height: 55,
                                        decoration: const BoxDecoration(
                                            border: Border(
                                          top: BorderSide(
                                              width: 1.5,
                                              color: Color.fromARGB(
                                                  255, 16, 82, 249)),
                                          right: BorderSide(
                                              width: 1.5,
                                              color: Color.fromARGB(
                                                  255, 16, 82, 249)),
                                          bottom: BorderSide(
                                              width: 1.5,
                                              color: Color.fromARGB(
                                                  255, 16, 82, 249)),
                                        )),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 0, 0),
                                          child: TextField(
                                            keyboardType:
                                                TextInputType.multiline,
                                            textInputAction:
                                                TextInputAction.newline,
                                            minLines: 1,
                                            maxLines: 4,
                                            controller: _controller[index],
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              // hintText: item
                                              //     .item[index].atribute
                                              //     .toString()
                                            ),
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
          ),
          actions: [
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      createItem(
                          context, _controller, widget.listitems, widget.listS);
                    },
                    child: const Text("Create")),
                TextButton(
                    onPressed: () {
                      closealert(context);
                    },
                    child: const Text("Cancel")),
              ],
            )
          ],
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
        );
      });

  Future openDeleteDialog(BuildContext context, List<Items> itemlist,
          Items item, List<Items> listitems) =>
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            var height = MediaQuery.of(context).size.height;
            var width = MediaQuery.of(context).size.width;
            // List<TextEditingController> _controller =
            //     List.generate(3, (i) => TextEditingController());

            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  side: BorderSide(
                      color: Color.fromARGB(255, 16, 82, 249), width: 5),
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: Container(
                  height: height * 0.2,
                  width: width * 0.3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Are you sure you want to delete it ?"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    deleteItem(
                                        context, itemlist, item, listitems);
                                  },
                                  child: const Text("Yes")),
                              TextButton(
                                  onPressed: () {
                                    closealert(context);
                                  },
                                  child: const Text("No")),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
              insetPadding: EdgeInsets.zero,
              contentPadding: EdgeInsets.zero,
              clipBehavior: Clip.antiAliasWithSaveLayer,
            );
          });

  Future openDeleteAtributeDialog(BuildContext context) => showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        // List<TextEditingController> _controller =
        //     List.generate(3, (i) => TextEditingController());

        return AlertDialog(
          shape: const RoundedRectangleBorder(
              side:
                  BorderSide(color: Color.fromARGB(255, 16, 82, 249), width: 5),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: Container(
              height: height * 0.2,
              width: width * 0.3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AutoSizeText(
                        "Are you sure you want to delete it ?",
                        overflowReplacement: Text('Sorry String too long'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {
                                deleteAt = true;
                                closealert(context);
                              },
                              child: const Text("Yes")),
                          TextButton(
                              onPressed: () {
                                closealert(context);
                              },
                              child: const Text("No")),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
        );
      });

  // Future openSaveExport(BuildContext context) => showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (context) {
  //       var height = MediaQuery.of(context).size.height;
  //       var width = MediaQuery.of(context).size.width;
  //       // List<TextEditingController> _controller =
  //       //     List.generate(3, (i) => TextEditingController());
  //       int level = 0;
  //       TextEditingController _controller1 = TextEditingController();
  //       String msg = "";

  //       return StatefulBuilder(builder: (context, setState) {
  //         return AlertDialog(
  //           shape: const RoundedRectangleBorder(
  //               side: BorderSide(
  //                   color: Color.fromARGB(255, 16, 82, 249), width: 5),
  //               borderRadius: BorderRadius.all(Radius.circular(10.0))),
  //           content: Container(
  //               height: height * 0.5,
  //               width: width * 0.2,
  //               child: Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: Center(
  //                   child: Builder(builder: (context) {
  //                     if (level == 0) {
  //                       return Column(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         crossAxisAlignment: CrossAxisAlignment.stretch,
  //                         children: [
  //                           Expanded(
  //                             child: Padding(
  //                               padding: const EdgeInsets.all(8.0),
  //                               child: HoverButton(
  //                                 //minWidth: 300,
  //                                 onpressed: () async {
  //                                   if (SQLHelper.dbDir == "null.db") {
  //                                     setState(() {
  //                                       level = 1;
  //                                     });
  //                                   } else if (SQLHelper.dbDir ==
  //                                       "firebase.db") {
  //                                     await SaveFB();
  //                                     closealert(context);
  //                                   } else {
  //                                     SaveDB(SQLHelper.dbDir);
  //                                     closealert(context);
  //                                   }
  //                                 },
  //                                 hoverColor:
  //                                     const Color.fromARGB(255, 16, 82, 249),
  //                                 color: const Color.fromARGB(255, 17, 21, 24),
  //                                 hoverTextColor:
  //                                     const Color.fromARGB(255, 17, 21, 24),
  //                                 hoverShape: const OutlineInputBorder(
  //                                   borderSide: BorderSide(
  //                                       color: Color.fromARGB(255, 17, 21, 24),
  //                                       width: 5.0),
  //                                 ),
  //                                 shape: const OutlineInputBorder(
  //                                   borderSide: BorderSide(
  //                                       color: Color.fromARGB(255, 16, 82, 249),
  //                                       width: 5.0),
  //                                 ),
  //                                 textColor:
  //                                     const Color.fromARGB(255, 16, 82, 249),
  //                                 padding: const EdgeInsets.all(20.0),
  //                                 hoverPadding: const EdgeInsets.all(20.0),

  //                                 child: AutoSizeText(
  //                                   "Save",
  //                                   maxLines: 1,
  //                                   group: widget.group2,
  //                                   style: TextStyle(fontSize: 45),
  //                                   minFontSize: 10,
  //                                   maxFontSize: 45,
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                           Expanded(
  //                             child: Padding(
  //                               padding: const EdgeInsets.all(8.0),
  //                               child: HoverButton(
  //                                 //minWidth: 300,
  //                                 onpressed: () {
  //                                   setState(() {
  //                                     level = 1;
  //                                   });
  //                                 },
  //                                 hoverColor:
  //                                     const Color.fromARGB(255, 16, 82, 249),
  //                                 color: const Color.fromARGB(255, 17, 21, 24),
  //                                 hoverTextColor:
  //                                     const Color.fromARGB(255, 17, 21, 24),
  //                                 hoverShape: const OutlineInputBorder(
  //                                   borderSide: BorderSide(
  //                                       color: Color.fromARGB(255, 17, 21, 24),
  //                                       width: 5.0),
  //                                 ),
  //                                 shape: const OutlineInputBorder(
  //                                   borderSide: BorderSide(
  //                                       color: Color.fromARGB(255, 16, 82, 249),
  //                                       width: 5.0),
  //                                 ),
  //                                 textColor:
  //                                     const Color.fromARGB(255, 16, 82, 249),
  //                                 padding: const EdgeInsets.all(20.0),
  //                                 hoverPadding: const EdgeInsets.all(20.0),

  //                                 child: AutoSizeText(
  //                                   "Save As",
  //                                   maxLines: 1,
  //                                   group: widget.group2,
  //                                   style: TextStyle(fontSize: 45),
  //                                   minFontSize: 10,
  //                                   maxFontSize: 45,
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                           Expanded(
  //                             child: Padding(
  //                               padding: const EdgeInsets.all(8.0),
  //                               child: HoverButton(
  //                                 //minWidth: 300,
  //                                 onpressed: () async {
  //                                   String? outputFile =
  //                                       await FilePicker.platform.saveFile(
  //                                           type: FileType.custom,
  //                                           allowedExtensions: ['xml'],
  //                                           dialogTitle: 'Saving XML file:',
  //                                           fileName: SQLHelper.dbDir.substring(
  //                                               0, SQLHelper.dbDir.length - 3),
  //                                           lockParentWindow: true);

  //                                   if (outputFile == null) {
  //                                     // User canceled the picker
  //                                   } else {
  //                                     if (outputFile.substring(
  //                                             outputFile.length - 4) !=
  //                                         ".xml") {
  //                                       outputFile += '.xml';
  //                                     }
  //                                     await saveXml(outputFile);
  //                                     closealert(context);
  //                                   }
  //                                 },
  //                                 hoverColor:
  //                                     const Color.fromARGB(255, 16, 82, 249),
  //                                 color: const Color.fromARGB(255, 17, 21, 24),
  //                                 hoverTextColor:
  //                                     const Color.fromARGB(255, 17, 21, 24),
  //                                 hoverShape: const OutlineInputBorder(
  //                                   borderSide: BorderSide(
  //                                       color: Color.fromARGB(255, 17, 21, 24),
  //                                       width: 5.0),
  //                                 ),
  //                                 shape: const OutlineInputBorder(
  //                                   borderSide: BorderSide(
  //                                       color: Color.fromARGB(255, 16, 82, 249),
  //                                       width: 5.0),
  //                                 ),
  //                                 textColor:
  //                                     const Color.fromARGB(255, 16, 82, 249),
  //                                 padding: const EdgeInsets.all(20.0),
  //                                 hoverPadding: const EdgeInsets.all(20.0),

  //                                 child: AutoSizeText(
  //                                   "Export XML",
  //                                   maxLines: 1,
  //                                   group: widget.group2,
  //                                   style: TextStyle(fontSize: 45),
  //                                   minFontSize: 10,
  //                                   maxFontSize: 45,
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                           Expanded(
  //                             child: Padding(
  //                               padding: const EdgeInsets.all(8.0),
  //                               child: HoverButton(
  //                                 //minWidth: 300,
  //                                 onpressed: () {
  //                                   //SaveDB();
  //                                   closealert(context);
  //                                 },
  //                                 hoverColor:
  //                                     const Color.fromARGB(255, 16, 82, 249),
  //                                 color: const Color.fromARGB(255, 17, 21, 24),
  //                                 hoverTextColor:
  //                                     const Color.fromARGB(255, 17, 21, 24),
  //                                 hoverShape: const OutlineInputBorder(
  //                                   borderSide: BorderSide(
  //                                       color: Color.fromARGB(255, 17, 21, 24),
  //                                       width: 5.0),
  //                                 ),
  //                                 shape: const OutlineInputBorder(
  //                                   borderSide: BorderSide(
  //                                       color: Color.fromARGB(255, 16, 82, 249),
  //                                       width: 5.0),
  //                                 ),
  //                                 textColor:
  //                                     const Color.fromARGB(255, 16, 82, 249),
  //                                 padding: const EdgeInsets.all(20.0),
  //                                 hoverPadding: const EdgeInsets.all(20.0),

  //                                 child: AutoSizeText(
  //                                   "Cancel",
  //                                   maxLines: 1,
  //                                   group: widget.group2,
  //                                   style: TextStyle(fontSize: 45),
  //                                   minFontSize: 10,
  //                                   maxFontSize: 45,
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //                       );
  //                     } else if (level == 1) {
  //                       return Column(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         crossAxisAlignment: CrossAxisAlignment.stretch,
  //                         children: [
  //                           const Expanded(
  //                               flex: 1,
  //                               child: AutoSizeText(
  //                                 "Name the DB:",
  //                                 textAlign: TextAlign.center,
  //                                 style: TextStyle(
  //                                   color: Color.fromARGB(255, 16, 82, 249),
  //                                   fontSize: 30,
  //                                 ),
  //                               )),
  //                           Expanded(
  //                               flex: 1,
  //                               child: TextField(
  //                                   style: const TextStyle(
  //                                     fontSize: 30, // This is not so important
  //                                   ),
  //                                   textAlign: TextAlign.center,
  //                                   //maxLines: 3,
  //                                   //controller: _controller1,
  //                                   onChanged: (text) {
  //                                     _controller1.text = text;
  //                                   })),
  //                           Expanded(
  //                               flex: 1,
  //                               child: AutoSizeText(
  //                                 msg,
  //                                 textAlign: TextAlign.center,
  //                                 style: const TextStyle(color: Colors.red),
  //                               )),
  //                           Flexible(
  //                             flex: 1,
  //                             child: Padding(
  //                               padding: const EdgeInsets.all(8.0),
  //                               child: HoverButton(
  //                                 //minWidth: 300,
  //                                 onpressed: () async {
  //                                   bool check =
  //                                       await dataBaseExists(_controller1.text);
  //                                   if (check) {
  //                                     setState(() {
  //                                       msg = "Name already exists";
  //                                     });
  //                                   } else if (_controller1.text.length < 5) {
  //                                     setState(() {
  //                                       msg = "Name too short";
  //                                     });
  //                                   } else {
  //                                     SaveDB(_controller1.text + ".db");
  //                                     closealert(context);
  //                                   }
  //                                 },
  //                                 hoverColor:
  //                                     const Color.fromARGB(255, 16, 82, 249),
  //                                 color: const Color.fromARGB(255, 17, 21, 24),
  //                                 hoverTextColor:
  //                                     const Color.fromARGB(255, 17, 21, 24),
  //                                 hoverShape: const OutlineInputBorder(
  //                                   borderSide: BorderSide(
  //                                       color: Color.fromARGB(255, 17, 21, 24),
  //                                       width: 5.0),
  //                                 ),
  //                                 shape: const OutlineInputBorder(
  //                                   borderSide: BorderSide(
  //                                       color: Color.fromARGB(255, 16, 82, 249),
  //                                       width: 5.0),
  //                                 ),
  //                                 textColor:
  //                                     const Color.fromARGB(255, 16, 82, 249),
  //                                 padding: const EdgeInsets.all(20.0),
  //                                 hoverPadding: const EdgeInsets.all(20.0),

  //                                 child: AutoSizeText(
  //                                   "Save",
  //                                   maxLines: 1,
  //                                   group: widget.group2,
  //                                   style: TextStyle(fontSize: 45),
  //                                   minFontSize: 10,
  //                                   maxFontSize: 45,
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                           Flexible(
  //                             flex: 1,
  //                             child: Padding(
  //                               padding: const EdgeInsets.all(8.0),
  //                               child: HoverButton(
  //                                 //minWidth: 300,
  //                                 onpressed: () {
  //                                   //SaveDB();
  //                                   setState(() {
  //                                     level = 0;
  //                                   });
  //                                 },
  //                                 hoverColor:
  //                                     const Color.fromARGB(255, 16, 82, 249),
  //                                 color: const Color.fromARGB(255, 17, 21, 24),
  //                                 hoverTextColor:
  //                                     const Color.fromARGB(255, 17, 21, 24),
  //                                 hoverShape: const OutlineInputBorder(
  //                                   borderSide: BorderSide(
  //                                       color: Color.fromARGB(255, 17, 21, 24),
  //                                       width: 5.0),
  //                                 ),
  //                                 shape: const OutlineInputBorder(
  //                                   borderSide: BorderSide(
  //                                       color: Color.fromARGB(255, 16, 82, 249),
  //                                       width: 5.0),
  //                                 ),
  //                                 textColor:
  //                                     const Color.fromARGB(255, 16, 82, 249),
  //                                 padding: const EdgeInsets.all(20.0),
  //                                 hoverPadding: const EdgeInsets.all(20.0),

  //                                 child: AutoSizeText(
  //                                   "Cancel",
  //                                   maxLines: 1,
  //                                   group: widget.group2,
  //                                   style: TextStyle(fontSize: 45),
  //                                   minFontSize: 10,
  //                                   maxFontSize: 45,
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //                       );
  //                     }
  //                     return const Text("error");
  //                   }),
  //                 ),
  //               )),
  //           insetPadding: EdgeInsets.zero,
  //           contentPadding: EdgeInsets.zero,
  //           clipBehavior: Clip.antiAliasWithSaveLayer,
  //         );
  //       });
  //     });

  Future<bool> dataBaseExists(String name) async {
    bool check = false;
    Directory appDir = await getApplicationDocumentsDirectory();
    Directory dir = Directory('${appDir.path}\\Atlantas\\DataBases');
    //final List<FileSystemEntity> entities = await dir.list().toList();
    //dir.listSync();
    final List<FileSystemEntity> entities = dir.listSync();
    entities.forEach((element) {
      if ((element.path
              .split('\\')
              .last
              .substring(0, element.path.split('\\').last.length - 3)) ==
          name) {
        check = true;
        return;
      }
    });
    return check;

    //return dir.listSync();
  }

  void closealert(BuildContext context) {
    Navigator.of(context).pop();
  }

  void savealert(
      BuildContext context, Items item, List<TextEditingController> controler) {
    for (var i = 0; i < item.item.length; i++) {
      // if (controler[i].text != "") {
      //   item.item[i].atribute = controler[i].text;
      // }
      item.item[i].atribute = controler[i].text;
    }
    setState(() {
      _updateList(textfromsearch);
    });
    Navigator.of(context).pop();
  }

  void createItem(BuildContext context, List<TextEditingController> controler,
      List<Items> itemlist, List<Attribute> listS) {
    Items item = Items();
    for (var i = 0; i < listS.length; i++) {
      item.addItems(listS[i].name.toString(), controler[i].text);
    }
    itemlist.add(item);
    setState(() {
      _updateList(textfromsearch);
    });
    Navigator.of(context).pop();
  }

  void deleteItem(
    BuildContext context,
    List<Items> itemlist,
    Items item,
    List<Items> dlist,
  ) {
    itemlist.remove(item);
    setState(() {
      _updateList(textfromsearch);
    });
    Navigator.of(context).pop();
  }

  int calculateAnimationTime(int times) {
    int temp = times * 80;
    if (temp > 800) {
      return 800;
    }
    return temp;
  }

  String? _controller;
  String? _controller2;

  Future openAttributeDialog(BuildContext context) => showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;

        //     List.generate(3, (i) => TextEditingController());
        List<MultiSelectItem<SelectItems>> selectable3 = [
          MultiSelectItem<SelectItems>(SelectItems(1, "null"), "null")
        ];
        bool needFix = false;
        int howManyFix = 0;

        int flexing = 1;

        TextEditingController _controller4 = TextEditingController();
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                side: BorderSide(
                    color: Color.fromARGB(255, 16, 82, 249), width: 5),
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        width: 5,
                        color: const Color.fromARGB(255, 16, 82, 249)),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                height: height * 0.3,
                width: width * 0.7,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Name :"),
                            Expanded(child: TextField(
                                //controller: _controller,
                                onChanged: (text) {
                              // setState(() {
                              //   flexing = 3;
                              // });
                              _controller = text;
                            })),
                            DropdownButton<String>(
                              value: widget.droptype,
                              icon: const Icon(Icons.arrow_downward),
                              elevation: 16,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 16, 82, 249)),
                              underline: Container(
                                height: 2,
                                color: const Color.fromARGB(255, 16, 82, 249),
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  if (newValue == 'MultiSelect') {
                                    flexing = 3;
                                  } else {
                                    flexing = 1;
                                  }
                                  widget.droptype = newValue!;
                                });
                              },
                              items: widget.typeList
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                //print(value);
                                if ((value == "Name" && indexes[0] != -1) ||
                                    (value == "Stock" && indexes[1] != -1) ||
                                    (value == "Image" && indexes[2] != -1)) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value,
                                        style: const TextStyle(
                                            color: Colors.grey)),
                                    onTap: () => null,
                                    enabled: false,
                                  );
                                }
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                            //Text("Default Value :"),
                            Expanded(
                              flex: flexing,
                              child: Builder(builder: (context) {
                                if (widget.droptype == "MultiSelect") {
                                  return Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            const Tooltip(
                                                child: Text("Values :"),
                                                message: "Seperate with ,"),
                                            Expanded(
                                                child: TextField(
                                              controller: _controller4,
                                            )),
                                            IconButton(
                                                onPressed: () {
                                                  _controller2 =
                                                      _controller4.text;
                                                  List<String> temp1 =
                                                      _controller4.text
                                                          .split(',');

                                                  if (temp1.isNotEmpty) {
                                                    //selectable3 = [];

                                                    setState(() {
                                                      //print(selectable3.length);
                                                      int templength =
                                                          selectable3.length;
                                                      // List<
                                                      //         MultiSelectItem<
                                                      //             SelectItems>>
                                                      //     selectable4 = [];
                                                      for (int i = 0;
                                                          i < templength;
                                                          i++) {
                                                        selectable3.removeAt(0);
                                                      }

                                                      temp1.asMap().forEach(
                                                          (key, value) {
                                                        // selectList.add(
                                                        //     SelectItems(
                                                        //         key + 1, value));
                                                        selectable3.add(
                                                            MultiSelectItem<
                                                                    SelectItems>(
                                                                SelectItems(
                                                                    key, value),
                                                                value));
                                                      });

                                                      needFix = true;

                                                      //;print(selectable4);
                                                      //selectable3 = selectable4;
                                                      //print(selectable3);
                                                    });
                                                  }

                                                  //print(_controller4.text);
                                                },
                                                icon: const Icon(Icons.refresh))
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: MultiSelectChipField(
                                          items: selectable3,
                                          initialValue: const [],
                                          title: const Text("Default Values"),
                                          headerColor:
                                              Colors.blue.withOpacity(0.5),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.blue, width: 1.8),
                                          ),
                                          selectedChipColor:
                                              Colors.blue.withOpacity(0.5),
                                          selectedTextStyle: TextStyle(
                                              color: Colors.blue[800]),
                                          onTap: (values) {
                                            if (needFix == false) {
                                              howManyFix = values.length;
                                            }

                                            if (needFix) {
                                              for (int i = 0;
                                                  i < howManyFix;
                                                  i++) {
                                                values.removeAt(0);
                                              }
                                              needFix = false;
                                              howManyFix = 0;
                                            }
                                            //print(values.length);
                                            String temp = "";
                                            SelectItems args;
                                            for (int i = 0;
                                                i < values.length;
                                                i++) {
                                              var element = values[i];
                                              args = element as SelectItems;
                                              if (i < values.length - 1) {
                                                temp += "${args.name},";
                                              } else {
                                                temp += args.name;
                                              }
                                            }

                                            _controller2 = temp;

                                            //print(_controller2);
                                            // selected =
                                            //     values as List<SelectItems>;
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                if (widget.droptype == "Stock") {
                                  return TextField(
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      //controller: _controller2,
                                      onChanged: (text) {
                                        _controller2 = text;
                                      });
                                }

                                return TextField(onChanged: (text) {
                                  _controller2 = text;
                                });
                              }),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: () {
                                  if (_controller != null &&
                                      _controller2 != null) {
                                    _updateAttributes(_controller.toString(),
                                        widget.droptype, _controller4.text);
                                    widget.listitems.forEach((element) {
                                      element.addItems(
                                          _controller!, _controller2);
                                    });
                                    _updateList(textfromsearch);
                                    widget.droptype = "TextField";
                                    closealert(context);
                                  }
                                },
                                child: const Text("Add Attribute")),
                            TextButton(
                                onPressed: () {
                                  widget.droptype = "TextField";
                                  closealert(context);
                                },
                                child: const Text("Cancel")),
                          ],
                        )
                      ],
                    ),
                  ),
                )),
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
          );
        });
      });

  // Future<void> saveXml(String path) async {
  //   final builder = XmlBuilder(optimizeNamespaces: false);
  //   builder.processing('xml', 'version="1.0"');
  //   builder.element('Shop', nest: () {
  //     for (var element in widget.listitems) {
  //       builder.element('Product', nest: () {
  //         element.item.forEach((item) {
  //           builder.element(item.name.toString(), nest: () {
  //             builder.text(item.atribute.toString());
  //           });
  //         });
  //       });
  //     }
  //   });
  //   final bookshelfXml = builder.buildDocument();
  //   //Directory appDir = await getApplicationDocumentsDirectory();
  //   File ourfile = File(path);
  //   await ourfile.writeAsString(bookshelfXml.toString());
  //   //debugPrint(appDir.path);
  // }

  // void SaveDB(String name) async {
  //   SQLHelper.dbDir = name;
  //   Database database = await SQLHelper.db();
  //   await SQLHelper.deleteTables(database);
  //   await SQLHelper.createTables(database);
  //   widget.listitems.asMap().forEach((key, value) {
  //     String jsonItems = jsonEncode(value.item);
  //     //var itemslisttemp = jsonDecode(jsonItems) as List;
  //     //print(itemslisttemp);
  //     // value.item =
  //     //   itemslisttemp.map((tagJson) => Attribute.fromJson(tagJson)).toList();
  //     SQLHelper.createItem(jsonItems);
  //   });
  //   //print(widget.listS);
  //   String jsonTypes = jsonEncode(widget.listS);
  //   SQLHelper.createType(jsonTypes);
  //   print('db is saved...');
  // }

  Future<void> SaveFB() async {
    CollectionReference temp = SQLHelper.userFB!.collection("Items");
    var snapshots = await temp.get();
    for (var doc in snapshots) {
      await doc.reference.delete();
    }
    CollectionReference temp5 = SQLHelper.userFB!.collection("Types");
    var snapshots2 = await temp5.get();
    for (var doc in snapshots2) {
      await doc.reference.delete();
    }

    //await temp.add({'Values': 'testing'});
    //await temp.
    //await temp.add({'Values': 'testing2'});
    //await temp5.add({'Values1': 'testing2'});
    //final productsCollection = await temp.get();
    //print("$productsCollection + testing");

    widget.listitems.asMap().forEach((key, value) async {
      String jsonItems = jsonEncode(value.item);
      //var itemslisttemp = jsonDecode(jsonItems) as List;
      //print(itemslisttemp);
      // value.item =
      //   itemslisttemp.map((tagJson) => Attribute.fromJson(tagJson)).toList();
      //SQLHelper.createItem(jsonItems);
      await temp.add({'Item': jsonItems});
    });

    String jsonTypes = jsonEncode(widget.listS);
    await temp5.add({'Types': jsonTypes});
    final temp6 = await temp5.get();
    //print(temp6.first.map.values);

    print("fb is saved...");
  }
}
