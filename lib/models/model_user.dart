import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/consts/model.dart';
import 'package:mkpanel_gui/tools/api.dart';

//--------------------------------------------------------------------------------- Global
typedef modelType = model_user;
String api_route = models_api.user;

//--------------------------------------------------------------------------------- Model
class model_user {
  //--------------------------------[Field]
  int id;
  int group_id;
  int? father_id;
  String username;
  String name;
  String email;
  String phone;
  String register_date;
  int balance;
  int credit;
  String auth_username;
  String auth_password;
  String auth_key;
  int today_used;
  String last_connection;
  bool online;
  String tg_id;
  int tg_sum_of_message;
  bool tg_join_robot;
  bool tg_join_channel;
  bool os_iphone;
  bool os_android;
  bool os_windows;
  bool os_linux;
  bool os_mac;
  bool enable;
  bool delete;
  bool display;
  bool trusted;
  late Map<String, dynamic> controllers;

  //--------------------------------[Constructor]
  model_user({
    this.id = 1,
    this.group_id = 1,
    this.father_id = 1,
    this.username = '',
    this.name = '',
    this.email = '',
    this.phone = '',
    this.register_date = '',
    this.balance = 0,
    this.credit = 0,
    this.auth_username = '',
    this.auth_password = '',
    this.auth_key = '',
    this.today_used = 0,
    this.last_connection = '',
    this.online = false,
    this.tg_id = '',
    this.tg_join_robot = false,
    this.tg_join_channel = false,
    this.tg_sum_of_message = 0,
    this.os_iphone = false,
    this.os_android = false,
    this.os_windows = false,
    this.os_linux = false,
    this.os_mac = false,
    this.enable = true,
    this.delete = false,
    this.display = true,
    this.trusted = false,
  }) {
    controllers = {
      'group_id': ValueNotifier<int>(group_id),
      'father_id': TextEditingController(text: father_id?.toString() ?? ''),
      'username': TextEditingController(text: username),
      'name': TextEditingController(text: name),
      'email': TextEditingController(text: email),
      'phone': TextEditingController(text: phone),
      'register_date': TextEditingController(text: register_date),
      'balance': TextEditingController(text: balance.toString()),
      'credit': TextEditingController(text: credit.toString()),
      'auth_username': TextEditingController(text: auth_username),
      'auth_password': TextEditingController(text: auth_password),
      'auth_key': TextEditingController(text: auth_key),
      'today_used': TextEditingController(text: today_used.toString()),
      'last_connection': TextEditingController(text: last_connection),
      'tg_id': TextEditingController(text: tg_id),
      'tg_sum_of_message': TextEditingController(text: tg_sum_of_message.toString()),
      'tg_join_robot': ValueNotifier<bool>(tg_join_robot),
      'tg_join_channel': ValueNotifier<bool>(tg_join_channel),
      'online': ValueNotifier<bool>(online),
      'os_iphone': ValueNotifier<bool>(os_iphone),
      'os_android': ValueNotifier<bool>(os_android),
      'os_windows': ValueNotifier<bool>(os_windows),
      'os_linux': ValueNotifier<bool>(os_linux),
      'os_mac': ValueNotifier<bool>(os_mac),
      'enable': ValueNotifier<bool>(enable),
      'delete': ValueNotifier<bool>(delete),
      'display': ValueNotifier<bool>(display),
      'trusted': ValueNotifier<bool>(trusted),
    };
  }

  //--------------------------------[getValueByKeys]
  dynamic getValueByKey(String key) => switch (key) {
        'id' => id,
        'group_id' => group_id,
        'father_id' => father_id,
        'username' => username,
        'name' => name,
        'email' => email,
        'phone' => phone,
        'register_date' => register_date,
        'balance' => balance,
        'credit' => credit,
        'auth_username' => auth_username,
        'auth_password' => auth_password,
        'auth_key' => auth_key,
        'today_used' => today_used,
        'last_connection' => last_connection,
        'online' => online,
        'tg_id' => tg_id,
        'tg_join_robot' => tg_join_robot,
        'tg_join_channel' => tg_join_channel,
        'tg_sum_of_message' => tg_sum_of_message,
        'os_iphone' => os_iphone,
        'os_android' => os_android,
        'os_windows' => os_windows,
        'os_linux' => os_linux,
        'os_mac' => os_mac,
        'enable' => enable,
        'delete' => delete,
        'display' => display,
        'trusted' => trusted,
        _ => null,
      };

