//import 'dart:ffi';

class Attribute {
  String? name;
  //int? _index;
  //1=String , 2=Int, 3=Bool
  var atribute;

  Attribute(this.name, dynamic temp) {
    atribute = temp;
    // if (temp is String) {
    //   _index = 1;
    // } else if (temp is int) {
    //   _index = 2;
    // } else {
    //   _index = 3;
    // }
  }

  Map toJson() => {'name': name, 'atribute': atribute};
  factory Attribute.fromJson(dynamic json) {
    return Attribute(json['name'] as String, json['atribute'] as String);
  }

  @override
  String toString() {
    return '{ ${this.name}, ${this.atribute} }';
  }

  //set name(n) => _name = n;
  //get name => _name;
}
