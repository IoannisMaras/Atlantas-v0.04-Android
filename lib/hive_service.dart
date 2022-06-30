library hive_service;
// https://stackoverflow.com/questions/12649573/how-do-you-build-a-singleton-in-dart

import 'package:flutter/foundation.dart';

import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class HiveService {
  // ###########################################################
  // ##              HiveService as Singleton class             ##
  // ###########################################################
  HiveService._(); // private constructor
  static final HiveService _instance = HiveService._();

  static HiveService get instance => _instance;
  static bool _hiveServiceInitialized = false;

  factory HiveService() {
    debugPrint('HiveService');
    // _instance.setHiveInitialVals();
    return _instance;
  }

  Future<bool> setHiveInitialVals() async {
    debugPrint('HIVESERVICE: ΕΦΑΡΜΟΓΗ ΑΡΧΙΚΩΝ ΤΙΜΩΝ ΣΤΗΝ SINGLETON CLASS');
    //await delay(1);
    if (Settings.isInitialized) {
      _hiveServiceInitialized = true;
      return true;
    } else {
      throw ('Αδυναμία εγγραφής δεδομένων HIVE');
    }
  }

  get isHiveOk {
    debugPrint('isHiveOk = $_hiveServiceInitialized');
    return _hiveServiceInitialized;
  }

  delay(int sec) async {
    //await Future.delayed(Duration(seconds: sec));
    debugPrint('Κλήση της delay για $sec δευτερόλεπτα');
  }

  // ###########################################################
  //                       KEY DESCRIPTIONS                   ##
  // ###########################################################

  // key_location              <bool>
  // key_camera                <bool>
  // key_manageExternalStorage <bool>
  // key_storage               <bool>
  // key_button_size           <double>
  // key_sound                 <bool>

  // counter : Ονομασία αρχείου βάσης δεδομένων

}
