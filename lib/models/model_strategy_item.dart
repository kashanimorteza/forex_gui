//--------------------------------------------------------------------------------- location
// lib/models/model_strategy_item.dart

//--------------------------------------------------------------------------------- Description
// This is model for strategy_item

//--------------------------------------------------------------------------------- Import
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/consts/model.dart';
import 'package:mkpanel_gui/tools/api.dart';

//--------------------------------------------------------------------------------- Global
typedef modelType = model_strategy_item;
String api_route = models_api.strategy_item;

//--------------------------------------------------------------------------------- Model
class model_strategy_item {
  //--------------------------------[Field]
  int id;
  int strategy_id;
  String name;
  String symbols;
  String actions;
  double amount;
  int tp_pips;
  int sl_pips;
  double limit_profit;
  String params;
  String? description;
  bool enable;
  late Map<String, dynamic> controllers;

  //--------------------------------[Contractor]
  model_strategy_item({
    this.id = 0,
    this.strategy_id = 0,
    this.name = '',
    this.symbols = '',
    this.actions = '',
    this.amount = 0,
    this.tp_pips = 0,
    this.sl_pips = 0,
    this.limit_profit = 0,
    this.params = '',
    this.description = '',
    this.enable = true,
  }) {
    controllers = {
      'id': TextEditingController(text: id.toString()),
      'strategy_id': ValueNotifier<int>(strategy_id),
      'name': TextEditingController(text: name),
      'symbols': TextEditingController(text: symbols),
      'actions': TextEditingController(text: actions),
      'amount': TextEditingController(text: amount.toString()),
      'tp_pips': TextEditingController(text: tp_pips.toString()),
      'sl_pips': TextEditingController(text: sl_pips.toString()),
      'limit_profit': TextEditingController(text: limit_profit.toString()),
      'params': TextEditingController(text: params),
      'description': TextEditingController(text: description),
      'enable': ValueNotifier<bool>(enable),
    };
  }

  //--------------------------------[getValueByKeys]
  dynamic getValueByKey(String key) => switch (key) {
        'id' => id,
        'strategy_id' => strategy_id,
        'name' => name,
        'symbols' => symbols,
        'actions' => actions,
        'amount' => amount,
        'tp_pips' => tp_pips,
        'sl_pips' => sl_pips,
        'limit_profit' => limit_profit,
        'params' => params,
        'description' => description,
        'enable' => enable,
        _ => null,
      };

  //--------------------------------[toModel]
  factory model_strategy_item.toModel(Map<String, dynamic> json) {
    return modelType(
      id: json['id'] as int,
      strategy_id: json['strategy_id'] as int,
      name: json['name'] as String,
      symbols: json['symbols'] as String? ?? '',
      actions: json['actions'] as String? ?? '',
      amount: (json['amount'] as num).toDouble(),
      tp_pips: json['tp_pips'] as int,
      sl_pips: json['sl_pips'] as int,
      limit_profit: (json['limit_profit'] as num).toDouble(),
      params: json['params'] as String? ?? '',
      description: json['description'] as String?,
      enable: json['enable'] as bool,
    );
  }

  //--------------------------------[toJson]
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'strategy_id': strategy_id,
      'name': name,
      'symbols': symbols,
      'actions': actions,
      'amount': amount,
      'tp_pips': tp_pips,
      'sl_pips': sl_pips,
      'limit_profit': limit_profit,
      'params': params,
      'description': description,
      'enable': enable,
    };
  }

  //--------------------------------[get_model]
  modelType get_model() {
    return modelType(
      id: int.tryParse(controllers['id']?.text ?? '0') ?? 0,
      strategy_id: (controllers['strategy_id'] as ValueNotifier<int>).value,
      name: controllers['name']?.text ?? '',
      symbols: controllers['symbols']?.text ?? '',
      actions: controllers['actions']?.text ?? '',
      amount: double.tryParse(controllers['amount']?.text ?? '0') ?? 0,
      tp_pips: int.tryParse(controllers['tp_pips']?.text ?? '0') ?? 0,
      sl_pips: int.tryParse(controllers['sl_pips']?.text ?? '0') ?? 0,
      limit_profit: double.tryParse(controllers['limit_profit']?.text ?? '0') ?? 0,
      params: controllers['params']?.text ?? '',
      description: controllers['description']?.text.isEmpty ?? true ? null : controllers['description']?.text,
      enable: (controllers['enable'] as ValueNotifier<bool>).value,
    );
  } //--------------------------------[controller_clear]

  void controller_clear() {
    controllers['id'] = TextEditingController(text: id.toString());
    controllers['strategy_id'] = ValueNotifier<int>(strategy_id);
    controllers['name'] = TextEditingController(text: name);
    controllers['symbols'] = TextEditingController(text: symbols);
    controllers['actions'] = TextEditingController(text: actions);
    controllers['amount'] = TextEditingController(text: amount.toString());
    controllers['tp_pips'] = TextEditingController(text: tp_pips.toString());
    controllers['sl_pips'] = TextEditingController(text: sl_pips.toString());
    controllers['limit_profit'] = TextEditingController(text: limit_profit.toString());
    controllers['params'] = TextEditingController(text: params);
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
      case 'delete':
        return json.decode(await api_mdl.del('${const_api_url}/${api_route}/${get_model().id}'));
      default:
        return json.decode(await api_mdl.get('${const_api_url}/${api_route}/${type}/${get_model().id}'));
    }
  }
}
