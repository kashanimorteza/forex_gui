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
  String profit;
  String count;
  String open_count;
  String close_count;
  String profit_min;
  String profit_max;
  String loss_min;
  String loss_max;
  late Map<String, dynamic> controllers;

  //--------------------------------[Contractor]
  model_back_order_detaile({
    this.step = '',
    this.date_from = '',
    this.date_to = '',
    this.profit = '',
    this.count = '',
    this.open_count = '',
    this.close_count = '',
    this.profit_min = '',
    this.profit_max = '',
    this.loss_min = '',
    this.loss_max = '',
  }) {
    controllers = {
      'step': TextEditingController(text: step),
      'date_from': TextEditingController(text: date_from),
      'date_to': TextEditingController(text: date_to),
      'profit': TextEditingController(text: profit),
      'count': TextEditingController(text: count),
      'open_count': TextEditingController(text: open_count),
      'close_count': TextEditingController(text: close_count),
      'profit_min': TextEditingController(text: profit_min),
      'profit_max': TextEditingController(text: profit_max),
      'loss_min': TextEditingController(text: loss_min),
      'loss_max': TextEditingController(text: loss_max),
    };
  }

  //--------------------------------[getValueByKeys]
  dynamic getValueByKey(String key) => switch (key) {
        'step' => step,
        'date_from' => date_from,
        'date_to' => date_to,
        'profit' => profit,
        'count' => count,
        'open_count' => open_count,
        'close_count' => close_count,
        'profit_min' => profit_min,
        'profit_max' => profit_max,
        'loss_min' => loss_min,
        'loss_max' => loss_max,
        _ => null,
      };

  //--------------------------------[toModel]
  factory model_back_order_detaile.toModel(Map<String, dynamic> json) {
    return modelType(
      step: json['step'].toString(),
      date_from: json['date_from'] as String?,
      date_to: json['date_to'] as String?,
      profit: json['profit'].toString(),
      count: json['count'].toString(),
      open_count: json['open_count'].toString(),
      close_count: json['close_count'].toString(),
      profit_min: json['profit_min'].toString(),
      profit_max: json['profit_max'].toString(),
      loss_min: json['loss_min'].toString(),
      loss_max: json['loss_max'].toString(),
    );
  }

  //--------------------------------[toJson]
  Map<String, dynamic> toJson() {
    return {
      'step': step,
      'date_from': date_from,
      'date_to': date_to,
      'profit': profit,
      'count': count,
      'open_count': open_count,
      'close_count': close_count,
      'profit_min': profit_min,
      'profit_max': profit_max,
      'loss_min': loss_min,
      'loss_max': loss_max,
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
