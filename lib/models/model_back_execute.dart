//--------------------------------------------------------------------------------- location
// lib/models/model_back_execute.dart

//--------------------------------------------------------------------------------- Description
// This is model for back_execute

//--------------------------------------------------------------------------------- Import
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/consts/model.dart';
import 'package:mkpanel_gui/tools/api.dart';

//--------------------------------------------------------------------------------- Global
typedef modelType = model_back_execute;
String api_route = models_api.back_execute;

//--------------------------------------------------------------------------------- Model
class model_back_execute {
  //--------------------------------[Field]
  int id;
  String name;
  int strategy_item_id;
  int account_id;
  String? date_from;
  String? date_to;
  String status;
  int step;
  String? description;
  bool enable;
  late Map<String, dynamic> controllers;

  //--------------------------------[Contractor]
  model_back_execute({
    this.id = 0,
    this.name = '',
    this.strategy_item_id = 1,
    this.account_id = 1,
    this.date_from,
    this.date_to,
    this.status = '',
    this.step = 1,
    this.description,
    this.enable = true,
  }) {
    controllers = {
      'id': TextEditingController(text: id.toString()),
      'name': TextEditingController(text: name),
      'strategy_item_id': ValueNotifier<int>(strategy_item_id),
      'account_id': ValueNotifier<int>(account_id),
      'date_from': TextEditingController(text: date_from ?? ''),
      'date_to': TextEditingController(text: date_to ?? ''),
      'status': TextEditingController(text: status),
      'step': TextEditingController(text: step.toString()),
      'description': TextEditingController(text: description ?? ''),
      'enable': ValueNotifier<bool>(enable),
    };
  }

  //--------------------------------[getValueByKeys]
  dynamic getValueByKey(String key) => switch (key) {
        'id' => id,
        'name' => name,
        'strategy_item_id' => strategy_item_id,
        'account_id' => account_id,
        'date_from' => date_from,
        'date_to' => date_to,
        'status' => status,
        'step' => step,
        'description' => description,
        'enable' => enable,
        _ => null,
      };

  //--------------------------------[toModel]
  factory model_back_execute.toModel(Map<String, dynamic> json) {
    return modelType(
      id: json['id'] as int,
      name: json['name'] as String,
      strategy_item_id: json['strategy_item_id'] as int,
      account_id: json['account_id'] as int,
      date_from: json['date_from'] as String?,
      date_to: json['date_to'] as String?,
      status: json['status'] as String,
      step: json['step'] as int,
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
      'date_from': date_from,
      'date_to': date_to,
      'status': status,
      'step': step,
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
      date_from: controllers['date_from']?.text.isEmpty ?? true ? null : controllers['date_from']?.text,
      date_to: controllers['date_to']?.text.isEmpty ?? true ? null : controllers['date_to']?.text,
      status: controllers['status']?.text ?? '',
      step: int.tryParse(controllers['step']?.text ?? '1') ?? 1,
      description: controllers['description']?.text.isEmpty ?? true ? null : controllers['description']?.text,
      enable: (controllers['enable'] as ValueNotifier<bool>).value,
    );
  }

  //--------------------------------[controller_clear]
  void controller_clear() {
    controllers['id']?.clear();
    controllers['name']?.clear();
    (controllers['strategy_item_id'] as ValueNotifier<int>).value = 1;
    (controllers['account_id'] as ValueNotifier<int>).value = 1;
    controllers['date_from']?.clear();
    controllers['date_to']?.clear();
    controllers['status']?.clear();
    controllers['step']?.text = '1';
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
