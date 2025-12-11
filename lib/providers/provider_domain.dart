//--------------------------------------------------------------------------------- location
// lib/providers/provider_domain.dart

//--------------------------------------------------------------------------------- Description
// This is provider for domain

//--------------------------------------------------------------------------------- Import
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/consts/model.dart';
import 'package:mkpanel_gui/tools/tools.dart';
import 'package:mkpanel_gui/providers/provider_page.dart';
import 'package:mkpanel_gui/models/model_domain.dart';

//--------------------------------------------------------------------------------- Global
typedef modelType_base = model_domain;
String title_base = models_title.domain;

//--------------------------------------------------------------------------------- Provider
class provider_domain with ChangeNotifier {
  //--------------------------------[Fields]
  var _context;
  var _drawer;
  var _prv;
  var _data_base;
  late modelType_base _model_base;

  //--------------------------------[Contractor]
  provider_domain() {
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
    build_notification_2(_context, await model.api(type));
    load();
  }

  //------------------------------[View]
  view() {
    //----------[ui]
    var ui = bul_list_model<modelType_base>(
      context: _context,
      title: title_base,
      model_base: _model_base,
      data_base: _data_base,
      fields: models_fileds.domain,
      action: api,
    );
    //----------[app_bar]
    var app_bar = build_appbar_1(title: title_base);
    //----------[body]
    var body = Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
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
