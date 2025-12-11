import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/consts/model.dart';
import 'package:mkpanel_gui/tools/api.dart';

//--------------------------------------------------------------------------------- Global
typedef modelType = model_service_v2ray_server;
String api_route = models_api.service_v2ray_server;

//--------------------------------------------------------------------------------- Model
class model_service_v2ray_server {
  //--------------------------------[Field]
  String version;
  String config_dir;
  String api_host;
  int api_port;
  late Map<String, dynamic> controllers;

  //--------------------------------[Contractor]
  model_service_v2ray_server({
    this.version = '',
    this.config_dir = '',
    this.api_host = '',
    this.api_port = 0,
  }) {
    controllers = {
      'version': TextEditingController(text: version),
      'config_dir': TextEditingController(text: config_dir),
      'api_host': TextEditingController(text: api_host),
      'api_port': TextEditingController(text: api_port.toString()),
    };
  }

  //--------------------------------[getValueByKeys]
  dynamic getValueByKey(String key) => switch (key) {
        'version' => version,
        'config_dir' => config_dir,
        'api_host' => api_host,
        'api_port' => api_port,
        _ => null,
      };

  //--------------------------------[toModel]
  factory model_service_v2ray_server.toModel(Map<String, dynamic> json) {
    return modelType(
      version: json['version'] as String,
      config_dir: json['config_dir'] as String,
      api_host: json['api_host'] as String,
      api_port: json['api_port'] as int,
    );
  }

  //--------------------------------[toJson]
  Map<String, dynamic> toJson() {
    return {
      'version': version,
      'config_dir': config_dir,
      'api_host': api_host,
      'api_port': api_port,
    };
  }

  //--------------------------------[get_model]
  modelType get_model() {
    Map<String, dynamic> values = controllers_get_data();
    return modelType(
      version: values['version'],
      config_dir: values['config_dir'],
      api_host: values['api_host'],
      api_port: values['api_port'],
    );
  }

  //--------------------------------[controllers_get_data]
  Map<String, dynamic> controllers_get_data() {
    Map<String, dynamic> controllers_data = {};
    Set<String> intFields = {'api_port'};
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

  //--------------------------------[controller_clear]
  void controller_clear() {
    controllers.forEach((key, controller) {
      switch (controller) {
        case TextEditingController():
          controller.clear();
      }
    });
  }

  //--------------------------------[controller_get]
  dynamic controller_get(String name) => controllers[name];

  //--------------------------------[Api]
  api(type) async {
    MyApi api_mdl = new MyApi();
    switch (type) {
      case 'update':
        return json.decode(await api_mdl.put('${const_api_url}/${api_route}/update', get_model().toJson()));
      case 'item':
        var data1 = json.decode(await api_mdl.get('${const_api_url}/${api_route}/items'));
        var data2 = modelType.toModel(data1['data']);
        return data2;
      case 'install':
        return json.decode(await api_mdl.get('${const_api_url}/${api_route}/install'));
      case 'detaile':
        return json.decode(await api_mdl.get('${const_api_url}/${api_route}/detaile'));
      case 'stop':
        return json.decode(await api_mdl.get('${const_api_url}/${api_route}/server?action=stop'));
      case 'start':
        return json.decode(await api_mdl.get('${const_api_url}/${api_route}/server?action=start'));
      case 'restart':
        return json.decode(await api_mdl.get('${const_api_url}/${api_route}/server?action=restart'));
      case 'status':
        return json.decode(await api_mdl.get('${const_api_url}/${api_route}/server?action=status'));
      case 'enable':
        return json.decode(await api_mdl.get('${const_api_url}/${api_route}/server?action=enable'));
      case 'disable':
        return json.decode(await api_mdl.get('${const_api_url}/${api_route}/server?action=disable'));
    }
  }
}
