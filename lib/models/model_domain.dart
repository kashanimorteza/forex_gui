//--------------------------------------------------------------------------------- location
// lib/models/model_domain.dart

//--------------------------------------------------------------------------------- Description
// This is model for domain

//--------------------------------------------------------------------------------- Import
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/consts/model.dart';
import 'package:mkpanel_gui/tools/api.dart';

//--------------------------------------------------------------------------------- Global
typedef modelType = model_domain;
String api_route = models_api.domain;

//--------------------------------------------------------------------------------- Model
class model_domain {
  //--------------------------------[Field]
  int id;
  String name;
  String address;
  String? zoneid;
  String? accountid;
  String? token;
  String? description;
  bool enable;
  late Map<String, dynamic> controllers;

  //--------------------------------[Contractor]
  model_domain({
    this.id = 0,
    this.name = '',
    this.address = '',
    this.zoneid = '',
    this.accountid = '',
    this.token = '',
    this.description = '',
    this.enable = true,
  }) {
    controllers = {
      'id': TextEditingController(text: id.toString()),
      'name': TextEditingController(text: name),
      'address': TextEditingController(text: address),
      'zoneid': TextEditingController(text: zoneid ?? ''),
      'accountid': TextEditingController(text: accountid ?? ''),
      'token': TextEditingController(text: token ?? ''),
      'description': TextEditingController(text: description ?? ''),
      'enable': ValueNotifier<bool>(enable),
    };
  }

  //--------------------------------[getValueByKeys]
  dynamic getValueByKey(String key) => switch (key) {
        'id' => id,
        'name' => name,
        'address' => address,
        'zoneid' => zoneid,
        'accountid' => accountid,
        'token' => token,
        'description' => description,
        'enable' => enable,
        _ => null,
      };

  //--------------------------------[toModel]
  factory model_domain.toModel(Map<String, dynamic> json) {
    return modelType(
      id: json['id'] as int,
      name: json['name'] as String,
      address: json['address'] as String,
      zoneid: json['zoneid'] as String? ?? '',
      accountid: json['accountid'] as String? ?? '',
      token: json['token'] as String? ?? '',
      description: json['description'] as String? ?? '',
      enable: json['enable'] as bool? ?? false,
    );
  }

  //--------------------------------[toJson]
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'zoneid': zoneid,
      'accountid': accountid,
      'token': token,
      'description': description,
      'enable': enable,
    };
  }

  //--------------------------------[get_model]
  modelType get_model() {
    return modelType(
      id: int.tryParse(controllers['id']?.text ?? '0') ?? 0,
      name: controllers['name']?.text ?? '',
      address: controllers['address']?.text ?? '',
      zoneid: controllers['zoneid']?.text ?? '',
      accountid: controllers['accountid']?.text ?? '',
      token: controllers['token']?.text ?? '',
      description: controllers['description']?.text ?? '',
      enable: (controllers['enable'] as ValueNotifier<bool>).value,
    );
  }

  //--------------------------------[controller_clear]
  void controller_clear() {
    controllers['id']?.clear();
    controllers['name']?.clear();
    controllers['address']?.clear();
    controllers['zoneid']?.clear();
    controllers['accountid']?.clear();
    controllers['token']?.clear();
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
      case 'cloudflare_delete':
        return json.decode(await api_mdl.get('${const_api_url}/${api_route}/cloudflare_delete'));
      case 'cloudflare_add':
        return json.decode(await api_mdl.get('${const_api_url}/${api_route}/cloudflare_add'));
    }
  }
}
