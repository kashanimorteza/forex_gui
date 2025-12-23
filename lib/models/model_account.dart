//--------------------------------------------------------------------------------- location
// lib/models/model_account.dart

//--------------------------------------------------------------------------------- Description
// This is model for account

//--------------------------------------------------------------------------------- Import
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/consts/model.dart';
import 'package:mkpanel_gui/tools/api.dart';

//--------------------------------------------------------------------------------- Global
typedef modelType = model_account;
String api_route = models_api.account;

//--------------------------------------------------------------------------------- Model
class model_account {
  //--------------------------------[Field]
  int id;
  String name;
  String broker;
  String type;
  String currency;
  String server;
  String username;
  String password;
  String? description;
  bool enable;
  late Map<String, dynamic> controllers;

  //--------------------------------[Contractor]
  model_account({
    this.id = 0,
    this.name = '',
    this.broker = 'FXCM',
    this.type = 'Demo',
    this.currency = 'USD',
    this.server = 'FXCM-GBPReal01',
    this.username = '',
    this.password = '',
    this.description = '',
    this.enable = true,
  }) {
    controllers = {
      'id': TextEditingController(text: id.toString()),
      'name': TextEditingController(text: name),
      'broker': TextEditingController(text: broker),
      'type': TextEditingController(text: type),
      'currency': TextEditingController(text: currency),
      'server': TextEditingController(text: server),
      'username': TextEditingController(text: username),
      'password': TextEditingController(text: password),
      'description': TextEditingController(text: description),
      'enable': ValueNotifier<bool>(enable),
    };
  }

  //--------------------------------[getValueByKeys]
  dynamic getValueByKey(String key) => switch (key) {
        'id' => id,
        'name' => name,
        'broker' => broker,
        'type' => type,
        'currency' => currency,
        'server' => server,
        'username' => username,
        'password' => password,
        'description' => description,
        'enable' => enable,
        _ => null,
      };

  //--------------------------------[toModel]
  factory model_account.toModel(Map<String, dynamic> json) {
    return modelType(
      id: json['id'] as int,
      name: json['name'] as String,
      broker: json['broker'] as String,
      type: json['type'] as String,
      currency: json['currency'] as String,
      server: json['server'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      description: json['description'] as String?,
      enable: json['enable'] as bool,
    );
  }

  //--------------------------------[toJson]
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'broker': broker,
      'type': type,
      'currency': currency,
      'server': server,
      'username': username,
      'password': password,
      'description': description,
      'enable': enable,
    };
  }

  //--------------------------------[get_model]
  modelType get_model() {
    return modelType(
      id: int.tryParse(controllers['id']?.text ?? '0') ?? 0,
      name: controllers['name']?.text ?? '',
      broker: controllers['broker']?.text ?? 'FXCM',
      type: controllers['type']?.text ?? 'Demo',
      currency: controllers['currency']?.text ?? 'USD',
      server: controllers['server']?.text ?? 'FXCM-GBPReal01',
      username: controllers['username']?.text ?? '',
      password: controllers['password']?.text ?? '',
      description: controllers['description']?.text ?? '',
      enable: (controllers['enable'] as ValueNotifier<bool>).value,
    );
  }

  //--------------------------------[controller_clear]
  void controller_clear() {
    controllers['id'] = TextEditingController(text: id.toString());
    controllers['name'] = TextEditingController(text: name);
    controllers['broker'] = TextEditingController(text: broker);
    controllers['type'] = TextEditingController(text: type);
    controllers['currency'] = TextEditingController(text: currency);
    controllers['server'] = TextEditingController(text: server);
    controllers['username'] = TextEditingController(text: username);
    controllers['password'] = TextEditingController(text: password);
    controllers['description'] = TextEditingController(text: description);
    controllers['enable'] = ValueNotifier<bool>(enable);
  }

  //--------------------------------[model_list]
  static List<modelType> model_list(List<dynamic> data) => data.map((item) => modelType.toModel(item as Map<String, dynamic>)).toList();

  //--------------------------------[controller_get]
  dynamic controller_get(String name) => controllers[name];

  //--------------------------------[Api]
  api(type, [var value]) async {
    value = value ?? '';
    MyApi api_mdl = new MyApi();
    switch (type) {
      case 'add':
        return json.decode(await api_mdl.post('${const_api_url}/${api_route}/add', get_model().toJson()));
      case 'update':
        return json.decode(await api_mdl.put('${const_api_url}/${api_route}', get_model().toJson()));
      case 'items':
        var data1 = json.decode(await api_mdl.get('${const_api_url}/${api_route}/items${value}'));
        List<dynamic> data2 = data1['data'];
        List<modelType> data3 = modelType.model_list(data2);
        return data3;
      case 'detaile':
        var data1 = json.decode(await api_mdl.get('${const_api_url}/${api_route}/${value}'));
        List<dynamic> data2 = data1['data'];
        List<modelType> data3 = modelType.model_list(data2);
        return data3;
      case 'delete':
        return json.decode(await api_mdl.del('${const_api_url}/${api_route}/${get_model().id}'));
      default:
        return json.decode(await api_mdl.get('${const_api_url}/${api_route}/${type}/${get_model().id}'));
    }
  }
}
