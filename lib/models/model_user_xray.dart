//--------------------------------------------------------------------------------- Location
// lib/models/model_user_xray.dart

//--------------------------------------------------------------------------------- Description
// This is model for model_user_xray

//--------------------------------------------------------------------------------- Import
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/consts/model.dart';
import 'package:mkpanel_gui/tools/api.dart';

//--------------------------------------------------------------------------------- Global
String api_route = models_api.user_xray;

//--------------------------------------------------------------------------------- Model
class model_user_xray {
  //--------------------------------[Fields]
  int id;
  int user_id;
  int plan_id;
  int group_id;
  String name;
  String uuid;
  int period_used;
  int validity_used;
  int bandwith_used;
  int today_used;
  String first;
  String start;
  String last_connection;
  bool after_start;
  bool period_fix;
  bool reserve_renew_validity;
  bool reserve_renew_bandwith;
  bool online;
  bool enable;
  late Map<String, dynamic> controllers;

  //--------------------------------[Constructor]
  model_user_xray({
    this.id = 0,
    this.user_id = 0,
    this.plan_id = 0,
    this.group_id = 0,
    this.name = '',
    this.uuid = '',
    this.period_used = 0,
    this.validity_used = 0,
    this.bandwith_used = 0,
    this.today_used = 0,
    this.first = '',
    this.start = '',
    this.last_connection = '',
    this.after_start = false,
    this.period_fix = true,
    this.reserve_renew_validity = false,
    this.reserve_renew_bandwith = false,
    this.online = false,
    this.enable = true,
  }) {
    controllers = {
      'id': TextEditingController(text: id.toString()),
      'user_id': TextEditingController(text: user_id.toString()),
      'plan_id': ValueNotifier<int>(plan_id),
      'group_id': ValueNotifier<int>(group_id),
      'name': TextEditingController(text: name),
      'uuid': TextEditingController(text: uuid),
      'period_used': TextEditingController(text: period_used.toString()),
      'validity_used': TextEditingController(text: validity_used.toString()),
      'bandwith_used': TextEditingController(text: bandwith_used.toString()),
      'today_used': TextEditingController(text: today_used.toString()),
      'first': TextEditingController(text: first),
      'start': TextEditingController(text: start),
      'last_connection': TextEditingController(text: last_connection),
      'after_start': ValueNotifier<bool>(after_start),
      'period_fix': ValueNotifier<bool>(period_fix),
      'reserve_renew_validity': ValueNotifier<bool>(reserve_renew_validity),
      'reserve_renew_bandwith': ValueNotifier<bool>(reserve_renew_bandwith),
      'online': ValueNotifier<bool>(online),
      'enable': ValueNotifier<bool>(enable),
    };
  }

  //--------------------------------[getValueByKey]
  dynamic getValueByKey(String key) => switch (key) {
        'id' => id,
        'user_id' => user_id,
        'plan_id' => plan_id,
        'group_id' => group_id,
        'name' => name,
        'uuid' => uuid,
        'period_used' => period_used,
        'validity_used' => validity_used,
        'bandwith_used' => bandwith_used,
        'today_used' => today_used,
        'first' => first,
        'start' => start,
        'last_connection' => last_connection,
        'after_start' => after_start,
        'period_fix' => period_fix,
        'reserve_renew_validity' => reserve_renew_validity,
        'reserve_renew_bandwith' => reserve_renew_bandwith,
        'online' => online,
        'enable' => enable,
        _ => null,
      };

  //--------------------------------[toModel]
  factory model_user_xray.toModel(Map<String, dynamic> json) {
    return model_user_xray(
      id: json['id'] as int,
      user_id: json['user_id'] as int,
      plan_id: json['plan_id'] as int,
      group_id: json['group_id'] as int,
      name: json['name'] as String,
      uuid: json['uuid'] as String,
      period_used: json['period_used'] as int,
      validity_used: json['validity_used'] as int,
      bandwith_used: json['bandwith_used'] as int,
      today_used: json['today_used'] as int,
      first: json['first'] as String,
      start: json['start'] as String,
      last_connection: json['last_connection'] as String,
      after_start: json['after_start'] as bool,
      period_fix: json['period_fix'] as bool,
      reserve_renew_validity: json['reserve_renew_validity'] as bool,
      reserve_renew_bandwith: json['reserve_renew_bandwith'] as bool,
      online: json['online'] as bool,
      enable: json['enable'] as bool,
    );
  }

