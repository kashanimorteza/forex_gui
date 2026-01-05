//--------------------------------------------------------------------------------- location
// lib/models/model_back_order_detaile.dart

//--------------------------------------------------------------------------------- Description
// This is model for back_order_detaile

//--------------------------------------------------------------------------------- Import
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/consts/model.dart';
import 'package:mkpanel_gui/tools/api.dart';

//--------------------------------------------------------------------------------- Global
typedef modelType = model_back_order_detaile;
String api_route = models_api.back_order_detaile;

//--------------------------------------------------------------------------------- Model
class model_back_order_detaile {
  //--------------------------------[Field]
  String step;
  String? date_from;
  String? date_to;
  String trade_all;
  String trade_open;
  String trade_close;
  String trade_buy;
  String trade_sell;
  String profit_all;
  String profit_positive;
  String profit_negative;
  String profit_close_min;
  String profit_close_max;
  String profit_open_min;
  String profit_open_max;
  String profit_min;
  String profit_max;
  String param;
  late Map<String, dynamic> controllers;

  //--------------------------------[Contractor]
  model_back_order_detaile({
    this.step = '',
    this.date_from = '',
    this.date_to = '',
    this.trade_all = '',
    this.trade_open = '',
    this.trade_close = '',
    this.trade_buy = '',
    this.trade_sell = '',
    this.profit_all = '',
    this.profit_positive = '',
    this.profit_negative = '',
    this.profit_close_min = '',
    this.profit_close_max = '',
    this.profit_open_min = '',
    this.profit_open_max = '',
    this.profit_min = '',
    this.profit_max = '',
    this.param = '',
  }) {
    controllers = {
      'step': TextEditingController(text: step),
      'date_from': TextEditingController(text: date_from),
      'date_to': TextEditingController(text: date_to),
      'trade_all': TextEditingController(text: trade_all),
      'trade_open': TextEditingController(text: trade_open),
      'trade_close': TextEditingController(text: trade_close),
      'trade_buy': TextEditingController(text: trade_buy),
      'trade_sell': TextEditingController(text: trade_sell),
      'profit_all': TextEditingController(text: profit_all),
      'profit_positive': TextEditingController(text: profit_positive),
      'profit_negative': TextEditingController(text: profit_negative),
      'profit_close_min': TextEditingController(text: profit_close_min),
      'profit_close_max': TextEditingController(text: profit_close_max),
      'profit_open_min': TextEditingController(text: profit_open_min),
      'profit_open_max': TextEditingController(text: profit_open_max),
      'profit_min': TextEditingController(text: profit_min),
      'profit_max': TextEditingController(text: profit_max),
      'param': TextEditingController(text: param),
    };
  }

  //--------------------------------[getValueByKeys]
  dynamic getValueByKey(String key) => switch (key) {
        'step' => step,
        'date_from' => date_from,
        'date_to' => date_to,
        'trade_all' => trade_all,
        'trade_open' => trade_open,
        'trade_close' => trade_close,
        'trade_buy' => trade_buy,
        'trade_sell' => trade_sell,
        'profit_all' => profit_all,
        'profit_positive' => profit_positive,
        'profit_negative' => profit_negative,
        'profit_close_min' => profit_close_min,
        'profit_close_max' => profit_close_max,
        'profit_open_min' => profit_open_min,
        'profit_open_max' => profit_open_max,
        'profit_min' => profit_min,
        'profit_max' => profit_max,
        'param' => param,
        _ => null,
      };

  //--------------------------------[toModel]
  factory model_back_order_detaile.toModel(Map<String, dynamic> json) {
    return modelType(
      step: json['step'].toString(),
      date_from: json['date_from'] as String?,
      date_to: json['date_to'] as String?,
      trade_all: json['trade_all'].toString(),
      trade_open: json['trade_open'].toString(),
      trade_close: json['trade_close'].toString(),
      trade_buy: json['trade_buy'].toString(),
      trade_sell: json['trade_sell'].toString(),
      profit_all: json['profit_all'].toString(),
      profit_positive: json['profit_positive'].toString(),
      profit_negative: json['profit_negative'].toString(),
      profit_close_min: json['profit_close_min'].toString(),
      profit_close_max: json['profit_close_max'].toString(),
      profit_open_min: json['profit_open_min'].toString(),
      profit_open_max: json['profit_open_max'].toString(),
      profit_min: json['profit_min'].toString(),
      profit_max: json['profit_max'].toString(),
      param: json['param'].toString(),
    );
  }

  //--------------------------------[toJson]
  Map<String, dynamic> toJson() {
    return {
      'step': step,
      'date_from': date_from,
      'date_to': date_to,
      'trade_all': trade_all,
      'trade_open': trade_open,
      'trade_close': trade_close,
      'trade_buy': trade_buy,
      'trade_sell': trade_sell,
      'profit_all': profit_all,
      'profit_positive': profit_positive,
      'profit_negative': profit_negative,
      'profit_close_min': profit_close_min,
      'profit_close_max': profit_close_max,
      'profit_open_min': profit_open_min,
      'profit_open_max': profit_open_max,
      'profit_min': profit_min,
      'profit_max': profit_max,
      'param': param,
    };
  }

  //--------------------------------[model_list]
  static List<modelType> model_list(List<dynamic> data) => data.map((item) => modelType.toModel(item as Map<String, dynamic>)).toList();

  //--------------------------------[Api]
  api(type, [var value]) async {
    value = value ?? '';
    MyApi api_mdl = new MyApi();
    switch (type) {
      case 'action_detaile':
        var data1 = json.decode(await api_mdl.get('${const_api_url}/${api_route}/${type}/${value}'));
        List<dynamic> data2 = data1['data'];
        List<modelType> data3 = modelType.model_list(data2);
        return data3;
    }
  }
}
