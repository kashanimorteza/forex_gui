// lib/models/model_certificate.dart

//--------------------------------------------------------------------------------- Description
// This is model for certificate

//--------------------------------------------------------------------------------- Import
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/consts/model.dart';
import 'package:mkpanel_gui/tools/api.dart';

//--------------------------------------------------------------------------------- Global
typedef modelType = model_certificate;
String api_route = models_api.certificate;

//--------------------------------------------------------------------------------- Model
class model_certificate {
  //--------------------------------[Field]
  int id;
  String name;
  String sub;
  int domain_id;
  int server_id;
  String? description;
  bool enable;
  late Map<String, dynamic> controllers;

  //--------------------------------[Contractor]
  model_certificate({
    this.id = 0,
    this.name = '',
    this.sub = '',
    this.domain_id = 1,
    this.server_id = 1,
    this.description = '',
    this.enable = false,
  }) {
    controllers = {
      'id': TextEditingController(text: id.toString()),
      'name': TextEditingController(text: name),
      'sub': TextEditingController(text: sub),
      'domain_id': ValueNotifier<int>(domain_id),
      'server_id': ValueNotifier<int>(server_id),
      'description': TextEditingController(text: description ?? ''),
      'enable': ValueNotifier<bool>(enable),
    };
  }

  //--------------------------------[getValueByKeys]
  dynamic getValueByKey(String key) => switch (key) {
        'id' => id,
        'name' => name,
        'sub' => sub,
        'domain_id' => domain_id,
        'server_id' => server_id,
        'description' => description,
        'enable' => enable,
        _ => null,
      };

  //--------------------------------[toModel]
  factory model_certificate.toModel(Map<String, dynamic> json) {
    return modelType(
      id: json['id'] as int,
      name: json['name'] as String,
      sub: json['sub'] as String,
      domain_id: json['domain_id'] as int,
      server_id: json['server_id'] as int,
      description: json['description'] as String,
      enable: json['enable'] as bool,
    );
  }

  //--------------------------------[toJson]
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sub': sub,
      'domain_id': domain_id,
      'server_id': server_id,
      'description': description,
      'enable': enable,
    };
  }

  //--------------------------------[get_model]
  modelType get_model() {
    return modelType(
      id: int.tryParse(controllers['id'].text) ?? 0,
      name: controllers['name'].text,
      sub: controllers['sub'].text,
      domain_id: (controllers['domain_id'] as ValueNotifier<int>).value,
      server_id: (controllers['server_id'] as ValueNotifier<int>).value,
      description: controllers['description'].text,
      enable: (controllers['enable'] as ValueNotifier<bool>).value,
    );
  }

  //--------------------------------[controller_clear]
  void controller_clear() {
    controllers['id'].clear();
    controllers['name'].clear();
    controllers['sub'].clear();
    controllers['description'].clear();
    controllers['domain_id'].value = 1;
    controllers['server_id'].value = 1;
    controllers['enable'].value = false;
  }

  //--------------------------------[model_list]
  static List<modelType> model_list(List<dynamic> data) => data.map((item) => modelType.toModel(item as Map<String, dynamic>)).toList();

  //--------------------------------[controller_get]
  dynamic controller_get(String name) => controllers[name];

  //--------------------------------[Api]
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
      case 'add_domain':
        return json.decode(await api_mdl.get('${const_api_url}/${api_route}/add_domain'));
      case 'generate':
        return json.decode(await api_mdl.get('${const_api_url}/${api_route}/generate'));
    }
  }
}
