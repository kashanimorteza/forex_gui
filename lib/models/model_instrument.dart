//--------------------------------------------------------------------------------- location
// lib/models/model_instrument.dart

//--------------------------------------------------------------------------------- Description
// This is model for instrument

//--------------------------------------------------------------------------------- Import
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/consts/model.dart';
import 'package:mkpanel_gui/tools/api.dart';

//--------------------------------------------------------------------------------- Global
typedef modelType = model_instrument;
String api_route = models_api.instrument;

//--------------------------------------------------------------------------------- Model
class model_instrument {
  //--------------------------------[Field]
  int id;
  String name;
  String instrument;
  int category;
  int priority;
  String? description;
  bool enable;
  late Map<String, dynamic> controllers;

  //--------------------------------[Contractor]
  model_instrument({
    this.id = 0,
    this.name = '',
    this.instrument = '',
    this.category = 0,
    this.priority = 0,
    this.description = '',
    this.enable = true,
  }) {
    controllers = {
      'id': TextEditingController(text: id.toString()),
      'name': TextEditingController(text: name),
      'instrument': TextEditingController(text: instrument),
      'category': TextEditingController(text: category.toString()),
      'priority': TextEditingController(text: priority.toString()),
      'description': TextEditingController(text: description),
      'enable': ValueNotifier<bool>(enable),
    };
  }

  //--------------------------------[getValueByKeys]
  dynamic getValueByKey(String key) => switch (key) {
        'id' => id,
        'name' => name,
        'instrument' => instrument,
        'category' => category,
        'priority' => priority,
        'description' => description,
        'enable' => enable,
        _ => null,
      };

  //--------------------------------[toModel]
  factory model_instrument.toModel(Map<String, dynamic> json) {
    return modelType(
      id: json['id'] as int,
      name: json['name'] as String,
      instrument: json['instrument'] as String,
      category: json['category'] as int,
      priority: json['priority'] as int,
      description: json['description'] as String?,
      enable: json['enable'] as bool,
    );
  }

  //--------------------------------[toJson]
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'instrument': instrument,
      'category': category,
      'priority': priority,
      'description': description,
      'enable': enable,
    };
  }

  //--------------------------------[get_model]
  modelType get_model() {
    return modelType(
      id: int.tryParse(controllers['id']?.text ?? '0') ?? 0,
      name: controllers['name']?.text ?? '',
      instrument: controllers['instrument']?.text ?? '',
      category: int.tryParse(controllers['category']?.text ?? '0') ?? 0,
      priority: int.tryParse(controllers['priority']?.text ?? '0') ?? 0,
      description: controllers['description']?.text ?? '',
      enable: (controllers['enable'] as ValueNotifier<bool>).value,
    );
  }

  //--------------------------------[controller_clear]
  void controller_clear() {
    controllers['id']?.clear();
    controllers['name']?.clear();
    controllers['instrument']?.clear();
    controllers['category']?.clear();
    controllers['priority']?.clear();
    controllers['description']?.clear();
    controllers['enable']?.value = true;
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
        return json.decode(await api_mdl.put('${const_api_url}/${api_route}', get_model().toJson()));
      case 'items':
        var data1 = json.decode(await api_mdl.get('${const_api_url}/${api_route}/items'));
        List<dynamic> data2 = data1['data'];
        List<modelType> data3 = modelType.model_list(data2);
        return data3;
      case 'delete':
        return json.decode(await api_mdl.del('${const_api_url}/${api_route}/${get_model().id}'));
      case 'enable':
        return json.decode(await api_mdl.get('${const_api_url}/${api_route}/enable/${get_model().id}'));
      case 'disable':
        return json.decode(await api_mdl.get('${const_api_url}/${api_route}/disable/${get_model().id}'));
      case 'status':
        return json.decode(await api_mdl.get('${const_api_url}/${api_route}/status/${get_model().id}'));
      case 'dead':
        return json.decode(await api_mdl.get('${const_api_url}/${api_route}/dead/${get_model().id}'));
    }
  }
}
