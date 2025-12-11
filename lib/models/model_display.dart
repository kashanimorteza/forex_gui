//--------------------------------------------------------------------------------- location
// lib/models/model_display.dart

//--------------------------------------------------------------------------------- Description
// This is model for display

//--------------------------------------------------------------------------------- Import
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/consts/model.dart';
import 'package:mkpanel_gui/tools/api.dart';

//--------------------------------------------------------------------------------- Global
typedef modelType = model_display;
String api_route = models_api.display;

//--------------------------------------------------------------------------------- Model
class model_display {
  //--------------------------------[Field]
  int id;
  String name;
  String description;
  bool enable;
  late Map<String, dynamic> controllers;

  //--------------------------------[Contractor]
  model_display({
    this.id = 1,
    this.name = '',
    this.description = '',
    this.enable = false,
  }) {
    {
      controllers = {
        'id': TextEditingController(text: id.toString()),
        'name': TextEditingController(text: name),
        'description': TextEditingController(text: description),
        'enable': ValueNotifier<bool>(enable),
      };
    }
  }

  //--------------------------------[getValueByKeys]
  dynamic getValueByKey(String key) => switch (key) {
        'id' => id,
        'name' => name,
        'description' => description,
        'enable' => enable,
        _ => null,
      };

  //--------------------------------[toModel]
  factory model_display.toModel(Map<String, dynamic> json) {
    return modelType(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      enable: json['enable'] as bool,
    );
  }

  //--------------------------------[toJson]
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'enable': enable,
    };
  }

  //--------------------------------[get_model]
  modelType get_model() {
    return modelType(
      id: int.tryParse(controllers['id']?.text ?? '0') ?? 0,
      name: controllers['name']?.text ?? '',
      description: controllers['description']?.text ?? '',
      enable: (controllers['enable'] as ValueNotifier<bool>).value,
    );
  }

  //--------------------------------[controller_clear]
  void controller_clear() {
    controllers['id']?.clear();
    controllers['name']?.clear();
    controllers['description']?.clear();
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
      case 'display_items':
        var data1 = json.decode(await api_mdl.get('${const_api_url}/display_item/items'));
        List<dynamic> data2 = data1['data'];
        List<modelType> data3 = modelType.model_list(data2);
        return data3;
    }
  }

  //--------------------------------[gi_items]
  gi_items(int id) async {
    MyApi api_mdl = new MyApi();
    var data = json.decode(await api_mdl.get('${const_api_url}/display_gi/item_group/$id'));
    List<dynamic> result = data['data'];
    return result;
  }

  //--------------------------------[gi_fill]
  gi_fill(int group_id, int item_id, bool enable) async {
    MyApi api_mdl = new MyApi();
    var data = {"group_id": group_id, "item_id": item_id, "enable": enable};
    var result = json.decode(await api_mdl.put('${const_api_url}/display_gi/fill', data));
    return result;
  }
}
