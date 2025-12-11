//--------------------------------------------------------------------------------- location
// lib/models/model_telegram.dart

//--------------------------------------------------------------------------------- Description
// This is model for model_telegram

//--------------------------------------------------------------------------------- Import
import 'package:flutter/material.dart';

//--------------------------------------------------------------------------------- Global
typedef modelType = model_telegram;

//--------------------------------------------------------------------------------- Model
class model_telegram {
  //--------------------------------[Field]
  String id;
  bool joinRobot;
  bool joinChannel;
  int sumOfMessage;
  late Map<String, dynamic> controllers;

  //--------------------------------[Contractor]
  model_telegram({
    this.id = '',
    this.joinRobot = false,
    this.joinChannel = false,
    this.sumOfMessage = 0,
  }) {
    controllers = {
      'id': TextEditingController(text: id),
      'joinRobot': ValueNotifier<bool>(joinRobot),
      'joinChannel': ValueNotifier<bool>(joinChannel),
      'sumOfMessage': TextEditingController(text: sumOfMessage.toString()),
    };
  }

  //--------------------------------[getValueByKeys]
  dynamic getValueByKey(String key) => switch (key) {
        'id' => id,
        'joinRobot' => joinRobot,
        'joinChannel' => joinChannel,
        'sumOfMessage' => sumOfMessage,
        _ => null,
      };

  //--------------------------------[toModel]
  factory model_telegram.toModel(Map<String, dynamic> json) {
    return modelType(
      id: json['id'] as String,
      joinRobot: json['joinRobot'] as bool,
      joinChannel: json['joinChannel'] as bool,
      sumOfMessage: json['sumOfMessage'] as int,
    );
  }

  //--------------------------------[toJson]
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'joinRobot': joinRobot,
      'joinChannel': joinChannel,
      'sumOfMessage': sumOfMessage,
    };
  }

  //--------------------------------[get_model]
  modelType get_model() {
    return modelType(
      id: controllers['id'].text,
      joinRobot: (controllers['joinRobot'] as ValueNotifier<bool>).value,
      joinChannel: (controllers['joinChannel'] as ValueNotifier<bool>).value,
      sumOfMessage: int.tryParse(controllers['sumOfMessage'].text) ?? 0,
    );
  }

  //--------------------------------[controller_clear]
  void controller_clear() {
    controllers['id'].clear();
    controllers['joinRobot'].value = false;
    controllers['joinChannel'].value = false;
    controllers['sumOfMessage'].clear();
  }

  //--------------------------------[controller_get]
  dynamic controller_get(String name) => controllers[name];
}
