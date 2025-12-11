//--------------------------------------------------------------------------------- Location
// lib/models/model_user_payment.dart

//--------------------------------------------------------------------------------- Description
// This is model for model_user_payment

//--------------------------------------------------------------------------------- Import
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/consts/model.dart';
import 'package:mkpanel_gui/tools/api.dart';

//--------------------------------------------------------------------------------- Global
String api_route = models_api.user_payment;

//--------------------------------------------------------------------------------- Model
class model_user_payment {
  //--------------------------------[Field]
  int id;
  int user_id;
  String date;
  int amount;
  String type;
  int balance_before;
  int balance_after;
  String? data;
  late Map<String, dynamic> controllers;

  //--------------------------------[Constructor]
  model_user_payment({
    this.id = 0,
    this.user_id = 0,
    this.date = '',
    this.amount = 0,
    this.type = 'in',
    this.balance_before = 0,
    this.balance_after = 0,
    this.data,
  }) {
    controllers = {
      'id': TextEditingController(text: id.toString()),
      'user_id': TextEditingController(text: user_id.toString()),
      'date': TextEditingController(text: date),
      'amount': TextEditingController(text: amount.toString()),
      'type': TextEditingController(text: type),
      'balance_before': TextEditingController(text: balance_before.toString()),
      'balance_after': TextEditingController(text: balance_after.toString()),
      'data': TextEditingController(text: data ?? ''),
    };
  }

  //--------------------------------[getValueByKeys]
  dynamic getValueByKey(String key) => switch (key) {
        'id' => id,
        'user_id' => user_id,
        'date' => date,
        'amount' => amount,
        'type' => type,
        'balance_before' => balance_before,
        'balance_after' => balance_after,
        'data' => data,
        _ => null,
      };

  //--------------------------------[toModel]
  factory model_user_payment.toModel(Map<String, dynamic> json) {
    return model_user_payment(
      id: json['id'] as int,
      user_id: json['user_id'] as int,
      date: json['date'] as String? ?? '',
      amount: json['amount'] as int,
      type: json['type'] as String? ?? 'in',
      balance_before: json['balance_before'] as int,
      balance_after: json['balance_after'] as int,
      data: json['data'] as String?,
    );
  }

  //--------------------------------[toJson]
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'date': date,
      'amount': amount,
      'type': type,
      'balance_before': balance_before,
      'balance_after': balance_after,
      'data': data,
    };
  }

  //--------------------------------[get_model]
  model_user_payment get_model() {
    return model_user_payment(
      id: int.tryParse(controllers['id']?.text ?? '0') ?? 0,
      user_id: int.tryParse(controllers['user_id']?.text ?? '0') ?? 0,
      date: controllers['date']?.text ?? '',
      amount: int.tryParse(controllers['amount']?.text ?? '0') ?? 0,
      type: controllers['type']?.text ?? 'in',
      balance_before: int.tryParse(controllers['balance_before']?.text ?? '0') ?? 0,
      balance_after: int.tryParse(controllers['balance_after']?.text ?? '0') ?? 0,
      data: controllers['data']?.text,
    );
  }

  //--------------------------------[controller_clear]
  void controller_clear() {
    controllers.forEach((key, controller) {
      controller.clear();
    });
  }

  //--------------------------------[model_list]
  static List<model_user_payment> model_list(List<dynamic> data) {
    return data.map((item) {
      return model_user_payment.toModel(item as Map<String, dynamic>);
    }).toList();
  }

  //--------------------------------[controller_get]
  dynamic controller_get(String name) => controllers[name];

  //--------------------------------[Api]
  //----------[Add]
  add() async {
    MyApi api_mdl = new MyApi();
    model_user_payment mdl = get_model();
    var mdl_json = mdl.toJson();
    var result = await api_mdl.post('${const_api_url}/${api_route}/add', mdl_json);
    result = json.decode(result);
    return result;
  }

  //----------[Update]
  update() async {
    MyApi api_mdl = new MyApi();
    model_user_payment mdl = get_model();
    var mdl_json = mdl.toJson();
    var result = await api_mdl.put('${const_api_url}/${api_route}/update', mdl_json);
    result = json.decode(result);
    return result;
  }

  //----------[Delete]
  delete() async {
    MyApi api_mdl = new MyApi();
    model_user_payment mdl = get_model();
    var model_id = mdl.id;
    var result = await api_mdl.del('${const_api_url}/${api_route}/delete/$model_id');
    result = json.decode(result);
    return result;
  }

  //----------[items]
  items([int user_id = 0]) async {
    MyApi api_mdl = new MyApi();
    var param = user_id > 0 ? "?user_id=$user_id" : "";
    var data1 = await api_mdl.get('${const_api_url}/${api_route}/items$param');
    var data2 = json.decode(data1);
    List<dynamic> data3 = data2['data'];
    List<model_user_payment> data4 = model_user_payment.model_list(data3);
    return data4;
  }

  //----------[item]
  item(int id) async {
    MyApi api_mdl = new MyApi();
    var result = await api_mdl.get('${const_api_url}/${api_route}/item/$id');
    result = json.decode(result);
    List<dynamic> item_data = result['data'];
    List<model_user_payment> item = model_user_payment.model_list(item_data);
    return item;
  }
}
