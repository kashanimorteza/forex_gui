//--------------------------------------------------------------------------------- location
// lib/models/model_os.dart

//--------------------------------------------------------------------------------- Description
// This is model for model_os

//--------------------------------------------------------------------------------- Import
import 'package:flutter/material.dart';

//--------------------------------------------------------------------------------- Global
typedef modelType = model_os;

//--------------------------------------------------------------------------------- Model
class model_os {
  //--------------------------------[Field]
  bool iphone;
  bool android;
  bool windows;
  bool linux;
  bool mac;
  late Map<String, dynamic> controllers;

  //--------------------------------[Contractor]
  model_os({
    this.iphone = false,
    this.android = false,
    this.windows = false,
    this.linux = false,
    this.mac = false,
  }) {
    controllers = {
      'iphone': ValueNotifier<bool>(iphone),
      'android': ValueNotifier<bool>(android),
      'windows': ValueNotifier<bool>(windows),
      'linux': ValueNotifier<bool>(linux),
      'mac': ValueNotifier<bool>(mac),
    };
  }

  //--------------------------------[getValueByKeys]
  dynamic getValueByKey(String key) => switch (key) {
        'iphone' => iphone,
        'android' => android,
        'windows' => windows,
        'linux' => linux,
        'mac' => mac,
        _ => null,
      };

  //--------------------------------[toModel]
  factory model_os.toModel(Map<String, dynamic> json) {
    return modelType(
      iphone: json['iphone'] as bool,
      android: json['android'] as bool,
      windows: json['windows'] as bool,
      linux: json['linux'] as bool,
      mac: json['mac'] as bool,
    );
  }

  //--------------------------------[toJson]
  Map<String, dynamic> toJson() {
    return {
      'iphone': iphone,
      'android': android,
      'windows': windows,
      'linux': linux,
      'mac': mac,
    };
  }

  //--------------------------------[get_model]
  modelType get_model() {
    return modelType(
      iphone: (controllers['iphone'] as ValueNotifier<bool>).value,
      android: (controllers['android'] as ValueNotifier<bool>).value,
      windows: (controllers['windows'] as ValueNotifier<bool>).value,
      linux: (controllers['linux'] as ValueNotifier<bool>).value,
      mac: (controllers['mac'] as ValueNotifier<bool>).value,
    );
  }

  //--------------------------------[controller_clear]
  void controller_clear() {
    controllers['iphone'].value = false;
    controllers['android'].value = false;
    controllers['windows'].value = false;
    controllers['linux'].value = false;
    controllers['mac'].value = false;
  }

  //--------------------------------[controller_get]
  dynamic controller_get(String name) => controllers[name];
}
