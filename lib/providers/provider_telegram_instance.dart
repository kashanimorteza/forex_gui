//--------------------------------------------------------------------------------- location
// lib/providers/provider_telegram_instance.dart

//--------------------------------------------------------------------------------- Description
// This is provider for telegram_instance

//--------------------------------------------------------------------------------- Import
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/consts/model.dart';
import 'package:mkpanel_gui/tools/tools.dart';
import 'package:mkpanel_gui/providers/provider_page.dart';
import 'package:mkpanel_gui/models/model_telegram_instance.dart';

//--------------------------------------------------------------------------------- Global
typedef modelType_base = model_telegram_instance;
String title_base = models_title.telegram_instance;

//--------------------------------------------------------------------------------- Provider
class provider_telegram_instance with ChangeNotifier {
  //--------------------------------[Fields]
  var _context;
  var _drawer;
  var _prv;
  var _data_base;
  late modelType_base _model_base;

  //--------------------------------[Contractor]
  provider_telegram_instance() {
    _model_base = modelType();
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
        _data_base = await _model_base.api('items');
      default:
        _data_base = await _model_base.api('items');
    }
    reload();
  }

  //----------[reload]
  reload() => _prv.ui = view();

  //----------[api]
  api(type, modelType_base model) async {
    var result = await model.api(type);
    build_notification_2(_context, result);
    load('base');
  }

  //--------------------------------------------------------------------------------- UI
  view() {
    var view_1 = bul_list_com<modelType_base>(
      context: _context,
      title: title_base,
      data_base: _data_base,
      fields: models_fileds.telegram_instance,
      action: api,
    );
    var app_bar = build_appbar_1(title: title_base);
    var body = Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.all(const_widget_padding),
          child: Column(children: [view_1]),
        ),
      ),
    );
    return Scaffold(appBar: app_bar, drawer: _drawer, body: body);
  }
}
