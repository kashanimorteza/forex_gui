//--------------------------------------------------------------------------------- location
// lib/models/model_live_execute.dart

//--------------------------------------------------------------------------------- Description
// This is model for live_execute

//--------------------------------------------------------------------------------- Import
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/consts/model.dart';
import 'package:mkpanel_gui/tools/api.dart';

//--------------------------------------------------------------------------------- Global
typedef modelType = model_live_execute;
String api_route = models_api.live_execute;

//--------------------------------------------------------------------------------- Model
class model_live_execute {
  //--------------------------------[Field]
  int id;
  String name;
  int strategy_item_id;
  int account_id;
  int step;
  String status;
  String? description;
  bool enable;
  late Map<String, dynamic> controllers;

  //--------------------------------[Contractor]
  model_live_execute({
    this.id = 0,
    this.name = '',
    this.strategy_item_id = 1,
    this.account_id = 1,
    this.step = 1,
    this.status = '',
    this.description = '',
    this.enable = true,
  }) {
    controllers = {
      'id': TextEditingController(text: id.toString()),
      'name': TextEditingController(text: name),
      'strategy_item_id': ValueNotifier<int>(strategy_item_id),
      'account_id': ValueNotifier<int>(account_id),
      'step': ValueNotifier<int>(step),
      'status': TextEditingController(text: status),
      'description': TextEditingController(text: description),
      'enable': ValueNotifier<bool>(enable),
    };
  }

  //--------------------------------[getValueByKeys]
  dynamic getValueByKey(String key) => switch (key) {
        'id' => id,
        'name' => name,
        'strategy_item_id' => strategy_item_id,
        'account_id' => account_id,
        'step' => step,
        'status' => status,
        'description' => description,
        'enable' => enable,
        _ => null,
      };

  //--------------------------------[toModel]
  factory model_live_execute.toModel(Map<String, dynamic> json) {
    return modelType(
      id: json['id'] as int,
      name: json['name'] as String,
      strategy_item_id: json['strategy_item_id'] as int,
      account_id: json['account_id'] as int,
      step: json['step'] as int? ?? 1,
      status: json['status'] as String,
      description: json['description'] as String?,
      enable: json['enable'] as bool,
    );
  }

  //--------------------------------[toJson]
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'strategy_item_id': strategy_item_id,
      'account_id': account_id,
      'step': step,
      'status': status,
      'description': description,
      'enable': enable,
    };
  }

  //--------------------------------[get_model]
  modelType get_model() {
    return modelType(
      id: int.tryParse(controllers['id']?.text ?? '0') ?? 0,
      name: controllers['name']?.text ?? '',
      strategy_item_id: (controllers['strategy_item_id'] as ValueNotifier<int>).value,
      account_id: (controllers['account_id'] as ValueNotifier<int>).value,
      step: (controllers['step'] as ValueNotifier<int>).value,
      status: controllers['status']?.text ?? '',
      description: controllers['description']?.text ?? '',
      enable: (controllers['enable'] as ValueNotifier<bool>).value,
    );
  }

  //--------------------------------[controller_clear]
  void controller_clear() {
    controllers['id']?.clear();
    controllers['name']?.clear();
    (controllers['strategy_item_id'] as ValueNotifier<int>).value = 1;
    (controllers['account_id'] as ValueNotifier<int>).value = 1;
    (controllers['step'] as ValueNotifier<int>).value = 1;
    controllers['status']?.clear();
    controllers['description']?.clear();
    controllers['enable']?.value = true;
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
