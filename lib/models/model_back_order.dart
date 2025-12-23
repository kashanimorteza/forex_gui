//--------------------------------------------------------------------------------- location
// lib/models/model_back_order.dart

//--------------------------------------------------------------------------------- Description
// This is model for back_order

//--------------------------------------------------------------------------------- Import
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/consts/model.dart';
import 'package:mkpanel_gui/tools/api.dart';

//--------------------------------------------------------------------------------- Global
typedef modelType = model_back_order;
String api_route = models_api.back_order;

//--------------------------------------------------------------------------------- Model
class model_back_order {
  //--------------------------------[Field]
  int id;
  int execute_id;
  int count;
  int father_id;
  String? date_open;
  double price_open;
  String? date_close;
  double price_close;
  double profit;
  String status;
  String symbol;
  String action;
  int amount;
  double tp;
  double sl;
  double ask;
  double bid;
  int order_id;
  int trade_id;
  String? description;
  bool enable;
  late Map<String, dynamic> controllers;

  //--------------------------------[Contractor]
  model_back_order({
    this.id = 0,
    this.execute_id = 0,
    this.count = 1,
    this.father_id = 0,
    this.date_open,
    this.price_open = 0,
    this.date_close,
    this.price_close = 0,
    this.profit = 0,
    this.status = '',
    this.symbol = '',
    this.action = '',
    this.amount = 0,
    this.tp = 0,
    this.sl = 0,
    this.ask = 0,
    this.bid = 0,
    this.order_id = 0,
    this.trade_id = 0,
    this.description,
    this.enable = true,
  }) {
    controllers = {
      'id': TextEditingController(text: id.toString()),
      'execute_id': ValueNotifier<int>(execute_id),
      'count': TextEditingController(text: count.toString()),
      'father_id': TextEditingController(text: father_id.toString()),
      'date_open': TextEditingController(text: date_open ?? ''),
      'price_open': TextEditingController(text: price_open.toString()),
      'date_close': TextEditingController(text: date_close ?? ''),
      'price_close': TextEditingController(text: price_close.toString()),
      'profit': TextEditingController(text: profit.toString()),
      'status': TextEditingController(text: status),
      'symbol': TextEditingController(text: symbol),
      'action': TextEditingController(text: action),
      'amount': TextEditingController(text: amount.toString()),
      'tp': TextEditingController(text: tp.toString()),
      'sl': TextEditingController(text: sl.toString()),
      'ask': TextEditingController(text: ask.toString()),
      'bid': TextEditingController(text: bid.toString()),
      'order_id': TextEditingController(text: order_id.toString()),
      'trade_id': TextEditingController(text: trade_id.toString()),
      'description': TextEditingController(text: description ?? ''),
      'enable': ValueNotifier<bool>(enable),
    };
  }

  //--------------------------------[getValueByKeys]
  dynamic getValueByKey(String key) => switch (key) {
        'id' => id,
        'execute_id' => execute_id,
        'count' => count,
        'father_id' => father_id,
        'date_open' => date_open,
        'price_open' => price_open,
        'date_close' => date_close,
        'price_close' => price_close,
        'profit' => profit,
        'status' => status,
        'symbol' => symbol,
        'action' => action,
        'amount' => amount,
        'tp' => tp,
        'sl' => sl,
        'ask' => ask,
        'bid' => bid,
        'order_id' => order_id,
        'trade_id' => trade_id,
        'description' => description,
        'enable' => enable,
        _ => null,
      };

