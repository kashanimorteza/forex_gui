//--------------------------------------------------------------------------------- Location
// lib/providers/provider_xray_group.dart

//--------------------------------------------------------------------------------- Description
// This is provider for provider_xray_group

//--------------------------------------------------------------------------------- Import
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/consts/model.dart';
import 'package:mkpanel_gui/tools/tools.dart';
import 'package:mkpanel_gui/providers/provider_page.dart';
import 'package:mkpanel_gui/models/model_network.dart';
import 'package:mkpanel_gui/models/model_route.dart';
import 'package:mkpanel_gui/models/model_way.dart';
import 'package:mkpanel_gui/models/model_service_v2ray_inbound.dart';
import 'package:mkpanel_gui/models/model_xray_group.dart';
import 'package:mkpanel_gui/models/model_alarm.dart';
import 'package:mkpanel_gui/models/model_display.dart';
import 'package:mkpanel_gui/ui/xray_group.dart';
import 'package:mkpanel_gui/models/model_xray_plan.dart';

//--------------------------------------------------------------------------------- Global
String title_base = models_title.service_v2ray_group;

//--------------------------------------------------------------------------------- Provider
class provider_xray_group with ChangeNotifier {
  //--------------------------------[Fields]
  var _context;
  var _drawer;
  var _prv;
  var _data_group;
  var _data_alarm;
  var _data_display;
  var _data_network;
  var _data_way;
  var _data_route;
  var _data_inbound;
  var _data_plan;
  var _data_network_gi;
  var _data_way_gi;
  var _data_route_gi;
  var _data_inbound_gi;
  var _data_plan_gi;
  var _group_selected_id;
  var _network_selected_id;
  var _way_selected_id;
  late model_xray_group _model_group;
  late model_alarm _model_alarm;
  late model_display _model_display;

  //--------------------------------[Contractor]
  provider_xray_group() {
    _model_group = model_xray_group();
    _model_alarm = model_alarm();
    _model_display = model_display();
  }

  //--------------------------------[Set]
  set context(value) {
    _context = value;
    _prv = Provider.of<Provider_Page>(_context, listen: false);
  }

  set drawer(value) => _drawer = value;

  //--------------------------------------------------------------------------------- Logic
  //----------[load]
  load([String model = 'all']) async {
    switch (model) {
      case 'group':
        _data_group = await _model_group.api('items');
      case 'network_gi':
        _data_network_gi = await _model_group.network_gi_items(_group_selected_id);
      case 'way_gi':
        _data_way_gi = await _model_group.way_gi_items(_group_selected_id, _network_selected_id);
      case 'route_gi':
        _data_route_gi = await _model_group.route_gi_items(_group_selected_id, _network_selected_id, _way_selected_id);
      case 'inbound_gi':
        _data_inbound_gi = await _model_group.inbound_gi_items(_group_selected_id);
      case 'plan_gi':
        _data_plan_gi = await _model_group.plan_gi_items(_group_selected_id);
      default:
        //data
        _data_group = await _model_group.api('items');
        _data_alarm = await _model_alarm.api('items');
        _data_display = await _model_display.api('items');
        _data_network = await model_network().api('items');
        _data_way = await model_way().api('items');
        _data_route = await model_route().api('items');
        _data_inbound = await model_service_v2ray_inbound().api('items');
        _data_plan = await model_xray_plan().api('items');
        //selected
        _group_selected_id = _data_group.first.id;
        _network_selected_id = _data_network.first.id;
        _way_selected_id = _data_way.first.id;
        //gi
        _data_network_gi = await _model_group.network_gi_items(_group_selected_id);
        _data_way_gi = await _model_group.way_gi_items(_group_selected_id, _network_selected_id);
        _data_route_gi = await _model_group.route_gi_items(_group_selected_id, _network_selected_id, _way_selected_id);
        _data_inbound_gi = await _model_group.inbound_gi_items(_group_selected_id);
        _data_plan_gi = await _model_group.plan_gi_items(_group_selected_id);

        reload();
    }
  }

  //----------[reload]
  reload() => _prv.ui = view();

  //----------[action]
  api(type, model_xray_group model) async {
    var result = await model.api(type);
    build_notification_2(_context, result);
    await load('group');
    await load('network_gi');
    await load('way_gi');
    await load('route_gi');
    await load('plan_gi');
    await load('inbound_gi');
    reload();
  }

  //----------[group_select]
  group_select(value) async {
    _group_selected_id = value;
    await load('network_gi');
    await load('way_gi');
    await load('route_gi');
    await load('plan_gi');
    await load('inbound_gi');
    reload();
  }

  //----------[network_select]
  network_select(value) async {
    _network_selected_id = value;
    await load('way_gi');
    await load('route_gi');
    await load('plan_gi');
    reload();
  }

  //----------[way_select]
  way_select(value) async {
    _way_selected_id = value;
    await load('route_gi');
    await load('plan_gi');
    reload();
  }

