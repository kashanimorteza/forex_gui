//--------------------------------------------------------------------------------- location
// lib/models/model_route.dart

//--------------------------------------------------------------------------------- Description
// This is model for route

//--------------------------------------------------------------------------------- Import
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/consts/model.dart';
import 'package:mkpanel_gui/tools/api.dart';

//--------------------------------------------------------------------------------- Global
typedef modelType = model_route;
String api_route = models_api.route;

//--------------------------------------------------------------------------------- Model
class model_route {
  //--------------------------------[Field]
  int id;
  String name;
  String title;
  String? description;
  int domain_id;
  int certificate_id;
  const_route_type type;
  bool enable;

  late Map<String, dynamic> controllers;

  //--------------------------------[Contractor]
  model_route({
    this.id = 1,
    this.name = '',
    this.title = '',
    this.description = '',
    this.domain_id = 1,
    this.certificate_id = 1,
    this.type = const_route_type.domain,
    this.enable = true,
  }) {
    controllers = {
      'id': TextEditingController(text: id.toString()),
      'name': TextEditingController(text: name),
      'title': TextEditingController(text: title),
      'description': TextEditingController(text: description ?? ''),
      'domain_id': ValueNotifier<int>(domain_id),
      'certificate_id': ValueNotifier<int>(certificate_id),
      'type': ValueNotifier<const_route_type>(type),
      'enable': ValueNotifier<bool>(enable),
    };
  }

  //--------------------------------[getValueByKeys]
  dynamic getValueByKey(String key) => switch (key) {
        'id' => id,
        'name' => name,
        'title' => title,
        'description' => description,
        'domain_id' => domain_id,
        'certificate_id' => certificate_id,
        'type' => type.name,
        'enable' => enable,
        _ => null,
      };

  //--------------------------------[toModel]
  factory model_route.toModel(Map<String, dynamic> json) {
    return modelType(
      id: json['id'] as int,
      name: json['name'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      domain_id: json['domain_id'] as int,
      certificate_id: json['certificate_id'] as int,
      type: const_route_type.values.firstWhere((e) => e.name == json['type'], orElse: () => const_route_type.domain),
      enable: json['enable'] as bool,
    );
  }

  //--------------------------------[toJson]
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'title': title,
      'description': description,
      'domain_id': domain_id,
      'certificate_id': certificate_id,
      'type': type.name,
      'enable': enable,
    };
  }

  //--------------------------------[get_model]
  modelType get_model() {
    return modelType(
      id: int.tryParse(controllers['id'].text) ?? 1,
      name: controllers['name'].text,
      title: controllers['title'].text,
      description: controllers['description'].text,
      enable: (controllers['enable'] as ValueNotifier<bool>).value,
      domain_id: (controllers['domain_id'] as ValueNotifier<int>).value,
      certificate_id: (controllers['certificate_id'] as ValueNotifier<int>).value,
      type: (controllers['type'] as ValueNotifier<const_route_type>).value,
    );
  }

  //--------------------------------[controller_clear]
  void controller_clear() {
    controllers['id'].clear();
    controllers['name'].clear();
    controllers['title'].clear();
    controllers['description'].clear();
    controllers['enable'].value = false;
    controllers['domain_id'].value = 1;
    controllers['certificate_id'].value = 1;
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
    var data = json.decode(await api_mdl.get('${const_api_url}/route_gi/item_group/$id'));
    List<dynamic> result = data['data'];
    return result;
  }

  //--------------------------------[gi_fill]
  gi_fill(int group_id, int item_id, bool enable) async {
    MyApi api_mdl = new MyApi();
    var data = {"group_id": group_id, "item_id": item_id, "enable": enable};
    var result = json.decode(await api_mdl.put('${const_api_url}/route_gi/fill', data));
    return result;
  }
}
