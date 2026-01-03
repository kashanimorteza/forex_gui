//--------------------------------------------------------------------------------- location
// lib/models/model_profit_manager_item.dart

//--------------------------------------------------------------------------------- Description
// This is model for profit_manager_item

//--------------------------------------------------------------------------------- Import
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/consts/model.dart';
import 'package:mkpanel_gui/tools/api.dart';

//--------------------------------------------------------------------------------- Global
typedef modelType = model_profit_manager_item;
String api_route = models_api.profit_manager_item;

//--------------------------------------------------------------------------------- Model
class model_profit_manager_item {
  //--------------------------------[Field]
  int id;
  int profit_manager_id;
  String name;
  int value;
  int tp_value;
  int sl_value;
  String? description;
  bool enable;
  late Map<String, dynamic> controllers;

  //--------------------------------[Contractor]
  model_profit_manager_item({
    this.id = 0,
    this.profit_manager_id = 1,
    this.name = 'st-100',
    this.value = 100,
    this.tp_value = 0,
    this.sl_value = 0,
    this.description = '',
    this.enable = true,
  }) {
    controllers = {
      'id': TextEditingController(text: id.toString()),
      'profit_manager_id': ValueNotifier<int>(profit_manager_id),
      'name': TextEditingController(text: name),
      'value': TextEditingController(text: value.toString()),
      'tp_value': TextEditingController(text: tp_value.toString()),
      'sl_value': TextEditingController(text: sl_value.toString()),
      'description': TextEditingController(text: description ?? ''),
      'enable': ValueNotifier<bool>(enable),
    };
  }

  //--------------------------------[getValueByKeys]
  dynamic getValueByKey(String key) => switch (key) {
        'id' => id,
        'profit_manager_id' => profit_manager_id,
        'name' => name,
        'value' => value,
        'tp_value' => tp_value,
        'sl_value' => sl_value,
        'description' => description,
        'enable' => enable,
        _ => null,
      };

  //--------------------------------[toModel]
  factory model_profit_manager_item.toModel(Map<String, dynamic> json) {
    return modelType(
      id: json['id'] as int,
      profit_manager_id: json['profit_manager_id'] as int,
      name: json['name'] as String,
      value: json['value'] as int,
      tp_value: json['tp_value'] as int,
      sl_value: json['sl_value'] as int,
      description: json['description'] as String?,
      enable: json['enable'] as bool,
    );
  }

  //--------------------------------[toJson]
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profit_manager_id': profit_manager_id,
      'name': name,
      'value': value,
      'tp_value': tp_value,
      'sl_value': sl_value,
      'description': description,
      'enable': enable,
    };
  }

  //--------------------------------[get_model]
  modelType get_model() {
    return modelType(
      id: int.tryParse(controllers['id']?.text ?? '0') ?? 0,
      profit_manager_id: (controllers['profit_manager_id'] as ValueNotifier<int>).value,
      name: controllers['name']?.text ?? 'st-100',
      value: int.tryParse(controllers['value']?.text ?? '100') ?? 100,
      tp_value: int.tryParse(controllers['tp_value']?.text ?? '0') ?? 0,
      sl_value: int.tryParse(controllers['sl_value']?.text ?? '0') ?? 0,
      description: controllers['description']?.text.isEmpty ?? true ? null : controllers['description']?.text,
      enable: (controllers['enable'] as ValueNotifier<bool>).value,
    );
  }

  //--------------------------------[controller_clear]
  void controller_clear() {
    controllers['id']?.clear();
    (controllers['profit_manager_id'] as ValueNotifier<int>).value = 1;
    controllers['name']?.text = 'st-100';
    controllers['value']?.text = '100';
    controllers['tp_value']?.text = '0';
    controllers['sl_value']?.text = '0';
    controllers['description']?.clear();
    (controllers['enable'] as ValueNotifier<bool>).value = true;
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
      case 'delete':
        return json.decode(await api_mdl.del('${const_api_url}/${api_route}/${get_model().id}'));
      default:
        return json.decode(await api_mdl.get('${const_api_url}/${api_route}/${type}/${get_model().id}'));
    }
  }
}
