//--------------------------------------------------------------------------------- location
// lib/models/model_config.dart

//--------------------------------------------------------------------------------- Description
// This is model for config

//--------------------------------------------------------------------------------- Import
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/consts/model.dart';
import 'package:mkpanel_gui/tools/api.dart';

//--------------------------------------------------------------------------------- Global
typedef modelType = model_config;
String api_route = models_api.config;

//--------------------------------------------------------------------------------- Model
class model_config {
  //--------------------------------[Field]
  String name;
  String panel;
  String email;
  String web;
  String timeZone;
  int warp_port;
  int webapi_port;
  int log_lines;
  String cron_daily_time;
  int cron_hourly_period;
  int cron_minly_period;
  int cron_delay;
  int config_number;
  int free_group_id;
  int current_user_id;
  int base_group_id;
  int end_group_id;
  int current_group_id;
  String bank_account_name;
  String bank_account_card;
  int traffic_today;
  int traffic_yesterday;
  int traffic_month;
  String log_folder;
  String backup_folder;
  String certificate_dir;
  String link_config_service_v2ray;
  bool debug;
  bool log;
  bool verbose;
  late Map<String, dynamic> controllers;

  //--------------------------------[Contractor]
  model_config({
    this.name = 'Config-1',
    this.panel = 'xray',
    this.email = 'xray@xray.com',
    this.web = 'xray.com',
    this.timeZone = 'Asia/Tehran',
    this.warp_port = 4000,
    this.webapi_port = 8080,
    this.log_lines = 25,
    this.cron_daily_time = '11:59:59',
    this.cron_hourly_period = 60,
    this.cron_minly_period = 5,
    this.cron_delay = 2,
    this.config_number = 1,
    this.free_group_id = 1,
    this.current_user_id = 1001,
    this.base_group_id = 1,
    this.end_group_id = 1,
    this.current_group_id = 1,
    this.bank_account_name = 'xray',
    this.bank_account_card = '5022',
    this.traffic_today = 0,
    this.traffic_yesterday = 0,
    this.traffic_month = 0,
    this.log_folder = '/opt/xray/log',
    this.backup_folder = '/opt/xray/backup',
    this.certificate_dir = '/etc/letsencrypt/live',
    this.link_config_service_v2ray = '',
    this.debug = false,
    this.log = false,
    this.verbose = false,
  }) {
    controllers = {
      'name': TextEditingController(text: name),
      'panel': TextEditingController(text: panel),
      'email': TextEditingController(text: email),
      'web': TextEditingController(text: web),
      'timeZone': TextEditingController(text: timeZone),
      'warp_port': TextEditingController(text: warp_port.toString()),
      'webapi_port': TextEditingController(text: webapi_port.toString()),
      'log_lines': TextEditingController(text: log_lines.toString()),
      'cron_daily_time': TextEditingController(text: cron_daily_time),
      'cron_hourly_period': TextEditingController(text: cron_hourly_period.toString()),
      'cron_minly_period': TextEditingController(text: cron_minly_period.toString()),
      'cron_delay': TextEditingController(text: cron_delay.toString()),
      'config_number': TextEditingController(text: config_number.toString()),
      'free_group_id': TextEditingController(text: free_group_id.toString()),
      'current_user_id': TextEditingController(text: current_user_id.toString()),
      'base_group_id': TextEditingController(text: base_group_id.toString()),
      'end_group_id': TextEditingController(text: end_group_id.toString()),
      'current_group_id': TextEditingController(text: current_group_id.toString()),
      'bank_account_name': TextEditingController(text: bank_account_name),
      'bank_account_card': TextEditingController(text: bank_account_card),
      'traffic_today': TextEditingController(text: traffic_today.toString()),
      'traffic_yesterday': TextEditingController(text: traffic_yesterday.toString()),
      'traffic_month': TextEditingController(text: traffic_month.toString()),
      'log_folder': TextEditingController(text: log_folder),
      'backup_folder': TextEditingController(text: backup_folder),
      'certificate_dir': TextEditingController(text: certificate_dir),
      'link_config_service_v2ray': TextEditingController(text: link_config_service_v2ray),
      'debug': ValueNotifier<bool>(debug),
      'log': ValueNotifier<bool>(log),
      'verbose': ValueNotifier<bool>(verbose),
    };
  }

  //--------------------------------[getValueByKeys]
  dynamic getValueByKey(String key) => switch (key) {
        'name' => name,
        'panel' => panel,
        'email' => email,
        'web' => web,
        'timeZone' => timeZone,
        'warp_port' => warp_port,
        'webapi_port' => webapi_port,
        'log_lines' => log_lines,
        'cron_daily_time' => cron_daily_time,
        'cron_hourly_period' => cron_hourly_period,
        'cron_minly_period' => cron_minly_period,
        'cron_delay' => cron_delay,
        'config_number' => config_number,
        'free_group_id' => free_group_id,
        'current_user_id' => current_user_id,
        'base_group_id' => base_group_id,
        'end_group_id' => end_group_id,
        'current_group_id' => current_group_id,
        'bank_account_name' => bank_account_name,
        'bank_account_card' => bank_account_card,
        'traffic_today' => traffic_today,
        'link_config_service_v2ray' => link_config_service_v2ray,
        _ => null
      };

