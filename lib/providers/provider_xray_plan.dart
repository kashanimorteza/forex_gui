//--------------------------------------------------------------------------------- location
// lib/providers/provider_service_v2ray_plan.dart

//--------------------------------------------------------------------------------- Description
// This is provider for service_v2ray_plan

//--------------------------------------------------------------------------------- Import
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/consts/model.dart';
import 'package:mkpanel_gui/tools/tools.dart';
import 'package:mkpanel_gui/providers/provider_page.dart';
import 'package:mkpanel_gui/models/model_xray_plan.dart';

//--------------------------------------------------------------------------------- Global
typedef modelType_base = model_xray_plan;
String title_base = models_title.service_v2ray_plan;
String appbar_title = models_title.service_v2ray;

//--------------------------------------------------------------------------------- Provider
class provider_service_v2ray_plan with ChangeNotifier {
  //--------------------------------[Fields]
  var _context;
  var _drawer;
  var _prv;
  var _data_base;
  late modelType_base _model_base;

  //--------------------------------[Contractor]
  provider_service_v2ray_plan() {
    _model_base = modelType();
  }

  //--------------------------------[Set]
  set context(value) => {(_context = value, _prv = Provider.of<Provider_Page>(_context, listen: false))};
  set drawer(value) => _drawer = value;

  //------------------------------[Logic]
  //----------[load]
  load() async => {(_data_base = await _model_base.api('items'), reload())};

  //----------[reload]
  reload() => _prv.ui = view();

  //----------[api]
  api(type, modelType_base model) async {
    var result = await model.api(type);
    build_notification_2(_context, result);
    load();
  }

  //------------------------------[view]
  view() {
    //----------[ui]
    var ui = bul_list_com<modelType_base>(
      context: _context,
      title: title_base,
      data_base: _data_base,
      fields: models_fileds.service_xray_plan,
      action: api,
    );
    //----------[app_bar]
    var app_bar = build_appbar_1(title: appbar_title);
    //----------[body]
    var body = SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(const_widget_padding),
          child: Column(
            children: [ui],
          ),
        ),
      ),
    );
    //----------[return]
    return Scaffold(appBar: app_bar, drawer: _drawer, body: body);
  }
}