  //----------[network_change]
  network_change(int network_id, bool enable) async {
    var result = await _model_group.network_gi_fill(_group_selected_id, network_id, enable);
    build_notification_2(_context, result);
    await load('network_gi');
    reload();
  }

  //----------[way_change]
  way_change(int way_id, bool enable) async {
    var result = await _model_group.way_gi_fill(_group_selected_id, _network_selected_id, way_id, enable);
    build_notification_2(_context, result);
    await load('way_gi');
    reload();
  }

  //----------[route_change]
  route_change(int route_id, bool enable) async {
    var result = await _model_group.route_gi_fill(_group_selected_id, _network_selected_id, _way_selected_id, route_id, enable);
    build_notification_2(_context, result);
    await load('route_gi');
    reload();
  }

  //----------[plan_change]
  plan_change(int plan_id, String item, value) async {
    var result = await _model_group.plan_gi_fill(_group_selected_id, plan_id, item, value);
    build_notification_2(_context, result);
    await load('plan_gi');
    reload();
  }

  //----------[inbound_change]
  inbound_change(int inbound_id, String item, bool enable) async {
    var result = await _model_group.inbound_gi_fill(_group_selected_id, inbound_id, item, enable);
    build_notification_2(_context, result);
    await load('inbound_gi');
    reload();
  }

  //--------------------------------------------------------------------------------- UI
  view() {
    //----------[group_group]
    var view_ui_v2ray_group = ui_group<model_xray_group, model_alarm, model_display>(
      context: _context,
      title: title_base,
      data_base: _data_group,
      data_related_1: _data_alarm,
      data_related_2: _data_display,
      action: api,
      fields: models_fileds.group,
    );
    //----------[group_drp]
    var group_drp = IntrinsicWidth(
        child: SizedBox(
            child: bul_drp_list<model_xray_group>(
      lable: 'Groups',
      data: _data_group,
      selected_id: _group_selected_id,
      onChange: group_select,
    )));
    //----------[network_drp]
    var network_drp = IntrinsicWidth(
        child: SizedBox(
            child: bul_drp_list<model_network>(
      lable: 'Networks',
      data: _data_network,
      selected_id: _network_selected_id,
      onChange: network_select,
    )));
    //----------[way_drp]
    var way_drp = IntrinsicWidth(
        child: SizedBox(
            child: bul_drp_list<model_way>(
      lable: 'Ways',
      data: _data_way,
      selected_id: _way_selected_id,
      onChange: way_select,
    )));
    //----------[ui_v2ray_network]
    var view_ui_v2ray_network = ui_v2ray_network(
      title: "Network",
      data_base: _data_network,
      data_gi: _data_network_gi,
      action: network_change,
    );
    //----------[ui_v2ray_way]
    var view_ui_v2ray_way = ui_v2ray_way(
      title: "Way",
      data_base: _data_way,
      data_gi: _data_way_gi,
      action: way_change,
    );
    //----------[ui_v2ray_route]
    var view_ui_v2ray_route = ui_v2ray_route(
      title: "Route",
      data_base: _data_route,
      data_gi: _data_route_gi,
      action: route_change,
    );
    //----------[ui_v2ray_plan]
    var view_ui_v2ray_plan = ui_v2ray_plan(
      title: "Plan",
      data_base: _data_plan,
      data_gi: _data_plan_gi,
      action: plan_change,
    );
    //----------[ui_v2ray_route]
    var view_ui_v2ray_inbound = ui_v2ray_inbound(
      title: "Inbound",
      data_base: _data_inbound,
      data_gi: _data_inbound_gi,
      action: inbound_change,
    );
    //----------[app_bar]
    var app_bar = build_appbar_1(title: models_title.service_v2ray);
    //----------[Body]
    var body = SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(const_widget_padding),
          child: Column(
            children: [
              SizedBox(child: Padding(padding: EdgeInsets.only(bottom: const_widget_padding), child: view_ui_v2ray_group)),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(child: Padding(padding: EdgeInsets.only(right: const_widget_padding), child: group_drp)),
                  SizedBox(width: 100, child: Padding(padding: EdgeInsets.only(right: const_widget_padding), child: network_drp)),
                  SizedBox(child: Padding(padding: EdgeInsets.only(right: 0), child: way_drp)),
                ],
              ),
              SizedBox(height: 10),
              SizedBox(child: Padding(padding: EdgeInsets.only(bottom: const_widget_padding), child: view_ui_v2ray_network)),
              SizedBox(child: Padding(padding: EdgeInsets.only(bottom: const_widget_padding), child: view_ui_v2ray_way)),
              SizedBox(child: Padding(padding: EdgeInsets.only(bottom: const_widget_padding), child: view_ui_v2ray_route)),
              SizedBox(child: Padding(padding: EdgeInsets.only(bottom: const_widget_padding), child: view_ui_v2ray_plan)),
              SizedBox(child: Padding(padding: EdgeInsets.only(bottom: const_widget_padding), child: view_ui_v2ray_inbound)),
            ],
          ),
        ),
      ),
    );
    //----------[Return]
    return Scaffold(appBar: app_bar, drawer: _drawer, body: body);
  }
}
