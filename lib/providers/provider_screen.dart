// lib/providers/screen.dart

//----------------------------------------------- [ Description ]
/*

*/

//----------------------------------------------- [ Import ]
import 'package:flutter/material.dart';
import 'package:mkpanel_gui/consts/general.dart';

//----------------------------------------------- [ Provider_Screen ]
class Provider_Screen with ChangeNotifier {
  //----------[Fields]
  DeviceLists _device = DeviceLists.desktop;

  //----------[Get]
  DeviceLists get device => _device;

  //----------[Method]
  void updateScreenSize(double width) {
    if (width < 600) {
      _device = DeviceLists.mobile;
    } else if (width >= 600 && width < 1200) {
      _device = DeviceLists.tablet;
    } else {
      _device = DeviceLists.desktop;
    }
    //notifyListeners();
  }
}
