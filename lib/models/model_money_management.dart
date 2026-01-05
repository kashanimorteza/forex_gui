//--------------------------------------------------------------------------------- location
// lib/models/model_money_management.dart

//--------------------------------------------------------------------------------- Description
// This is model for money_management

//--------------------------------------------------------------------------------- Import
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/consts/model.dart';
import 'package:mkpanel_gui/tools/api.dart';

//--------------------------------------------------------------------------------- Global
typedef modelType = model_money_management;
String api_route = models_api.money_management;

//--------------------------------------------------------------------------------- Model
class model_money_management {
  //--------------------------------[Field]
  int id;
  String name;
  int balance;
  int risk;
  int limit_trade;
  int limit_profit;
  int limit_loss;
  String? description;
  bool enable;
  late Map<String, dynamic> controllers;

  //--------------------------------[Contractor]
  model_money_management({
    this.id = 0,
    this.name = '',
    this.balance = 1000,
    this.risk = 1,
    this.limit_trade = -1,
    this.limit_profit = -1,
    this.limit_loss = -1,
    this.description = '',
    this.enable = true,
  }) {
    controllers = {
      'id': TextEditingController(text: id.toString()),
      'name': TextEditingController(text: name),
      'balance': TextEditingController(text: balance.toString()),
      'risk': TextEditingController(text: risk.toString()),
      'limit_trade': TextEditingController(text: limit_trade.toString()),
      'limit_profit': TextEditingController(text: limit_profit.toString()),
      'limit_loss': TextEditingController(text: limit_loss.toString()),
      'description': TextEditingController(text: description ?? ''),
      'enable': ValueNotifier<bool>(enable),
    };
  }

  //--------------------------------[getValueByKeys]
  dynamic getValueByKey(String key) => switch (key) {
        'id' => id,
        'name' => name,
        'balance' => balance,
        'risk' => risk,
        'limit_trade' => limit_trade,
        'limit_profit' => limit_profit,
        'limit_loss' => limit_loss,
        'description' => description,
        'enable' => enable,
        _ => null,
      };

  //--------------------------------[toModel]
  factory model_money_management.toModel(Map<String, dynamic> json) {
    return modelType(
      id: json['id'] as int,
      name: json['name'] as String,
      balance: json['balance'] as int,
      risk: json['risk'] as int,
      limit_trade: json['limit_trade'] as int,
      limit_profit: json['limit_profit'] as int,
      limit_loss: json['limit_loss'] as int,
      description: json['description'] as String?,
      enable: json['enable'] as bool,
    );
  }

  //--------------------------------[toJson]
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'balance': balance,
      'risk': risk,
      'limit_trade': limit_trade,
      'limit_profit': limit_profit,
      'limit_loss': limit_loss,
      'description': description,
      'enable': enable,
    };
  }

  //--------------------------------[get_model]
  modelType get_model() {
    return modelType(
      id: int.tryParse(controllers['id']?.text ?? '0') ?? 0,
      name: controllers['name']?.text ?? '',
      balance: int.tryParse(controllers['balance']?.text ?? '1000') ?? 1000,
      risk: int.tryParse(controllers['risk']?.text ?? '1') ?? 1,
      limit_trade: int.tryParse(controllers['limit_trade']?.text ?? '-1') ?? -1,
      limit_profit: int.tryParse(controllers['limit_profit']?.text ?? '-1') ?? -1,
      limit_loss: int.tryParse(controllers['limit_loss']?.text ?? '-1') ?? -1,
      description: controllers['description']?.text.isEmpty ?? true ? null : controllers['description']?.text,
      enable: (controllers['enable'] as ValueNotifier<bool>).value,
    );
  }

  //--------------------------------[controller_clear]
  void controller_clear() {
    controllers['id']?.clear();
    controllers['name']?.clear();
    controllers['balance']?.text = '1000';
    controllers['risk']?.text = '1';
    controllers['limit_trade']?.text = '-1';
    controllers['limit_profit']?.text = '-1';
    controllers['limit_loss']?.text = '-1';
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
