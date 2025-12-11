//--------------------------------------------------------------------------------- location
// lib/providers/provider_dashboard.dart

//--------------------------------------------------------------------------------- Description
// This is provider for provider_dashboard

//--------------------------------------------------------------------------------- Import
import 'package:flutter/material.dart';
import 'package:mkpanel_gui/models/model_certificate.dart';
import 'package:mkpanel_gui/models/model_config.dart';
import 'package:mkpanel_gui/models/model_domain.dart';
import 'package:mkpanel_gui/models/model_service_v2ray_server.dart';
import 'package:mkpanel_gui/models/model_user.dart';
import 'package:mkpanel_gui/models/model_admin.dart';
import 'package:provider/provider.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/consts/model.dart';
import 'package:mkpanel_gui/tools/tools.dart';
import 'package:mkpanel_gui/providers/provider_page.dart';
import 'package:mkpanel_gui/models/model_service_v2ray_inbound.dart';

//--------------------------------------------------------------------------------- Global
String title = models_title.dashboard;
String appbar_title = models_title.dashboard;

//--------------------------------------------------------------------------------- Provider
class provider_dashboard with ChangeNotifier {
  //--------------------------------[Fields]
  var _context;
  var _drawer;
  var _prv;
  var _data_detaile;
  var _usage_today = '0';
  var _usage_yesterday = '0';
  var _usage_month = '0';

  var _version = '0';
  var _icon_enable = build_icon_1();
  var _icon_active = build_icon_1();
  var _btn_status = build_btn_1();
  late model_admin _model_admin;
  late model_config _model_config;
  late model_service_v2ray_server _model_service_v2ray_server;
  late model_service_v2ray_inbound _model_service_v2ray_inbound;
  late model_certificate _model_certificate;
  late model_domain _model_domain;
  late model_user _model_user;

  //--------------------------------[Contractor]
  provider_dashboard() {
    _model_config = model_config();
    _model_service_v2ray_server = model_service_v2ray_server();
    _model_service_v2ray_inbound = model_service_v2ray_inbound();
    _model_certificate = model_certificate();
    _model_domain = model_domain();
    _model_user = model_user();
    _model_admin = model_admin();
  }

  //--------------------------------[Set]
  set context(value) => {_context = value, _prv = Provider.of<Provider_Page>(_context, listen: false)};
  set drawer(value) => _drawer = value;

  //--------------------------------[Logics]
  //----------[load]
  load([String model = 'all']) async {
    switch (model) {
      case 'base':
        _model_service_v2ray_server = await _model_service_v2ray_server.api('item');
      case 'detaile':
        _data_detaile = await _model_service_v2ray_server.api('detaile');
        xray_detaile();
      default:
        _model_config = await _model_config.api('item');
        _model_service_v2ray_server = await _model_service_v2ray_server.api('item');
        _data_detaile = await _model_service_v2ray_server.api('detaile');
        xray_detaile();
        usage();
    }
    reload();
  }

  //----------[reload]
  void reload() => _prv.ui = view();

  //----------[usage]
  usage() {
    //---variable
    _usage_today = formatBytes(_model_config.traffic_today);
    _usage_yesterday = formatBytes(_model_config.traffic_yesterday);
    _usage_month = formatBytes(_model_config.traffic_month);
  }

  //----------[xray_install]
  xray_install() async {
    build_notification_2(_context, await _model_service_v2ray_server.api('install'));
    load('detaile');
  }

  //----------[detaile]
  xray_detaile() {
    //---variable
    _version = _data_detaile['data']['version'];
    var enable = _data_detaile['data']['enable'];
    var active = _data_detaile['data']['active'];
    //---enable
    _icon_enable = build_icon_1(isAccepted: enable == "enable");
    //---active
    _icon_active = build_icon_1(isAccepted: active == "active");
    if (active == "active") _btn_status = build_btn_1(action: xray_stop, lable: 'Stop', color_background: Colors.red, color_text: Colors.white);
    if (active != "active") _btn_status = build_btn_1(action: xray_start, lable: 'Start', color_background: Colors.green, color_text: Colors.white);
  }

