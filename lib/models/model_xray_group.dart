//--------------------------------------------------------------------------------- location
// lib/models/model_xray_group.dart

//--------------------------------------------------------------------------------- Description
// This is model for model_xray_group

//--------------------------------------------------------------------------------- Import
import 'dart:convert';
import 'package:flutter/material.dart';
import '../consts/general.dart';
import '../consts/model.dart';
import '../tools/api.dart';
import 'model_general.dart';

//--------------------------------------------------------------------------------- Global
typedef modelType = model_xray_group;
String api_route = models_api.service_v2ray_group;

//--------------------------------------------------------------------------------- Model
class model_xray_group {
  //--------------------------------[Field]
  int id;
  String name;
  String pre;
  String description;
  bool enable;
  int alarm_id;
  int display_id;
  late Map<String, dynamic> controllers;

  //--------------------------------[Contractor]
  model_xray_group({
    this.id = 1,
    this.name = '',
    this.pre = '',
    this.description = '',
    this.enable = true,
    this.alarm_id = 1,
    this.display_id = 1,
    model_service_v2ray_item? service_v2ray,
  }) {
    controllers = {
      'id': TextEditingController(text: id.toString()),
      'name': TextEditingController(text: name),
      'pre': TextEditingController(text: pre),
      'description': TextEditingController(text: description),
      'enable': ValueNotifier<bool>(enable),
      'alarm_id': ValueNotifier<int>(alarm_id),
      'display_id': ValueNotifier<int>(display_id),
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
        'display_id' => display_id,
        _ => null,
      };

  //--------------------------------[toModel]
  factory model_xray_group.toModel(Map<String, dynamic> json) {
    return model_xray_group(
      id: json['id'] as int,
      name: json['name'] as String,
      pre: json['pre'] as String,
      description: json['description'] as String,
      enable: json['enable'] as bool,
      alarm_id: json['alarm_id'] as int,
      display_id: json['display_id'] as int,
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
        'display_id': display_id,
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
      display_id: (controllers['display_id'] as ValueNotifier<int>).value,
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
    controllers['display_id'].value = 1;
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

  //--------------------------------[Network]
  network_gi_items(int group_id) async {
    MyApi api_mdl = new MyApi();
    var data = json.decode(await api_mdl.get('${const_api_url}/xray_group_network/item_group?group_id=$group_id'));
    List<dynamic> result = data['data'];
    return result;
  }

  network_gi_fill(int group_id, int network_id, bool value) async {
    MyApi api_mdl = new MyApi();
    var result = json.decode(await api_mdl.get('${const_api_url}/xray_group_network/fill?group_id=$group_id&network_id=$network_id&value=$value'));
    return result;
  }

  //--------------------------------[Way]
  way_gi_items(int group_id, int network_id) async {
    MyApi api_mdl = new MyApi();
    var data = json.decode(await api_mdl.get('${const_api_url}/xray_group_way/item_group?group_id=$group_id&network_id=$network_id'));
    List<dynamic> result = data['data'];
    return result;
  }

  way_gi_fill(int group_id, int network_id, int way_id, bool value) async {
    MyApi api_mdl = new MyApi();
    var result = json.decode(await api_mdl.get('${const_api_url}/xray_group_way/fill?group_id=$group_id&network_id=$network_id&way_id=$way_id&value=$value'));
    return result;
  }

  //--------------------------------[Route]
  route_gi_items(int group_id, int network_id, int way_id) async {
    MyApi api_mdl = new MyApi();
    var data = json.decode(await api_mdl.get('${const_api_url}/xray_group_route/item_group?group_id=$group_id&network_id=$network_id&way_id=$way_id'));
    List<dynamic> result = data['data'];
    return result;
  }

  route_gi_fill(int group_id, int network_id, int way_id, int route_id, bool value) async {
    MyApi api_mdl = new MyApi();
    var result = json.decode(await api_mdl.get('${const_api_url}/xray_group_route/fill?group_id=$group_id&network_id=$network_id&way_id=$way_id&route_id=$route_id&value=$value'));
    return result;
  }

  //--------------------------------[Inbound]
  inbound_gi_items(int group_id) async {
    MyApi api_mdl = new MyApi();
    var data = json.decode(await api_mdl.get('${const_api_url}/xray_group_inbound/item_group?group_id=$group_id'));
    List<dynamic> result = data['data'];
    return result;
  }

  inbound_gi_fill(int group_id, int inbound_id, String item, bool value) async {
    MyApi api_mdl = new MyApi();
    var result = json.decode(await api_mdl.get('${const_api_url}/xray_group_inbound/fill?group_id=$group_id&inbound_id=$inbound_id&item=$item&value=$value'));
    return result;
  }

  //--------------------------------[Plan]
  plan_gi_items(int group_id) async {
    MyApi api_mdl = new MyApi();
    var data = json.decode(await api_mdl.get('${const_api_url}/xray_group_plan/item_group?group_id=$group_id'));
    List<dynamic> result = data['data'];
    return result;
  }

  plan_gi_fill(int group_id, int plan_id, String item, value) async {
    MyApi api_mdl = new MyApi();
    var result = json.decode(await api_mdl.get('${const_api_url}/xray_group_plan/fill?group_id=$group_id&plan_id=$plan_id&item=$item&value=$value'));
    return result;
  }
}
