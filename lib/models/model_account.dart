//--------------------------------------------------------------------------------- location
// lib/models/model_account.dart

//--------------------------------------------------------------------------------- Description
// This is model for model_account

//--------------------------------------------------------------------------------- Import
import 'package:flutter/material.dart';

//--------------------------------------------------------------------------------- Global
typedef modelType = model_account;

//--------------------------------------------------------------------------------- Model
class model_account {
  //--------------------------------[Field]
  int group_id;
  int father_id;
  String username;
  String name;
  String email;
  String phone;
  bool enable;
  bool delete;
  bool display;
  bool trusted;
  String register_date;
  late Map<String, dynamic> controllers;

  //--------------------------------[Contractor]
  model_account({
    this.group_id = 1,
    this.father_id = 1,
    this.username = '',
    this.name = '',
    this.email = '',
    this.phone = '',
    this.enable = true,
    this.delete = false,
    this.display = true,
    this.trusted = false,
    this.register_date = '',
  }) {
    controllers = {
      'group_id': ValueNotifier<int>(group_id),
      'father_id': TextEditingController(text: father_id.toString()),
      'username': TextEditingController(text: username),
      'name': TextEditingController(text: name),
      'email': TextEditingController(text: email),
      'phone': TextEditingController(text: phone),
      'enable': ValueNotifier<bool>(enable),
      'delete': ValueNotifier<bool>(delete),
      'display': ValueNotifier<bool>(display),
      'trusted': ValueNotifier<bool>(trusted),
      'register_date': TextEditingController(text: register_date),
    };
  }

  //--------------------------------[getValueByKeys]
  dynamic getValueByKey(String key) => switch (key) {
        'group_id' => group_id,
        'father_id' => father_id,
        'username' => username,
        'name' => name,
        'email' => email,
        'phone' => phone,
        'enable' => enable,
        'delete' => delete,
        'display' => display,
        'trusted' => trusted,
        'register_date' => register_date,
        _ => null,
      };

  //--------------------------------[toModel]
  factory model_account.toModel(Map<String, dynamic> json) {
    return modelType(
      group_id: json['group_id'] as int,
      father_id: json['father_id'] as int,
      username: json['username'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      enable: json['enable'] as bool,
      delete: json['delete'] as bool,
      display: json['display'] as bool,
      trusted: json['trusted'] as bool,
      register_date: json['register_date'] as String,
    );
  }

  //--------------------------------[toJson]
  Map<String, dynamic> toJson() {
    return {
      'group_id': group_id,
      'father_id': father_id,
      'username': username,
      'name': name,
      'email': email,
      'phone': phone,
      'enable': enable,
      'delete': delete,
      'display': display,
      'trusted': trusted,
      'register_date': register_date,
    };
  }

  //--------------------------------[get_model]
  modelType get_model() {
    return modelType(
      group_id: (controllers['group_id'] as ValueNotifier<int>).value,
      father_id: int.parse(controllers['father_id'].text),
      username: controllers['username'].text,
      name: controllers['name'].text,
      email: controllers['email'].text,
      phone: controllers['phone'].text,
      enable: (controllers['enable'] as ValueNotifier<bool>).value,
      delete: (controllers['delete'] as ValueNotifier<bool>).value,
      display: (controllers['display'] as ValueNotifier<bool>).value,
      trusted: (controllers['trusted'] as ValueNotifier<bool>).value,
      register_date: controllers['register_date'].text,
    );
  }

  //--------------------------------[controller_clear]
  void controller_clear() {
    controllers['group_id'].value = 1;
    controllers['father_id'].value = 1;
    controllers['username'].clear();
    controllers['name'].clear();
    controllers['email'].clear();
    controllers['phone'].clear();
    controllers['enable'].value = true;
    controllers['delete'].value = false;
    controllers['display'].value = true;
    controllers['trusted'].value = false;
    controllers['register_date'].clear();
  }

  //--------------------------------[controller_get]
  dynamic controller_get(String name) => controllers[name];
}
