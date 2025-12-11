//--------------------------------------------------------------------------------- location
// lib/models/model_server.dart

//--------------------------------------------------------------------------------- Description
// This is model for server

//--------------------------------------------------------------------------------- Import
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/consts/model.dart';
import 'package:mkpanel_gui/tools/api.dart';

//--------------------------------------------------------------------------------- Global
typedef modelType = model_server;
String api_route = models_api.server;

//--------------------------------------------------------------------------------- Model
class model_server {
  //--------------------------------[Field]
  int id;
  String name;
  String ipv4;
  String? ipv6;
  String? description;
  bool enable;
  late Map<String, dynamic> controllers;

  //--------------------------------[Contractor]
  model_server({
    this.id = 0,
    this.name = '',
    this.ipv4 = '',
    this.ipv6 = '',
    this.description = '',
    this.enable = true,
  }) {
    controllers = {
      'id': TextEditingController(text: id.toString()),
      'name': TextEditingController(text: name),
      'ipv4': TextEditingController(text: ipv4),
      'ipv6': TextEditingController(text: ipv6),
      'description': TextEditingController(text: description),
      'enable': ValueNotifier<bool>(enable),
    };
  }

  //--------------------------------[getValueByKeys]
  dynamic getValueByKey(String key) => switch (key) {
        'id' => id,
        'name' => name,
        'ipv4' => ipv4,
        'ipv6' => ipv6,
        'description' => description,
        'enable' => enable,
        _ => null,
      };

  //--------------------------------[toModel]
  factory model_server.toModel(Map<String, dynamic> json) {
    return modelType(
      id: json['id'] as int,
      name: json['name'] as String,
      ipv4: json['ipv4'] as String,
      ipv6: json['ipv6'] as String,
      description: json['description'] as String,
      enable: json['enable'] as bool,
    );
  }

  //--------------------------------[toJson]
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'ipv4': ipv4,
      'ipv6': ipv6,
      'description': description,
      'enable': enable,
    };
  }

  //--------------------------------[get_model]
  modelType get_model() {
    return modelType(
      id: int.tryParse(controllers['id']?.text ?? '0') ?? 0,
      name: controllers['name']?.text ?? '',
      ipv4: controllers['ipv4']?.text ?? '',
      ipv6: controllers['ipv6']?.text ?? '',
      description: controllers['description']?.text ?? '',
      enable: (controllers['enable'] as ValueNotifier<bool>).value,
    );
  }

  //--------------------------------[controller_clear]
  void controller_clear() {
    controllers['id']?.clear();
    controllers['name']?.clear();
    controllers['ipv4']?.clear();
    controllers['ipv6']?.clear();
    controllers['description']?.clear();
    controllers['enable']?.value = false;
  }

  //--------------------------------[model_list]
  static List<modelType> model_list(List<dynamic> data) => data.map((item) => modelType.toModel(item as Map<String, dynamic>)).toList();

  //--------------------------------[controller_get]
  dynamic controller_get(String name) => controllers[name];

  //--------------------------------[Api]
  api(type) async {
    MyApi api_mdl = new MyApi();
    switch (type) {
      case 'add':
        return json.decode(await api_mdl.post('${const_api_url}/${api_route}/add', get_model().toJson()));
      case 'update':
        modelType mdl = get_model();
        return json.decode(await api_mdl.put('${const_api_url}/${api_route}/update', mdl.toJson()));
      case 'delete':
        return json.decode(await api_mdl.del('${const_api_url}/${api_route}/delete/${get_model().id}'));
      case 'item':
        var data1 = json.decode(await api_mdl.get('${const_api_url}/${api_route}/item/${id}'));
        List<dynamic> data2 = data1['data'];
        List<modelType> data3 = modelType.model_list(data2);
        return data3;
      case 'items':
        var data1 = json.decode(await api_mdl.get('${const_api_url}/${api_route}/items'));
        List<dynamic> data2 = data1['data'];
        List<modelType> data3 = modelType.model_list(data2);
        return data3;
    }
  }
}
