//--------------------------------------------------------------------------------- location
// lib/models/model_live_order.dart

//--------------------------------------------------------------------------------- Description
// This is model for live_order

//--------------------------------------------------------------------------------- Import
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/consts/model.dart';
import 'package:mkpanel_gui/tools/api.dart';

//--------------------------------------------------------------------------------- Global
typedef modelType = model_live_order;
String api_route = models_api.live_order;

//--------------------------------------------------------------------------------- Model
class model_live_order {
  //--------------------------------[Field]
  int id;
  String date;
  int execute_id;
  String order_id;
  String? trade_id;
  String symbol;
  String action;
  double amount;
  double bid;
  double ask;
  double tp;
  double sl;
  double profit;
  String status;
  String? description;
  bool enable;
  late Map<String, dynamic> controllers;

  //--------------------------------[Contractor]
  model_live_order({
    this.id = 0,
    this.date = '',
    this.execute_id = 0,
    this.order_id = '',
    this.trade_id,
    this.symbol = '',
    this.action = '',
    this.amount = 0,
    this.bid = 0,
    this.ask = 0,
    this.tp = 0,
    this.sl = 0,
    this.profit = 0,
    this.status = '',
    this.description = '',
    this.enable = true,
  }) {
    controllers = {
      'id': TextEditingController(text: id.toString()),
      'date': TextEditingController(text: date),
      'execute_id': ValueNotifier<int>(execute_id),
      'order_id': TextEditingController(text: order_id),
      'trade_id': TextEditingController(text: trade_id ?? ''),
      'symbol': TextEditingController(text: symbol),
      'action': TextEditingController(text: action),
      'amount': TextEditingController(text: amount.toString()),
      'bid': TextEditingController(text: bid.toString()),
      'ask': TextEditingController(text: ask.toString()),
      'tp': TextEditingController(text: tp.toString()),
      'sl': TextEditingController(text: sl.toString()),
      'profit': TextEditingController(text: profit.toString()),
      'status': TextEditingController(text: status),
      'description': TextEditingController(text: description),
      'enable': ValueNotifier<bool>(enable),
    };
  }

  //--------------------------------[getValueByKeys]
  dynamic getValueByKey(String key) => switch (key) {
        'id' => id,
        'date' => date,
        'execute_id' => execute_id,
        'order_id' => order_id,
        'trade_id' => trade_id,
        'symbol' => symbol,
        'action' => action,
        'amount' => amount,
        'bid' => bid,
        'ask' => ask,
        'tp' => tp,
        'sl' => sl,
        'profit' => profit,
        'status' => status,
        'description' => description,
        'enable' => enable,
        _ => null,
      };

  //--------------------------------[toModel]
  factory model_live_order.toModel(Map<String, dynamic> json) {
    return modelType(
      id: json['id'] as int,
      date: json['date'] as String,
      execute_id: json['execute_id'] as int,
      order_id: json['order_id'] as String,
      trade_id: json['trade_id'] as String?,
      symbol: json['symbol'] as String,
      action: json['action'] as String,
      amount: (json['amount'] as num).toDouble(),
      bid: (json['bid'] as num).toDouble(),
      ask: (json['ask'] as num).toDouble(),
      tp: (json['tp'] as num).toDouble(),
      sl: (json['sl'] as num).toDouble(),
      profit: (json['profit'] as num).toDouble(),
      status: json['status'] as String,
      description: json['description'] as String?,
      enable: json['enable'] as bool,
    );
  }

  //--------------------------------[toJson]
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'execute_id': execute_id,
      'order_id': order_id,
      'trade_id': trade_id,
      'symbol': symbol,
      'action': action,
      'amount': amount,
      'bid': bid,
      'ask': ask,
      'tp': tp,
      'sl': sl,
      'profit': profit,
      'status': status,
      'description': description,
      'enable': enable,
    };
  }

  //--------------------------------[get_model]
  modelType get_model() {
    return modelType(
      id: int.tryParse(controllers['id']?.text ?? '0') ?? 0,
      date: controllers['date']?.text ?? '',
      execute_id: (controllers['execute_id'] as ValueNotifier<int>).value,
      order_id: controllers['order_id']?.text ?? '',
      trade_id: controllers['trade_id']?.text.isEmpty ?? true ? null : controllers['trade_id']?.text,
      symbol: controllers['symbol']?.text ?? '',
      action: controllers['action']?.text ?? '',
      amount: double.tryParse(controllers['amount']?.text ?? '0') ?? 0,
      bid: double.tryParse(controllers['bid']?.text ?? '0') ?? 0,
      ask: double.tryParse(controllers['ask']?.text ?? '0') ?? 0,
      tp: double.tryParse(controllers['tp']?.text ?? '0') ?? 0,
      sl: double.tryParse(controllers['sl']?.text ?? '0') ?? 0,
      profit: double.tryParse(controllers['profit']?.text ?? '0') ?? 0,
      status: controllers['status']?.text ?? '',
      description: controllers['description']?.text ?? '',
      enable: (controllers['enable'] as ValueNotifier<bool>).value,
    );
  }

  //--------------------------------[controller_clear]
  void controller_clear() {
    controllers['id']?.clear();
    controllers['date']?.clear();
    (controllers['execute_id'] as ValueNotifier<int>).value = 0;
    controllers['order_id']?.clear();
    controllers['trade_id']?.clear();
    controllers['symbol']?.clear();
    controllers['action']?.clear();
    controllers['amount']?.clear();
    controllers['bid']?.clear();
    controllers['ask']?.clear();
    controllers['tp']?.clear();
    controllers['sl']?.clear();
    controllers['profit']?.clear();
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
      case 'detaile':
        var data1 = json.decode(await api_mdl.get('${const_api_url}/${api_route}/detaile${value}'));
        var data2 = data1['data'];
        return data2;
      case 'delete':
        return json.decode(await api_mdl.del('${const_api_url}/${api_route}/${get_model().id}'));
      default:
        return json.decode(await api_mdl.get('${const_api_url}/${api_route}/${type}/${get_model().id}'));
    }
  }
}