  //----------[xray_stop]
  xray_stop() async {
    var result = await _model_service_v2ray_server.api('stop');
    build_notification_2(_context, result);
    await Future.delayed(const Duration(seconds: 1));
    load('detaile');
  }

  //----------[xray_start]
  xray_start() async {
    var result = await _model_service_v2ray_server.api('start');
    build_notification_2(_context, result);
    await Future.delayed(const Duration(seconds: 1));
    load('detaile');
  }

  //----------[inbound_generate]
  inbound_generate() async {
    var result = await _model_service_v2ray_inbound.api('generate');
    build_notification_2(_context, result);
    load('base');
  }

  //----------[inbound_copy]
  inbound_copy() async {
    var result = await _model_service_v2ray_inbound.api('config');
    build_notification_2(_context, result);
    load('base');
  }

  //----------[inbound_certificate]
  inbound_certificate() async {
    var result = await _model_service_v2ray_inbound.api('crt_to_inb');
    result['data'] = result['status'];
    build_notification_2(_context, result);
    load('base');
  }

  //----------[domain_clear]
  domain_clear() async {
    var result = await _model_domain.api('cloudflare_delete');
    build_notification_2(_context, result);
  }

  //----------[domain_add]
  domain_add() async {
    var result1 = await _model_domain.api('cloudflare_add');
    build_notification_2(_context, result1);
  }

  //----------[certificate_generate]
  certificate_add_domain() async {
    var result = await _model_certificate.api('add_domain');
    build_notification_2(_context, result);
  }

  //----------[certificate_generate]
  certificate_generate() async {
    var result = await _model_certificate.api('generate');
    build_notification_2(_context, result);
  }

  //----------[service_v2ray_check]
  credit_check() async {
    //---get result
    var result = await _model_user.credit_check();
    //---show result
    if (result['status']) {
      bul_not_1(_context, result['status'].toString(), isError: false);
    } else {
      bul_not_1(_context, result['status'].toString(), isError: true);
    }
  }

  //----------[reset_usage]
  reset_usage() async {
    //---get result
    var result = await _model_user.reset_usage();
    //---show result
    if (result['status']) {
      bul_not_1(_context, result['status'].toString(), isError: false);
    } else {
      bul_not_1(_context, result['status'].toString(), isError: true);
    }
  }

  //----------[action_user_usage]
  action_user_usage() async {
    //---get result
    var result = await _model_user.api('usage');
    //---show result
    if (result['status']) {
      bul_not_1(_context, result['status'].toString(), isError: false);
    } else {
      bul_not_1(_context, result['status'].toString(), isError: true);
    }
  }

  //----------[cron_daily]
  cron_daily() async {
    //---get result
    var result = await _model_admin.api('cron_daily');
    //---show result
    if (result['status']) {
      bul_not_1(_context, result['status'].toString(), isError: false);
    } else {
      bul_not_1(_context, result['status'].toString(), isError: true);
    }
  }

  //----------[cron_hourly]
  cron_hourly() async {
    //---get result
    var result = await _model_admin.api('cron_hourly');
    //---show result
    if (result['status']) {
      bul_not_1(_context, result['status'].toString(), isError: false);
    } else {
      bul_not_1(_context, result['status'].toString(), isError: true);
    }
  }

  //----------[cron_minly]
  cron_minly() async {
    //---get result
    var result = await _model_admin.api('cron_minly');
    //---show result
    if (result['status']) {
      bul_not_1(_context, result['status'].toString(), isError: false);
    } else {
      bul_not_1(_context, result['status'].toString(), isError: true);
    }
  }

