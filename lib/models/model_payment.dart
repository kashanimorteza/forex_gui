//--------------------------------------------------------------------------------- location
// lib/models/model_payment.dart

//--------------------------------------------------------------------------------- Description
// This is model for model_payment

//--------------------------------------------------------------------------------- Import
import 'package:flutter/material.dart';

//--------------------------------------------------------------------------------- Global
typedef modelType = model_payment;

//--------------------------------------------------------------------------------- Model
class model_payment {
  //--------------------------------[Field]
  int id;
  String date;
  int amount;
  String type;
  int balance_befor;
  int balance_after;
  String data;
  late Map<String, dynamic> controllers;

  //--------------------------------[Contractor]
  model_payment({
    this.id = 0,
    this.date = '',
    this.amount = 0,
    this.type = '',
    this.balance_befor = 0,
    this.balance_after = 0,
    this.data = '',
  }) {
    controllers = {
      'id': TextEditingController(text: id.toString()),
      'date': TextEditingController(text: date),
      'amount': TextEditingController(text: amount.toString()),
      'type': TextEditingController(text: type),
      'balance_befor': TextEditingController(text: balance_befor.toString()),
      'balance_after': TextEditingController(text: balance_after.toString()),
      'data': TextEditingController(text: data),
    };
  }

  //--------------------------------[get]
  //static modelType get instance => modelType();

  //--------------------------------[getValueByKeys]
  dynamic getValueByKey(String key) => switch (key) {
        'id' => id,
        'date' => date,
        'amount' => amount,
        'type' => type,
        'balance_befor' => balance_befor,
        'balance_after' => balance_after,
        'data' => data,
        _ => null,
      };

  //--------------------------------[toModel]
  factory model_payment.toModel(Map<String, dynamic> json) {
    return modelType(
      id: json['id'] as int,
      date: json['date'] as String,
      amount: (json['amount'] is double) ? json['amount'].toInt() : json['amount'] as int,
      type: json['type'] as String,
      balance_befor: (json['balance_befor'] is double) ? json['balance_befor'].toInt() : json['balance_befor'] as int,
      balance_after: (json['balance_after'] is double) ? json['balance_after'].toInt() : json['balance_after'] as int,
      data: json['data'] as String,
    );
  }

  //--------------------------------[toJson]
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'amount': amount,
      'type': type,
      'balance_befor': balance_befor,
      'balance_after': balance_after,
      'data': data,
    };
  }

  //--------------------------------[get_model]
  modelType get_model() {
    return modelType(
      id: int.tryParse(controllers['id'].text) ?? 0,
      date: controllers['date'].text,
      amount: int.tryParse(controllers['amount'].text) ?? 0,
      type: controllers['type'].text,
      balance_befor: int.tryParse(controllers['balance_befor'].text) ?? 0,
      balance_after: int.tryParse(controllers['balance_after'].text) ?? 0,
      data: controllers['data'].text,
    );
  }

  //--------------------------------[controller_clear]
  void controller_clear() {
    controllers['id'].clear();
    controllers['date'].clear();
    controllers['amount'].clear();
    controllers['type'].clear();
    controllers['balance_befor'].clear();
    controllers['balance_after'].clear();
    controllers['data'].clear();
  }

  //--------------------------------[controller_get]
  dynamic controller_get(String name) => controllers[name];

  //--------------------------------[instance]
  modelType instance() => modelType();
}
