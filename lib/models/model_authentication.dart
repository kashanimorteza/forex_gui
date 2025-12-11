//--------------------------------------------------------------------------------- location
// lib/models/model_authentication.dart

//--------------------------------------------------------------------------------- Description
// This is model for model_authentication

//--------------------------------------------------------------------------------- Import
import 'package:flutter/material.dart';

//--------------------------------------------------------------------------------- Global
typedef modelType = model_authentication;

//--------------------------------------------------------------------------------- Model
class model_authentication {
  //--------------------------------[Field]
  String username;
  String password;
  String key;
  late Map<String, dynamic> controllers;

  //--------------------------------[Contractor]
  model_authentication({
    this.username = '',
    this.password = '',
    this.key = '',
  }) {
    controllers = {
      'username': TextEditingController(text: username),
      'password': TextEditingController(text: password),
      'key': TextEditingController(text: key),
    };
  }

  //--------------------------------[getValueByKeys]
  dynamic getValueByKey(String key) => switch (key) {
        'username' => username,
        'password' => password,
        'key' => key,
        _ => null,
      };

  //--------------------------------[toModel]
  factory model_authentication.toModel(Map<String, dynamic> json) {
    return modelType(
      username: json['username'] as String,
      password: json['password'] as String,
      key: json['key'] as String,
    );
  }

  //--------------------------------[toJson]
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'key': key,
    };
  }

  //--------------------------------[get_model]
  modelType get_model() {
    return modelType(
      username: controllers['username'].text,
      password: controllers['password'].text,
      key: controllers['key'].text,
    );
  }

  //--------------------------------[controller_clear]
  void controller_clear() {
    controllers['username'].clear();
    controllers['password'].clear();
    controllers['key'].clear();
  }

  //--------------------------------[controller_get]
  dynamic controller_get(String name) => controllers[name];
}