  //--------------------------------[toModel]
  factory model_config.toModel(Map<String, dynamic> json) {
    return modelType(
      name: json['name'] as String,
      panel: json['panel'] as String,
      email: json['email'] as String,
      web: json['web'] as String,
      timeZone: json['timeZone'] as String,
      warp_port: json['warp_port'] as int,
      webapi_port: json['webapi_port'] as int,
      log_lines: json['log_lines'] as int,
      cron_daily_time: json['cron_daily_time'] as String,
      cron_hourly_period: json['cron_hourly_period'] as int,
      cron_minly_period: json['cron_minly_period'] as int,
      cron_delay: json['cron_delay'] as int,
      config_number: json['config_number'] as int,
      free_group_id: json['free_group_id'] as int,
      current_user_id: json['current_user_id'] as int,
      base_group_id: json['base_group_id'] as int,
      end_group_id: json['end_group_id'] as int,
      current_group_id: json['current_group_id'] as int,
      bank_account_name: json['bank_account_name'] as String,
      bank_account_card: json['bank_account_card'] as String,
      traffic_today: json['traffic_today'] as int,
      traffic_yesterday: json['traffic_yesterday'] as int,
      traffic_month: json['traffic_month'] as int,
      log_folder: json['log_folder'] as String,
      backup_folder: json['backup_folder'] as String,
      certificate_dir: json['certificate_dir'] as String,
      link_config_service_v2ray: json['link_config_service_v2ray'] as String,
      debug: json['debug'] as bool,
      log: json['log'] as bool,
      verbose: json['verbose'] as bool,
    );
  }

  //--------------------------------[toJson]
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'panel': panel,
      'email': email,
      'web': web,
      'timeZone': timeZone,
      'warp_port': warp_port,
      'webapi_port': webapi_port,
      'log_lines': log_lines,
      'cron_daily_time': cron_daily_time,
      'cron_hourly_period': cron_hourly_period,
      'cron_minly_period': cron_minly_period,
      'cron_delay': cron_delay,
      'config_number': config_number,
      'free_group_id': free_group_id,
      'current_user_id': current_user_id,
      'base_group_id': base_group_id,
      'end_group_id': end_group_id,
      'current_group_id': current_group_id,
      'bank_account_name': bank_account_name,
      'bank_account_card': bank_account_card,
      'traffic_today': traffic_today,
      'traffic_yesterday': traffic_yesterday,
      'traffic_month': traffic_month,
      'log_folder': log_folder,
      'backup_folder': backup_folder,
      'certificate_dir': certificate_dir,
      'link_config_service_v2ray': link_config_service_v2ray,
      'debug': debug,
      'log': log,
      'verbose': verbose,
    };
  }

//--------------------------------[get_model]
  modelType get_model() {
    Map<String, dynamic> values = controllers_get_data();
    return modelType(
      name: values['name'],
      panel: values['panel'],
      email: values['email'],
      web: values['web'],
      timeZone: values['timeZone'],
      warp_port: values['warp_port'],
      webapi_port: values['webapi_port'],
      log_lines: values['log_lines'],
      cron_daily_time: values['cron_daily_time'],
      cron_hourly_period: values['cron_hourly_period'],
      cron_minly_period: values['cron_minly_period'],
      cron_delay: values['cron_delay'],
      config_number: values['config_number'],
      free_group_id: values['free_group_id'],
      current_user_id: values['current_user_id'],
      base_group_id: values['base_group_id'],
      end_group_id: values['end_group_id'],
      current_group_id: values['current_group_id'],
      bank_account_name: values['bank_account_name'],
      bank_account_card: values['bank_account_card'],
      traffic_today: values['traffic_today'],
      traffic_yesterday: values['traffic_yesterday'],
      traffic_month: values['traffic_month'],
      log_folder: values['log_folder'],
      backup_folder: values['backup_folder'],
      certificate_dir: values['certificate_dir'],
      link_config_service_v2ray: values['link_config_service_v2ray'],
      debug: values['debug'],
      log: values['log'],
      verbose: values['verbose'],
    );
  }

  //--------------------------------[controllers_get_data]
  Map<String, dynamic> controllers_get_data() {
    Map<String, dynamic> controllers_data = {};
    Set<String> intFields = {'warp_port', 'webapi_port', 'log_lines', 'cron_hourly_period', 'cron_minly_period', 'cron_delay', 'config_number', 'free_group_id', 'current_user_id', 'base_group_id', 'end_group_id', 'current_group_id', 'traffic_today', 'traffic_yesterday', 'traffic_month'};
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
        case ValueNotifier<bool>():
          controller.value = false;
        case ValueNotifier<int>():
          controller.value = 0;
        case ValueNotifier<String>():
          controller.value = '';
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
        var data1 = json.decode(await api_mdl.get('${const_api_url}/${api_route}/item'));
        var data2 = modelType.toModel(data1['data']);
        return data2;
    }
  }
}
