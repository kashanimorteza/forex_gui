//--------------------------------------------------------------------------------- location
// lib/models/model_service_v2ray_inbound.dart

//--------------------------------------------------------------------------------- Description
// This is model for model_service_v2ray_inbound

//--------------------------------------------------------------------------------- Import
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/consts/model.dart';
import 'package:mkpanel_gui/tools/api.dart';

//--------------------------------------------------------------------------------- Global
typedef modelType = model_service_v2ray_inbound;
String api_route = models_api.service_v2ray_inbound;

//--------------------------------------------------------------------------------- Model
class model_service_v2ray_inbound {
  //--------------------------------[Field]
  int id;
  String name;
  String path;
  int port;
  bool tls;
  bool enable;
  const_xray_transport transport;
  const_xray_protocol protocol;
  late Map<String, dynamic> controllers;

  //--------------------------------[Contractor]
  model_service_v2ray_inbound({
    this.id = 0,
    this.name = '',
    this.path = '',
    this.port = 0,
    this.tls = false,
    this.enable = true,
    this.transport = const_xray_transport.tcp,
    this.protocol = const_xray_protocol.vless,
  }) {
    controllers = {
      'id': TextEditingController(text: id.toString()),
      'name': TextEditingController(text: name),
      'path': TextEditingController(text: path),
      'port': TextEditingController(text: port.toString()),
      'tls': ValueNotifier<bool>(tls),
      'enable': ValueNotifier<bool>(enable),
      'transport': ValueNotifier<const_xray_transport>(transport),
      'protocol': ValueNotifier<const_xray_protocol>(protocol),
    };
  }

  //--------------------------------[getValueByKeys]
  dynamic getValueByKey(String key) => switch (key) {
        'id' => id,
        'name' => name,
        'path' => path,
        'port' => port,
        'tls' => tls,
        'enable' => enable,
        'transport' => transport.name,
        'protocol' => protocol.name,
        _ => null,
      };

  //--------------------------------[toModel]
  factory model_service_v2ray_inbound.toModel(Map<String, dynamic> json) {
    return modelType(
      id: json['id'] as int,
      name: json['name'] as String,
      path: json['path'] as String,
      port: json['port'] as int,
      tls: json['tls'] as bool,
      enable: json['enable'] as bool,
      transport: const_xray_transport.values.firstWhere((e) => e.name == json['transport'], orElse: () => const_xray_transport.tcp),
      protocol: const_xray_protocol.values.firstWhere((e) => e.name == json['protocol'], orElse: () => const_xray_protocol.vless),
    );
  }

  //--------------------------------[toJson]
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'path': path,
      'port': port,
      'tls': tls,
      'enable': enable,
      'transport': transport.name,
      'protocol': protocol.name,
    };
  }

  //--------------------------------[model_list]
  static List<modelType> model_list(List<dynamic> data) => data.map((item) => modelType.toModel(item as Map<String, dynamic>)).toList();

  //--------------------------------[get_model]
  modelType get_model() {
    Map<String, dynamic> controllers_data = controllers_get_data();
    return modelType(
      id: controllers_data['id'],
      name: controllers_data['name'],
      path: controllers_data['path'],
      port: controllers_data['port'],
      tls: controllers_data['tls'],
      enable: controllers_data['enable'],
      transport: (controllers_data['transport'] as const_xray_transport),
      protocol: (controllers_data['protocol'] as const_xray_protocol),
    );
  }

  //--------------------------------[controllers_get_data]
  Map<String, dynamic> controllers_get_data() {
    Map<String, dynamic> controllers_data = {};
    Set<String> intFields = {'id', 'port'};
    controllers.forEach((key, controller) {
      switch (controller) {
        case TextEditingController():
          controllers_data[key] = intFields.contains(key) ? (int.tryParse(controller.text) ?? 0) : controller.text;
        default:
          return controllers_data[key] = controller.value;
      }
    });
    return controllers_data;
  }

  //--------------------------------[controller_get]
  dynamic controller_get(String name) => controllers[name];

  //--------------------------------[controller_clear]
  void controller_clear() {
    controllers.forEach((key, controller) {
      switch (controller) {
        case TextEditingController():
          controller.clear();
        case ValueNotifier<bool>():
          controller.value = false;
        case ValueNotifier<int>():
          controller.value = 0;
        case ValueNotifier<String>():
          controller.value = '';
      }
    });
  }

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
      case 'generate':
        return json.decode(await api_mdl.get('${const_api_url}/${api_route}/generate'));
      case 'config':
        return json.decode(await api_mdl.get('${const_api_url}/${api_route}/transfer'));
      case 'crt_to_inb':
        return json.decode(await api_mdl.get('${const_api_url}/${api_route}/certificate'));
    }
  }
}
