//--------------------------------------------------------------------------------- location
// lib/providers/provider_config.dart

//--------------------------------------------------------------------------------- Description
// This is provider for config

//--------------------------------------------------------------------------------- Import
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mkpanel_gui/providers/provider_page.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/consts/model.dart';
import 'package:mkpanel_gui/tools/tools.dart';
import 'package:mkpanel_gui/models/model_config.dart';

//--------------------------------------------------------------------------------- Global
typedef modelType_base = model_config;
String title = models_title.config;

//--------------------------------------------------------------------------------- Provider
class provider_config with ChangeNotifier {
  //--------------------------------[Fields]
  var _context;
  var _drawer;
  var _prv;
  late modelType_base _model_base;

  //--------------------------------[Contractor]
  provider_config() {
    _model_base = modelType_base();
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
      case 'base':
        _model_base = await _model_base.api('item');
      default:
        _model_base = await _model_base.api('item');
    }
    reload();
  }

  //----------[reload]
  reload() => _prv.ui = view();

  //----------[api]
  api() async {
    var result = await _model_base.api('update');
    build_notification_2(_context, result);
    load('base');
  }

  //--------------------------------------------------------------------------------- UI
  view() {
    //----------[view_1]
    var view_1 = build_complete_2<modelType_base>(
      title: title,
      model_base: _model_base,
      action: api,
      size_lable: 200,
      fields: models_fileds.config,
    );

    //----------[app_bar]
    var app_bar = build_appbar_1(title: title);

    //----------[body]
    var body = SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(const_widget_padding),
          child: Column(
            children: [
              view_1,
            ],
          ),
        ),
      ),
    );

    //----------[return]
    return Scaffold(appBar: app_bar, drawer: _drawer, body: body);
  }
}