  //--------------------------------[View]
  view() {
    //----------[app_bar]
    var app_bar = build_appbar_1(title: appbar_title);
    //----------[body]
    var body = SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(const_widget_padding),
          child: Column(children: [
            Padding(padding: EdgeInsets.all(const_widget_padding), child: view_v2ray_usage()),
            Padding(padding: EdgeInsets.all(const_widget_padding), child: view_v2ray_server()),
            Padding(padding: EdgeInsets.all(const_widget_padding), child: view_xray_inbound()),
            Padding(padding: EdgeInsets.all(const_widget_padding), child: view_domain()),
            Padding(padding: EdgeInsets.all(const_widget_padding), child: view_certificate()),
            Padding(padding: EdgeInsets.all(const_widget_padding), child: view_user()),
            Padding(padding: EdgeInsets.all(const_widget_padding), child: view_cron()),
          ]),
        ),
      ),
    );

    //----------[return]
    return Scaffold(appBar: app_bar, drawer: _drawer, body: body);
  }

  //--------------------------------------------------------------------------------- UI
  //--------------------------------[view_v2ray_usage]
  Widget view_v2ray_usage() {
    return IntrinsicWidth(
      child: Card(
        child: Column(
          children: [
            build_header_2(title: "Usage"),
            Padding(
              padding: const EdgeInsets.all(const_widget_padding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(children: [Text('Today'), Text(_usage_today)]),
                      SizedBox(width: 20),
                      Column(children: [Text('Yesterday'), Text(_usage_yesterday)]),
                      SizedBox(width: 20),
                      Column(children: [Text('Month'), Text(_usage_month)]),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //--------------------------------[view_v2ray_server]
  Widget view_v2ray_server() {
    return IntrinsicWidth(
      child: Card(
        child: Column(
          children: [
            build_header_2(title: "Server"),
            Padding(
              padding: const EdgeInsets.all(const_widget_padding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(children: [Text('Version'), Text(_version)]),
                      SizedBox(width: 20),
                      Column(children: [Text('Enable'), _icon_enable]),
                      SizedBox(width: 20),
                      Column(children: [Text('Active'), _icon_active]),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(children: [build_btn_1(action: xray_install, lable: 'Install', color_background: Colors.blue, color_text: Colors.white)]),
                      SizedBox(width: 5),
                      Column(children: [_btn_status]),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //--------------------------------[view_xray_inbound]
  Widget view_xray_inbound() {
    return IntrinsicWidth(
      child: Card(
        child: Column(
          children: [
            build_header_2(title: "Xray Inbound"),
            Padding(
              padding: const EdgeInsets.all(const_widget_padding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(children: [build_btn_1(action: inbound_generate, lable: 'Generate')]),
                  SizedBox(width: 5),
                  Column(children: [build_btn_1(action: inbound_copy, lable: 'Copy')]),
                  SizedBox(width: 5),
                  Column(children: [build_btn_1(action: inbound_certificate, lable: 'Certificate')]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //--------------------------------[view_domain]
  Widget view_domain() {
    return IntrinsicWidth(
      child: Card(
        child: Column(
          children: [
            build_header_2(title: "Domain"),
            Padding(
              padding: const EdgeInsets.all(const_widget_padding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(children: [build_btn_1(action: domain_clear, lable: 'Clear')]),
                  SizedBox(width: 5),
                  Column(children: [build_btn_1(action: domain_add, lable: 'Add')]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //--------------------------------[view_certificate]
  Widget view_certificate() {
    return IntrinsicWidth(
      child: Card(
        child: Column(
          children: [
            build_header_2(title: "Certification"),
            Padding(
              padding: const EdgeInsets.all(const_widget_padding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(children: [build_btn_1(action: certificate_add_domain, lable: 'Add domain')]),
                  SizedBox(width: 5),
                  Column(children: [build_btn_1(action: certificate_generate, lable: 'Generate')]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //--------------------------------[view_user]
  Widget view_user() {
    return IntrinsicWidth(
      child: Card(
        child: Column(
          children: [
            build_header_2(title: "User"),
            Padding(
              padding: const EdgeInsets.all(const_widget_padding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(children: [build_btn_1(action: credit_check, lable: 'Credit Check')]),
                  SizedBox(width: 5),
                  Column(children: [build_btn_1(action: reset_usage, lable: 'Reset usage')]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //--------------------------------[view_cron]
  Widget view_cron() {
    return IntrinsicWidth(
      child: Card(
        child: Column(
          children: [
            build_header_2(title: "Cron"),
            Padding(
              padding: const EdgeInsets.all(const_widget_padding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(children: [build_btn_1(action: cron_daily, lable: 'Daily')]),
                  SizedBox(width: 5),
                  Column(children: [build_btn_1(action: cron_hourly, lable: 'Hourly')]),
                  SizedBox(width: 5),
                  Column(children: [build_btn_1(action: cron_minly, lable: 'Minly')]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