  //--------------------------------[toModel]
  factory model_back_order.toModel(Map<String, dynamic> json) {
    return modelType(
      id: json['id'] as int,
      execute_id: json['execute_id'] as int,
      count: json['count'] as int,
      father_id: json['father_id'] as int,
      date_open: json['date_open'] as String?,
      price_open: (json['price_open'] as num).toDouble(),
      date_close: json['date_close'] as String?,
      price_close: (json['price_close'] as num).toDouble(),
      profit: (json['profit'] as num).toDouble(),
      status: json['status'] as String,
      symbol: json['symbol'] as String,
      action: json['action'] as String,
      amount: json['amount'] as int,
      tp: (json['tp'] as num).toDouble(),
      sl: (json['sl'] as num).toDouble(),
      ask: (json['ask'] as num).toDouble(),
      bid: (json['bid'] as num).toDouble(),
      order_id: json['order_id'] as int,
      trade_id: json['trade_id'] as int,
      description: json['description'] as String?,
      enable: json['enable'] as bool,
    );
  }

  //--------------------------------[toJson]
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'execute_id': execute_id,
      'count': count,
      'father_id': father_id,
      'date_open': date_open,
      'price_open': price_open,
      'date_close': date_close,
      'price_close': price_close,
      'profit': profit,
      'status': status,
      'symbol': symbol,
      'action': action,
      'amount': amount,
      'tp': tp,
      'sl': sl,
      'ask': ask,
      'bid': bid,
      'order_id': order_id,
      'trade_id': trade_id,
      'description': description,
      'enable': enable,
    };
  }

  //--------------------------------[get_model]
  modelType get_model() {
    return modelType(
      id: int.tryParse(controllers['id']?.text ?? '0') ?? 0,
      execute_id: (controllers['execute_id'] as ValueNotifier<int>).value,
      count: int.tryParse(controllers['count']?.text ?? '1') ?? 1,
      father_id: int.tryParse(controllers['father_id']?.text ?? '0') ?? 0,
      date_open: controllers['date_open']?.text.isEmpty ?? true ? null : controllers['date_open']?.text,
      price_open: double.tryParse(controllers['price_open']?.text ?? '0') ?? 0,
      date_close: controllers['date_close']?.text.isEmpty ?? true ? null : controllers['date_close']?.text,
      price_close: double.tryParse(controllers['price_close']?.text ?? '0') ?? 0,
      profit: double.tryParse(controllers['profit']?.text ?? '0') ?? 0,
      status: controllers['status']?.text ?? '',
      symbol: controllers['symbol']?.text ?? '',
      action: controllers['action']?.text ?? '',
      amount: int.tryParse(controllers['amount']?.text ?? '0') ?? 0,
      tp: double.tryParse(controllers['tp']?.text ?? '0') ?? 0,
      sl: double.tryParse(controllers['sl']?.text ?? '0') ?? 0,
      ask: double.tryParse(controllers['ask']?.text ?? '0') ?? 0,
      bid: double.tryParse(controllers['bid']?.text ?? '0') ?? 0,
      order_id: int.tryParse(controllers['order_id']?.text ?? '0') ?? 0,
      trade_id: int.tryParse(controllers['trade_id']?.text ?? '0') ?? 0,
      description: controllers['description']?.text.isEmpty ?? true ? null : controllers['description']?.text,
      enable: (controllers['enable'] as ValueNotifier<bool>).value,
    );
  }

  //--------------------------------[controller_clear]
  void controller_clear() {
    controllers['id']?.clear();
    (controllers['execute_id'] as ValueNotifier<int>).value = 0;
    controllers['count']?.text = '1';
    controllers['father_id']?.clear();
    controllers['date_open']?.clear();
    controllers['price_open']?.clear();
    controllers['date_close']?.clear();
    controllers['price_close']?.clear();
    controllers['profit']?.clear();
    controllers['status']?.clear();
    controllers['symbol']?.clear();
    controllers['action']?.clear();
    controllers['amount']?.clear();
    controllers['tp']?.clear();
    controllers['sl']?.clear();
    controllers['ask']?.clear();
    controllers['bid']?.clear();
    controllers['order_id']?.clear();
    controllers['trade_id']?.clear();
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
        return json.decode(await api_mdl.get('${const_api_url}/${api_route}/${type}/${value}'));
    }
  }
}