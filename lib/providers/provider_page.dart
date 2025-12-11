//--------------------------------------------------------------------------------- location
// lib/providers/provider_page.dart

//--------------------------------------------------------------------------------- Description
/*
  lib/consts/general.dart > const_model_list | const_model_mode
  lib/consts/page.dart    > const_model_mode
  lib/pages/
*/

//--------------------------------------------------------------------------------- Import
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mkpanel_gui/consts/model.dart';
import 'package:mkpanel_gui/providers/provider_dashboard.dart';
import 'package:mkpanel_gui/providers/provider_log.dart';
import 'package:mkpanel_gui/providers/provider_user.dart';
import 'package:mkpanel_gui/providers/provider_config.dart';
import 'package:mkpanel_gui/providers/provider_service.dart';
import 'package:mkpanel_gui/providers/provider_service_v2ray_server.dart';
import 'package:mkpanel_gui/providers/provider_service_v2ray_inbound.dart';
import 'package:mkpanel_gui/providers/provider_xray_plan.dart';
import 'package:mkpanel_gui/providers/provider_xray_group.dart';
import 'package:mkpanel_gui/providers/provider_group.dart';
import 'package:mkpanel_gui/providers/provider_network.dart';
import 'package:mkpanel_gui/providers/provider_way.dart';
import 'package:mkpanel_gui/providers/provider_server.dart';
import 'package:mkpanel_gui/providers/provider_domain.dart';
import 'package:mkpanel_gui/providers/provider_certificate.dart';
import 'package:mkpanel_gui/providers/provider_route.dart';
import 'package:mkpanel_gui/providers/provider_alarm.dart';
import 'package:mkpanel_gui/providers/provider_display.dart';
import 'package:mkpanel_gui/providers/provider_telegram_instance.dart';

//--------------------------------------------------------------------------------- Provider
class Provider_Page with ChangeNotifier {
//--------------------------------[Fields]
  var _context;
  var _drawer;
  var _prv;
  var _ui = Scaffold();
  var _page = const_model_list.dashboard;
  var _mode = const_model_mode.view;

//--------------------------------[Get]
  get context => _context;
  get drawer => _drawer;
  get prv => _prv;
  get page => _page;
  get mode => _mode;
  get ui => _ui;

//--------------------------------[Set]
//----------[Context]
  set context(var value) {
    print('--- Provider : Page : set context');
    _context = value;
    _prv = Provider.of<provider_user>(_context, listen: false);
    _prv.context = _context;
    _prv.drawer = _drawer;
    _prv.load();
  }

//----------[Drawer]
  set drawer(var value) {
    print('--- Provider : Page : set drawer');
    _drawer = value;
  }

//----------[Page]
  set page(var value) {
    print('--- Provider : Page : set page');
    _page = value;
    if (_page == const_model_list.dashboard) _prv = Provider.of<provider_dashboard>(_context, listen: false);
    if (_page == const_model_list.user) _prv = Provider.of<provider_user>(_context, listen: false);
    if (_page == const_model_list.log) _prv = Provider.of<provider_log>(_context, listen: false);
    if (_page == const_model_list.config) _prv = Provider.of<provider_config>(_context, listen: false);
    if (_page == const_model_list.service_v2ray_server) _prv = Provider.of<provider_service_v2ray_server>(_context, listen: false);
    if (_page == const_model_list.service_v2ray_inbound) _prv = Provider.of<provider_service_v2ray_inbound>(_context, listen: false);
    if (_page == const_model_list.service_v2ray_plan) _prv = Provider.of<provider_service_v2ray_plan>(_context, listen: false);
    if (_page == const_model_list.service_v2ray_group) _prv = Provider.of<provider_xray_group>(_context, listen: false);
    if (_page == const_model_list.service) _prv = Provider.of<provider_service>(_context, listen: false);
    if (_page == const_model_list.domain) _prv = Provider.of<provider_domain>(_context, listen: false);
    if (_page == const_model_list.certificate) _prv = Provider.of<provider_certificate>(_context, listen: false);
    if (_page == const_model_list.network) _prv = Provider.of<provider_network>(_context, listen: false);
    if (_page == const_model_list.way) _prv = Provider.of<provider_way>(_context, listen: false);
    if (_page == const_model_list.server) _prv = Provider.of<provider_server>(_context, listen: false);
    if (_page == const_model_list.route) _prv = Provider.of<provider_route>(_context, listen: false);
    if (_page == const_model_list.group) _prv = Provider.of<provider_group>(_context, listen: false);
    if (_page == const_model_list.alarm) _prv = Provider.of<provider_alarm>(_context, listen: false);
    if (_page == const_model_list.display) _prv = Provider.of<provider_display>(_context, listen: false);
    if (_page == const_model_list.telegram_instance) _prv = Provider.of<provider_telegram_instance>(_context, listen: false);
    _prv.context = _context;
    _prv.drawer = _drawer;
    _prv.load();
  }

  //----------[Mode]
  set mode(var value) {
    print('--- Provider : Page : set mode');
    _mode = value;
    _prv.load();
  }

  //----------[UI]
  set ui(value) {
    print('--- Provider : Page : set ui');
    _ui = value;
    notifyListeners();
  }

  //----------[Contractor]
  Provider_Page() {
    print('--- Provider : Page : Contractor');
  }
}
