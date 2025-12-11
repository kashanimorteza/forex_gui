//--------------------------------------------------------------------------------- location
// lib/models/model_telegram_instance.dart

//--------------------------------------------------------------------------------- Description
// This is model for telegram instance configuration

//--------------------------------------------------------------------------------- Import
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/consts/model.dart';
import 'package:mkpanel_gui/tools/api.dart';

//--------------------------------------------------------------------------------- Global
typedef modelType = model_telegram_instance;
String api_route = models_api.telegram_instance;

//--------------------------------------------------------------------------------- Model
class model_telegram_instance {
  //--------------------------------[Field]
  int id;
  String name;
  String robot_username;
  String support_username;
  String support_channel;
  String bot_api_id;
  String bot_api_hash;
  String bot_token;
  int bot_delay;
  String link;
  bool enable;
  late Map<String, dynamic> controllers;

  //--------------------------------[Contractor]
  model_telegram_instance({
    this.id = 0,
    this.name = '',
    this.robot_username = '',
    this.support_username = '',
    this.support_channel = '',
    this.bot_api_id = '',
    this.bot_api_hash = '',
    this.bot_token = '',
    this.bot_delay = 1,
    this.link = '',
    this.enable = false,
  }) {
    controllers = {
      'id': TextEditingController(text: id.toString()),
      'name': TextEditingController(text: name),
      'support_username': TextEditingController(text: support_username),
      'support_channel': TextEditingController(text: support_channel),
      'robot_username': TextEditingController(text: robot_username),
      'bot_api_id': TextEditingController(text: bot_api_id),
      'bot_api_hash': TextEditingController(text: bot_api_hash),
      'bot_token': TextEditingController(text: bot_token),
      'bot_delay': TextEditingController(text: bot_delay.toString()),
      'link': TextEditingController(text: link),
      'enable': ValueNotifier<bool>(enable),
    };
  }

  //--------------------------------[getValueByKeys]
  dynamic getValueByKey(String key) => switch (key) {
        'id' => id,
        'support_username' => support_username,
        'support_channel' => support_channel,
        'robot_username' => robot_username,
        'bot_api_id' => bot_api_id,
        'bot_api_hash' => bot_api_hash,
        'bot_token' => bot_token,
        'bot_delay' => bot_delay,
        'link' => link,
        'name' => name,
        'enable' => enable,
        _ => null,
      };

  //--------------------------------[toModel]
  factory model_telegram_instance.toModel(Map<String, dynamic> json) {
    return modelType(
      id: json['id'] as int,
      support_username: json['support_username'] as String,
      support_channel: json['support_channel'] as String,
      robot_username: json['robot_username'] as String,
      bot_api_id: json['bot_api_id'] as String,
      bot_api_hash: json['bot_api_hash'] as String,
      bot_token: json['bot_token'] as String,
      bot_delay: json['bot_delay'] as int,
      link: json['link'] as String,
      name: json['name'] as String,
      enable: json['enable'] as bool,
    );
  }

  //--------------------------------[toJson]
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'support_username': support_username,
      'support_channel': support_channel,
      'robot_username': robot_username,
      'bot_api_id': bot_api_id,
      'bot_api_hash': bot_api_hash,
      'bot_token': bot_token,
      'bot_delay': bot_delay,
      'link': link,
      'name': name,
      'enable': enable,
    };
  }

  //--------------------------------[get_model]
  modelType get_model() {
    return modelType(
      id: int.tryParse(controllers['id']?.text ?? '0') ?? 0,
      support_username: controllers['support_username']?.text ?? '',
      support_channel: controllers['support_channel']?.text ?? '',
      robot_username: controllers['robot_username']?.text ?? '',
      bot_api_id: controllers['bot_api_id']?.text ?? '',
      bot_api_hash: controllers['bot_api_hash']?.text ?? '',
      bot_token: controllers['bot_token']?.text ?? '',
      bot_delay: int.tryParse(controllers['bot_delay']?.text ?? '1') ?? 1,
      link: controllers['link']?.text ?? '',
      name: controllers['name']?.text ?? '',
      enable: (controllers['enable'] as ValueNotifier<bool>).value,
    );
  }

  //--------------------------------[controller_clear]
  void controller_clear() {
    controllers['id']?.clear();
    controllers['support_username']?.clear();
    controllers['support_channel']?.clear();
    controllers['robot_username']?.clear();
    controllers['bot_api_id']?.clear();
    controllers['bot_api_hash']?.clear();
    controllers['bot_token']?.clear();
    controllers['bot_delay']?.clear();
    controllers['link']?.clear();
    controllers['name']?.clear();
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
