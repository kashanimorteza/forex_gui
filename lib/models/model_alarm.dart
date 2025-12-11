//--------------------------------------------------------------------------------- Location
// lib/models/model_alarm.dart

//--------------------------------------------------------------------------------- Description
// This is model for alarm

//--------------------------------------------------------------------------------- Import
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/consts/model.dart';
import 'package:mkpanel_gui/tools/api.dart';

//--------------------------------------------------------------------------------- Global
typedef modelType = model_alarm;
String api_route = models_api.alarm;

//--------------------------------------------------------------------------------- Model : model_alarm_detaile
class model_alarm_detaile {
  int count;
  int limit;
  bool enable;
  model_alarm_detaile({this.count = 0, this.limit = 0, this.enable = false});
  dynamic getValueByKey(String key) => switch (key) { 'count' => count, 'limit' => limit, 'enable' => enable, _ => null };
  factory model_alarm_detaile.toModel(Map<String, dynamic> json) {
    return model_alarm_detaile(count: json['count'] ?? 0, limit: json['limit'] ?? 0, enable: json['enable'] ?? false);
  }
  Map<String, dynamic> toJson() => {'count': count, 'limit': limit, 'enable': enable};
}

//--------------------------------------------------------------------------------- Model : model_alarm
class model_alarm {
  //--------------------------------[Field]
  int id;
  String name;
  String? description;
  bool enable;
  late Map<String, dynamic> controllers;

  //--------------------------------[Contractor]
  model_alarm({
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
  factory model_alarm.toModel(Map<String, dynamic> json) {
    Map<String, model_alarm_detaile> membersMap = {};
    if (json['members'] != null) {
      (json['members'] as Map<String, dynamic>).forEach((key, value) {
        membersMap[key] = model_alarm_detaile.toModel(value as Map<String, dynamic>);
      });
    }
    return model_alarm(
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
  model_alarm get_model() {
    return model_alarm(
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
  static List<model_alarm> model_list(List<dynamic> data) => data.map((item) => model_alarm.toModel(item as Map<String, dynamic>)).toList();

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
      case 'alarm_items':
        var data1 = json.decode(await api_mdl.get('${const_api_url}/alarm_item/items'));
        List<dynamic> data2 = data1['data'];
        List<modelType> data3 = modelType.model_list(data2);
        return data3;
    }
  }

  //--------------------------------[gi_items]
  gi_items(int id) async {
    MyApi api_mdl = new MyApi();
    var data = json.decode(await api_mdl.get('${const_api_url}/alarm_gi/item_group/$id'));
    List<dynamic> result = data['data'];
    return result;
  }

  //--------------------------------[gi_fill]
  gi_fill(int group_id, int item_id, String item, dynamic value) async {
    MyApi api_mdl = new MyApi();
    var result = json.decode(await api_mdl.get('${const_api_url}/alarm_gi/fill?group_id=$group_id&item_id=$item_id&item=$item&value=$value'));
    return result;
  }
}