  //--------------------------------[toJson]
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'plan_id': plan_id,
      'group_id': group_id,
      'name': name,
      'uuid': uuid,
      'period_used': period_used,
      'validity_used': validity_used,
      'bandwith_used': bandwith_used,
      'today_used': today_used,
      'first': first,
      'start': start,
      'last_connection': last_connection,
      'after_start': after_start,
      'period_fix': period_fix,
      'reserve_renew_validity': reserve_renew_validity,
      'reserve_renew_bandwith': reserve_renew_bandwith,
      'online': online,
      'enable': enable,
    };
  }

  //--------------------------------[get_model]
  model_user_xray get_model() {
    return model_user_xray(
      id: int.tryParse(controllers['id']?.text ?? '0') ?? 0,
      user_id: int.tryParse(controllers['user_id']?.text ?? '0') ?? 0,
      plan_id: (controllers['plan_id'] as ValueNotifier<int>).value,
      group_id: (controllers['group_id'] as ValueNotifier<int>).value,
      name: controllers['name']?.text ?? '',
      uuid: controllers['uuid']?.text ?? '',
      period_used: int.tryParse(controllers['period_used']?.text ?? '0') ?? 0,
      validity_used: int.tryParse(controllers['validity_used']?.text ?? '0') ?? 0,
      bandwith_used: int.tryParse(controllers['bandwith_used']?.text ?? '0') ?? 0,
      today_used: int.tryParse(controllers['today_used']?.text ?? '0') ?? 0,
      first: controllers['first']?.text ?? '',
      start: controllers['start']?.text ?? '',
      last_connection: controllers['last_connection']?.text ?? '',
      after_start: (controllers['after_start'] as ValueNotifier<bool>).value,
      period_fix: (controllers['period_fix'] as ValueNotifier<bool>).value,
      reserve_renew_validity: (controllers['reserve_renew_validity'] as ValueNotifier<bool>).value,
      reserve_renew_bandwith: (controllers['reserve_renew_bandwith'] as ValueNotifier<bool>).value,
      online: (controllers['online'] as ValueNotifier<bool>).value,
      enable: (controllers['enable'] as ValueNotifier<bool>).value,
    );
  }

  //--------------------------------[controller_clear]
  void controller_clear() {
    controllers['id']?.clear();
    controllers['user_id']?.clear();
    controllers['plan_id'].value = 0;
    controllers['group_id'].value = 0;
    controllers['name']?.clear();
    controllers['uuid']?.clear();
    controllers['period_used']?.clear();
    controllers['validity_used']?.clear();
    controllers['bandwith_used']?.clear();
    controllers['today_used']?.clear();
    controllers['first']?.clear();
    controllers['start']?.clear();
    controllers['last_connection']?.clear();
    (controllers['after_start'] as ValueNotifier<bool>).value = false;
    (controllers['period_fix'] as ValueNotifier<bool>).value = true;
    (controllers['reserve_renew_validity'] as ValueNotifier<bool>).value = false;
    (controllers['reserve_renew_bandwith'] as ValueNotifier<bool>).value = false;
    (controllers['online'] as ValueNotifier<bool>).value = false;
    (controllers['enable'] as ValueNotifier<bool>).value = true;
  }

  //--------------------------------[model_list]
  static List<model_user_xray> model_list(List<dynamic> data) => data.map((item) => model_user_xray.toModel(item as Map<String, dynamic>)).toList();

  //--------------------------------[controller_get]
  dynamic controller_get(String name) => controllers[name];

  //--------------------------------[Api]
  //----------[Add]
  add(user_id, group_id, plan_id, name) async {
    MyApi api_mdl = new MyApi();
    var result = await api_mdl.get('${const_api_url}/${api_route}/add?user_id=$user_id&group_id=$group_id&plan_id=$plan_id&name=$name');
    result = json.decode(result);
    return result;
  }

  //----------[Update]
  update() async {
    MyApi api_mdl = new MyApi();
    model_user_xray mdl = get_model();
    var mdl_json = mdl.toJson();
    var result = await api_mdl.put('${const_api_url}/${api_route}/update', mdl_json);
    result = json.decode(result);
    return result;
  }

  //----------[Delete]
  delete() async {
    MyApi api = new MyApi();
    var result = await api.del('${const_api_url}/${api_route}/delete/$id');
    result = json.decode(result);
    return result;
  }

  //----------[item]
  item(int id) async {
    MyApi api_mdl = new MyApi();
    var result = await api_mdl.get('${const_api_url}/${api_route}/item/$id');
    result = json.decode(result);
    List<dynamic> item_data = result['data'];
    List<model_user_xray> item = model_user_xray.model_list(item_data);
    return item;
  }

  //----------[items]
  items([int user_id = 0]) async {
    MyApi api_mdl = new MyApi();
    var param = user_id > 0 ? "?user_id=$user_id" : "";
    var data1 = await api_mdl.get('${const_api_url}/${api_route}/items$param');
    var data2 = json.decode(data1);
    List<dynamic> data3 = data2['data'];
    List<model_user_xray> data4 = model_user_xray.model_list(data3);
    return data4;
  }

  //----------[group_change]
  group_change(int id, int group_id) async {
    MyApi api_mdl = new MyApi();
    var result = await api_mdl.get('${const_api_url}/${api_route}/group_change?id=$id&group_id=$group_id');
    result = json.decode(result);
    return result;
  }

  //----------[plan_change]
  plan_change(int id, int plan_id) async {
    MyApi api_mdl = new MyApi();
    var result = await api_mdl.get('${const_api_url}/${api_route}/plan_change?id=$id&plan_id=$plan_id');
    result = json.decode(result);
    return result;
  }

  //----------[status_change]
  status_change(int id, bool status) async {
    MyApi api_mdl = new MyApi();
    var result = await api_mdl.get('${const_api_url}/${api_route}/status_change?id=$id&status=$status');
    result = json.decode(result);
    return result;
  }

  //----------[uuid_change]
  uuid_change(int id) async {
    MyApi api_mdl = new MyApi();
    var result = await api_mdl.get('${const_api_url}/${api_route}/uuid_change?id=$id');
    result = json.decode(result);
    return result;
  }

  //----------[config_get]
  config_get(int id) async {
    MyApi api_mdl = new MyApi();
    var result = await api_mdl.get('${const_api_url}/${api_route}/xray_config?id=$id');
    result = json.decode(result);
    return result;
  }

  //----------[reset]
  reset(int id) async {
    MyApi api_mdl = new MyApi();
    var result = await api_mdl.get('${const_api_url}/${api_route}/reset?id=$id');
    result = json.decode(result);
    return result;
  }
}