  //--------------------------------[toModel]
  factory model_user.toModel(Map<String, dynamic> json) {
    return modelType(
      id: json['id'] as int,
      group_id: json['group_id'] as int,
      father_id: json['father_id'] as int?,
      username: json['username'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      register_date: json['register_date'] as String,
      balance: json['balance'] as int,
      credit: json['credit'] as int,
      auth_username: json['auth_username'] as String,
      auth_password: json['auth_password'] as String,
      auth_key: json['auth_key'] as String,
      today_used: json['today_used'] as int,
      last_connection: json['last_connection'] ?? '',
      online: json['online'] as bool,
      tg_id: json['tg_id'] as String,
      tg_join_robot: json['tg_join_robot'] as bool,
      tg_join_channel: json['tg_join_channel'] as bool,
      tg_sum_of_message: json['tg_sum_of_message'] as int,
      os_iphone: json['os_iphone'] as bool,
      os_android: json['os_android'] as bool,
      os_windows: json['os_windows'] as bool,
      os_linux: json['os_linux'] as bool,
      os_mac: json['os_mac'] as bool,
      enable: json['enable'] as bool,
      delete: json['delete'] as bool,
      display: json['display'] as bool,
      trusted: json['trusted'] as bool,
    );
  }

  //--------------------------------[toJson]
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'group_id': group_id,
      'father_id': father_id,
      'username': username,
      'name': name,
      'email': email,
      'phone': phone,
      'register_date': register_date,
      'balance': balance,
      'credit': credit,
      'auth_username': auth_username,
      'auth_password': auth_password,
      'auth_key': auth_key,
      'today_used': today_used,
      'last_connection': last_connection,
      'online': online,
      'tg_id': tg_id,
      'tg_join_robot': tg_join_robot,
      'tg_join_channel': tg_join_channel,
      'tg_sum_of_message': tg_sum_of_message,
      'os_iphone': os_iphone,
      'os_android': os_android,
      'os_windows': os_windows,
      'os_linux': os_linux,
      'os_mac': os_mac,
      'enable': enable,
      'delete': delete,
      'display': display,
      'trusted': trusted,
    };
  }

  //--------------------------------[get_model]
  modelType get_model() {
    return modelType(
      id: id,
      group_id: (controllers['group_id'] as ValueNotifier<int>).value,
      father_id: int.tryParse(controllers['father_id']?.text ?? '1'),
      username: controllers['username']?.text ?? '',
      name: controllers['name']?.text ?? '',
      email: controllers['email']?.text ?? '',
      phone: controllers['phone']?.text ?? '',
      register_date: controllers['register_date']?.text ?? '',
      balance: int.tryParse(controllers['balance']?.text ?? '0') ?? 0,
      credit: int.tryParse(controllers['credit']?.text ?? '0') ?? 0,
      auth_username: controllers['auth_username']?.text ?? '',
      auth_password: controllers['auth_password']?.text ?? '',
      auth_key: controllers['auth_key']?.text ?? '',
      today_used: int.tryParse(controllers['today_used']?.text ?? '0') ?? 0,
      last_connection: controllers['last_connection']?.text ?? '',
      online: (controllers['online'] as ValueNotifier<bool>).value,
      tg_id: controllers['tg_id']?.text ?? '',
      tg_join_robot: (controllers['tg_join_robot'] as ValueNotifier<bool>).value,
      tg_join_channel: (controllers['tg_join_channel'] as ValueNotifier<bool>).value,
      tg_sum_of_message: int.tryParse(controllers['tg_sum_of_message']?.text ?? '0') ?? 0,
      os_iphone: (controllers['os_iphone'] as ValueNotifier<bool>).value,
      os_android: (controllers['os_android'] as ValueNotifier<bool>).value,
      os_windows: (controllers['os_windows'] as ValueNotifier<bool>).value,
      os_linux: (controllers['os_linux'] as ValueNotifier<bool>).value,
      os_mac: (controllers['os_mac'] as ValueNotifier<bool>).value,
      enable: (controllers['enable'] as ValueNotifier<bool>).value,
      delete: (controllers['delete'] as ValueNotifier<bool>).value,
      display: (controllers['display'] as ValueNotifier<bool>).value,
      trusted: (controllers['trusted'] as ValueNotifier<bool>).value,
    );
  }

  //--------------------------------[controller_clear]
  void controller_clear() {
    controllers['id']?.clear();
    controllers['group_id']?.clear();
    controllers['father_id']?.clear();
    controllers['username']?.clear();
    controllers['name']?.clear();
    controllers['email']?.clear();
    controllers['phone']?.clear();
    controllers['register_date']?.clear();
    controllers['balance']?.clear();
    controllers['credit']?.clear();
    controllers['auth_username']?.clear();
    controllers['auth_password']?.clear();
    controllers['auth_key']?.clear();
    controllers['tg_id']?.clear();
    (controllers['tg_join_robot'] as ValueNotifier<bool>).value = false;
    (controllers['tg_join_channel'] as ValueNotifier<bool>).value = false;
    controllers['tg_sum_of_message']?.clear();
    controllers['today_used']?.clear();
    (controllers['trusted'] as ValueNotifier<bool>).value = false;
    controllers['last_connection']?.clear();
    (controllers['os_iphone'] as ValueNotifier<bool>).value = false;
    (controllers['os_android'] as ValueNotifier<bool>).value = false;
    (controllers['os_windows'] as ValueNotifier<bool>).value = false;
    (controllers['os_linux'] as ValueNotifier<bool>).value = false;
    (controllers['os_mac'] as ValueNotifier<bool>).value = false;
    (controllers['enable'] as ValueNotifier<bool>).value = true;
    (controllers['delete'] as ValueNotifier<bool>).value = false;
    (controllers['display'] as ValueNotifier<bool>).value = true;
    (controllers['trusted'] as ValueNotifier<bool>).value = false;
  }

  //--------------------------------[model_list]
  static List<modelType> model_list(List<dynamic> data) => data.map((item) => modelType.toModel(item as Map<String, dynamic>)).toList();

  //--------------------------------[controller_get]
  dynamic controller_get(String name) => controllers[name];

  //--------------------------------[Api]
  api(type, [int id = 0]) async {
    MyApi api_mdl = new MyApi();
    switch (type) {
      case 'add':
        var model = get_model();
        var data = model.toJson();
        var result = json.decode(await api_mdl.post('${const_api_url}/${api_route}/add', data));
        return result;
      case 'update':
        var model = get_model();
        var data = model.toJson();
        var result = json.decode(await api_mdl.put('${const_api_url}/${api_route}/update', data));
        return result;
      case 'delete':
        return json.decode(await api_mdl.del('${const_api_url}/${api_route}/delete/${get_model().id}'));
      case 'item':
        var data1 = await api_mdl.get('${const_api_url}/${api_route}/item/${id}');
        var data2 = json.decode(data1);
        var data3 = modelType.toModel(data2['data']);
        return data3;
      case 'items':
        List<dynamic> data1 = json.decode(await api_mdl.get('${const_api_url}/${api_route}/items'));
        List<modelType> data2 = modelType.model_list(data1);
        return data2;
      case 'service_v2ray_check':
        return json.decode(await api_mdl.post('${const_api_url}/${api_route}/service_v2ray_check', []));
      case 'usage':
        return json.decode(await api_mdl.get('${const_api_url}/${api_route}/usage'));
      case 'add_day':
        return json.decode(await api_mdl.get('${const_api_url}/${api_route}/add_day'));
      case 'cron_daily':
        return json.decode(await api_mdl.get('${const_api_url}/${api_route}/cron_daily'));
      case 'cron_hourly':
        return json.decode(await api_mdl.get('${const_api_url}/${api_route}/cron_hourly'));
      case 'cron_minly':
        return json.decode(await api_mdl.get('${const_api_url}/${api_route}/cron_minly'));
    }
  }

  //--------------------------------[payment]
  payment(int user_id, dynamic value) async {
    MyApi api = new MyApi();
    return json.decode(await api.get('${const_api_url}/${api_route}/add_payment?user_id=${user_id}&type=${value.type}&amount=${value.amount}&data=${value.data}'));
  }

  //--------------------------------[set_service]
  set_service(Map<String, dynamic> value) async {
    MyApi api = new MyApi();
    var q = '';
    if (value['service_name'] == "v2ray") {
      if (value['action'] == "add") {
        q = 'service_name=${value['service_name']}&action=${value['action']}&user_id=${value['user_id']}&service_id=${value['service_id']}&service_user_name=${value['service_name']}&group_id=${value['group_id']}&plan_id=${value['plan_id']}';
      } else if (value['action'] == "group_change") {
        q = 'service_name=${value['service_name']}&action=${value['action']}&user_id=${value['user_id']}&service_id=${value['service_id']}&group_id=${value['group_id']}';
      } else if (value['action'] == "plan_change") {
        q = 'service_name=${value['service_name']}&action=${value['action']}&user_id=${value['user_id']}&service_id=${value['service_id']}&plan_id=${value['plan_id']}';
      } else {
        q = 'service_name=${value['service_name']}&action=${value['action']}&user_id=${value['user_id']}&service_id=${value['service_id']}';
      }
      var result = json.decode(await api.get('${const_api_url}/${api_route}/set_service?${q}'));
      return result;
    }
  }

  //--------------------------------[add]
  add() async {
    MyApi api = new MyApi();
    model_user model = get_model();
    var data = json.decode(await api.get('${const_api_url}/${api_route}/add?username=${model.username}&name=${model.name}&telegram_id=${model.tg_id}&group_id=${model.group_id}'));
    return data;
  }

  //--------------------------------[search]
  credit_check() async {
    MyApi api = new MyApi();
    var result = json.decode(await api.get('${const_api_url}/${api_route}/credit_check'));
    return result;
  }

  //--------------------------------[reset_usage]
  reset_usage() async {
    MyApi api = new MyApi();
    var result = json.decode(await api.get('${const_api_url}/${api_route}/reset_usage'));
    return result;
  }

  //--------------------------------[status]
  status(String action) async {
    MyApi api = new MyApi();
    var result = json.decode(await api.get('${const_api_url}/${api_route}/status_change?user_id=${id}&action=${action}'));
    return result;
  }

  //--------------------------------[search]
  search(subject, input1, input2) async {
    MyApi api = new MyApi();
    var data1 = json.decode(await api.get('${const_api_url}/${api_route}/search?subject=${subject}&data1=${input1}&data2=${input2}'));
    List<dynamic> data2 = data1['data'];
    List<modelType> data3 = modelType.model_list(data2);
    return data3;
  }
}
