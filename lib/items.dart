import './attribute.dart';
import 'dart:async';

import 'package:path/path.dart';
import 'dart:convert';
//import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class Items {
  List<Attribute> item = [];

  Items() {
    item = [];
  }

  void addItems(String name, dynamic temp) {
    item.add(Attribute(name, temp));
  }

  bool exists(String name) {
    bool l = false;
    item.forEach((element) {
      if (element.toString() == name) {
        l = true;
        return;
      }
    });
    return l;
  }

  //factory Items.fromMap(Map<String,dynamic>json) => new Items ()
}
