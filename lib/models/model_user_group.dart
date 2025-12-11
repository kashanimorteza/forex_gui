//--------------------------------------------------------------------------------- location
// lib/models/model_user_group.dart

//--------------------------------------------------------------------------------- Description
// This is model for group

//--------------------------------------------------------------------------------- Import
import 'dart:convert';
import 'package:flutter/material.dart';
import '../consts/general.dart';
import '../consts/model.dart';
import '../tools/api.dart';

//--------------------------------------------------------------------------------- Global
typedef modelType = model_user_group;
String api_route = models_api.group;

//--------------------------------------------------------------------------------- Model
class model_user_group {
  //--------------------------------[Field]
  int id;
  String name;
  String pre;
  String description;
  bool enable;
  int alarm_id;
  late Map<String, dynamic> controllers;

  //--------------------------------[Contractor]
  model_user_group({
    this.id = 1,
    this.name = '',
    this.pre = '',
    this.description = '',
    this.enable = true,
    this.alarm_id = 1,
  }) {
    controllers = {
      'id': TextEditingController(text: id.toString()),
      'name': TextEditingController(text: name),
      'pre': TextEditingController(text: pre),
      'description': TextEditingController(text: description),
      'enable': ValueNotifier<bool>(enable),
      'alarm_id': ValueNotifier<int>(alarm_id),
    };
  }

  //--------------------------------[getValueByKeys]
  dynamic getValueByKey(String key) => switch (key) {
        'id' => id,
        'name' => name,
        'pre' => pre,
        'description' => description,
        'enable' => enable,
        'alarm_id' => alarm_id,
        _ => null,
      };

  //--------------------------------[toModel]
  factory model_user_group.toModel(Map<String, dynamic> json) {
    return model_user_group(
      id: json['id'] as int,
      name: json['name'] as String,
      pre: json['pre'] as String,
      description: json['description'] as String,
      enable: json['enable'] as bool,
      alarm_id: json['alarm_id'] as int? ?? 1,
    );
  }

  //--------------------------------[toJson]
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'pre': pre,
        'description': description,
        'enable': enable,
        'alarm_id': alarm_id,
      };

  //--------------------------------[get_model]
  modelType get_model() {
    return modelType(
      id: int.tryParse(controllers['id'].text) ?? 0,
      name: controllers['name'].text,
      pre: controllers['pre'].text,
      description: controllers['description'].text,
      enable: (controllers['enable'] as ValueNotifier<bool>).value,
      alarm_id: (controllers['alarm_id'] as ValueNotifier<int>).value,
    );
  }

  //--------------------------------[controller_clear]
  void controller_clear() {
    controllers['id'].clear();
    controllers['name'].clear();
    controllers['pre'].clear();
    controllers['description'].clear();
    controllers['enable'].value = false;
    controllers['alarm_id'].value = 1;
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

  //--------------------------------[gi_items]
  gi_items(int id) async {
    MyApi api_mdl = new MyApi();
    var data = json.decode(await api_mdl.get('${const_api_url}/group_gi/item_group/$id'));
    List<dynamic> result = data['data'];
    return result;
  }

  //--------------------------------[gi_fill]
  gi_fill(int group_id, int item_id, bool enable) async {
    MyApi api_mdl = new MyApi();
    var data = {"group_id": group_id, "item_id": item_id, "enable": enable};
    var result = json.decode(await api_mdl.put('${const_api_url}/group_gi/fill', data));
    return result;
  }
}
