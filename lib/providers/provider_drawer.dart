// lib/providers/drawer.dart

//----------------------------------------------- [ Description ]
/*

*/

//----------------------------------------------- [ Import ]
import 'package:flutter/material.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/consts/setting.dart';
import 'package:mkpanel_gui/tools/drawer.dart';

//----------------------------------------------- [ Provider_Setting ]
class Provider_Drawer with ChangeNotifier {
//----------[Fields]
  OSLists _os = OSLists.mac;
  DeviceLists _device = DeviceLists.desktop;
  Widget _drawer = DrawerDesktop();
  String _theme = 't1';

//----------[Get]
  OSLists get os => _os;
  DeviceLists get device => _device;
  Widget get drawer => _drawer;
  String get theme => _theme;

//----------[Set]
  set os(OSLists value) {
    _os = value;
    update();
  }

  set device(DeviceLists value) {
    _device = value;
    update();
  }

//----------[Method]
  Provider_Drawer({required OSLists os, required DeviceLists device}) {
    this._os = os;
    this._device = device;
    update();
  }

  void update() {
    this._theme = const_setting[_os][_device][SettingLists.theme];
    this._drawer = const_setting[_os][_device][SettingLists.drawer];
    notifyListeners();
  }
}
