//--------------------------------------------------------------------------------- Location
// lib/models/model_xray_plan.dart

//--------------------------------------------------------------------------------- Description
// This is model for v2ray service plan

//--------------------------------------------------------------------------------- Import
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/consts/model.dart';
import 'package:mkpanel_gui/tools/api.dart';

//--------------------------------------------------------------------------------- Global
typedef modelType = model_xray_plan;
String api_route = models_api.service_v2ray_plan;

//--------------------------------------------------------------------------------- Model
class model_xray_plan {
  //--------------------------------[Field]
  int id;
  String name;
  String? description;
  int period_limit;
  int validity_limit;
  int bandwith_limit;
  int price;
  bool enable;
  late Map<String, dynamic> controllers;

  //--------------------------------[Contractor]
  model_xray_plan({
    this.id = 0,
    this.name = '',
    this.description = '',
    this.period_limit = 0,
    this.validity_limit = 0,
    this.bandwith_limit = 0,
    this.price = 0,
    this.enable = true,
  }) {
    controllers = {
      'id': TextEditingController(text: id.toString()),
      'name': TextEditingController(text: name),
      'description': TextEditingController(text: description),
      'period_limit': TextEditingController(text: period_limit.toString()),
      'validity_limit': TextEditingController(text: validity_limit.toString()),
      'bandwith_limit': TextEditingController(text: bandwith_limit.toString()),
      'price': TextEditingController(text: price.toString()),
      'enable': ValueNotifier<bool>(enable),
    };
  }

  //--------------------------------[getValueByKey]
  dynamic getValueByKey(String key) => switch (key) {
        'id' => id,
        'name' => name,
        'description' => description,
        'period_limit' => period_limit,
        'validity_limit' => validity_limit,
        'bandwith_limit' => bandwith_limit,
        'price' => price,
        'enable' => enable,
        _ => null,
      };

  //--------------------------------[toModel]
  factory model_xray_plan.toModel(Map<String, dynamic> json) {
    return modelType(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      period_limit: json['period_limit'] as int,
      validity_limit: json['validity_limit'] as int,
      bandwith_limit: json['bandwith_limit'] as int,
      price: json['price'] as int,
      enable: json['enable'] as bool,
    );
  }

  //--------------------------------[toJson]
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'period_limit': period_limit,
      'validity_limit': validity_limit,
      'bandwith_limit': bandwith_limit,
      'price': price,
      'enable': enable,
    };
  }

  //--------------------------------[get_model]
  modelType get_model() {
    return modelType(
      id: int.tryParse(controllers['id']?.text ?? '0') ?? 0,
      name: controllers['name']?.text ?? '',
      description: controllers['description']?.text ?? '',
      period_limit: int.tryParse(controllers['period_limit']?.text ?? '0') ?? 0,
      validity_limit: int.tryParse(controllers['validity_limit']?.text ?? '0') ?? 0,
      bandwith_limit: int.tryParse(controllers['bandwith_limit']?.text ?? '0') ?? 0,
      price: int.tryParse(controllers['price']?.text ?? '0') ?? 0,
      enable: (controllers['enable'] as ValueNotifier<bool>).value,
    );
  }

  //--------------------------------[controller_clear]
  void controller_clear() {
    controllers['id']?.clear();
    controllers['name']?.clear();
    controllers['description']?.clear();
    controllers['period_limit']?.clear();
    controllers['validity_limit']?.clear();
    controllers['bandwith_limit']?.clear();
    controllers['price']?.clear();
    controllers['enable']?.value = false;
  }

  //--------------------------------[model_list]
  static List<modelType> model_list(List<dynamic> data) => data.map((item) => modelType.toModel(item as Map<String, dynamic>)).toList();

  //--------------------------------[controller_get]
  dynamic controller_get(String name) => controllers[name];

  //--------------------------------[Api]
  api(type) async {
    MyApi api_mdl = new MyApi();
    switch (type) {
      case 'add':
        return json.decode(await api_mdl.post('${const_api_url}/${api_route}/add', get_model().toJson()));
      case 'update':
        modelType mdl = get_model();
        return json.decode(await api_mdl.put('${const_api_url}/${api_route}/update', mdl.toJson()));
      case 'delete':
        return json.decode(await api_mdl.del('${const_api_url}/${api_route}/delete/${get_model().id}'));
      case 'item':
        var data1 = json.decode(await api_mdl.get('${const_api_url}/${api_route}/item/${id}'));
        List<dynamic> data2 = data1['data'];
        List<modelType> data3 = modelType.model_list(data2);
        return data3;
      case 'items':
        var data1 = json.decode(await api_mdl.get('${const_api_url}/${api_route}/items'));
        List<dynamic> data2 = data1['data'];
        List<modelType> data3 = modelType.model_list(data2);
        return data3;
    }
  }
}
