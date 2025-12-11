//--------------------------------------------------------------------------------- Location
// lib/models/model_user_card.dart

//--------------------------------------------------------------------------------- Description
// This is model for model_user_card

//--------------------------------------------------------------------------------- Import
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/consts/model.dart';
import 'package:mkpanel_gui/tools/api.dart';

//--------------------------------------------------------------------------------- Global
typedef modelType = model_user_card;
String api_route = models_api.user_card;

//--------------------------------------------------------------------------------- Model
class model_user_card {
  //--------------------------------[Field]
  int id;
  int user_id;
  String card;
  late Map<String, dynamic> controllers;

  //--------------------------------[Constructor]
  model_user_card({
    this.id = 0,
    this.user_id = 0,
    this.card = '',
  }) {
    controllers = {
      'id': TextEditingController(text: id.toString()),
      'user_id': TextEditingController(text: user_id.toString()),
      'card': TextEditingController(text: card),
    };
  }

  //--------------------------------[getValueByKeys]
  dynamic getValueByKey(String key) => switch (key) {
        'id' => id,
        'user_id' => user_id,
        'card' => card,
        _ => null,
      };

  //--------------------------------[toModel]
  factory model_user_card.toModel(Map<String, dynamic> json) {
    return modelType(
      id: json['id'] as int,
      user_id: json['user_id'] as int,
      card: json['card'] as String,
    );
  }

  //--------------------------------[toJson]
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'card': card,
    };
  }

  //--------------------------------[get_model]
  modelType get_model() {
    return modelType(
      id: int.tryParse(controllers['id']?.text ?? '0') ?? 0,
      user_id: int.tryParse(controllers['user_id']?.text ?? '0') ?? 0,
      card: controllers['card']?.text ?? '',
    );
  }

  //--------------------------------[controller_clear]
  void controller_clear() {
    controllers['id']?.clear();
    controllers['user_id']?.clear();
    controllers['card']?.clear();
  }

  //--------------------------------[model_list]
  static List<modelType> model_list(List<dynamic> data) => data.map((item) => modelType.toModel(item as Map<String, dynamic>)).toList();

  //--------------------------------[controller_get]
  dynamic controller_get(String name) => controllers[name];

  //--------------------------------[Api]

  //----------[Add]
  add() async {
    MyApi api_mdl = new MyApi();
    modelType mdl = get_model();
    var mdl_json = mdl.toJson();
    var result = await api_mdl.post('${const_api_url}/${api_route}/add', mdl_json);
    result = json.decode(result);
    return result;
  }

  //----------[Update]
  update() async {
    MyApi api_mdl = new MyApi();
    modelType mdl = get_model();
    var mdl_json = mdl.toJson();
    var result = await api_mdl.put('${const_api_url}/${api_route}/update', mdl_json);
    result = json.decode(result);
    return result;
  }

  //----------[Delete]
  delete() async {
    MyApi api_mdl = new MyApi();
    modelType mdl = get_model();
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
    List<modelType> data4 = modelType.model_list(data3);
    return data4;
  }

  //----------[item]
  item(int id) async {
    MyApi api_mdl = new MyApi();
    var result = await api_mdl.get('${const_api_url}/${api_route}/item/$id');
    result = json.decode(result);
    List<dynamic> item_data = result['data'];
    List<modelType> item = modelType.model_list(item_data);
    return item;
  }
}
