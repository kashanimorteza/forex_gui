//--------------------------------------------------------------------------------- location
// lib/providers/provider_way.dart

//--------------------------------------------------------------------------------- Description
// This is provider for way

//--------------------------------------------------------------------------------- Import

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/consts/model.dart';
import 'package:mkpanel_gui/tools/tools.dart';
import 'package:mkpanel_gui/providers/provider_page.dart';
import 'package:mkpanel_gui/models/model_way.dart';

//--------------------------------------------------------------------------------- Global
typedef modelType_base = model_way;
String title_base = models_title.way;

//--------------------------------------------------------------------------------- Provider
class provider_start with ChangeNotifier {
  //--------------------------------[Fields]
  var _context;
  var _drawer;
  var _prv;
  //--------------------------------[Contractor]
  provider_start() {}

  //--------------------------------[Set]
  set context(value) {
    _context = value;
    _prv = Provider.of<Provider_Page>(_context, listen: false);
  }

  set drawer(value) => _drawer = value;

  //--------------------------------------------------------------------------------- Logic
  //----------[load]
  load([String model = 'all']) async {
    await Future.delayed(Duration(milliseconds: 3));
    _prv.ui = view();
  }

  //--------------------------------------------------------------------------------- UI
  view() {
    var view_1 = Text('Starts');
    var app_bar = build_appbar_1(title: title_base);
    var body = SingleChildScrollView(child: Center(child: Padding(padding: EdgeInsets.all(const_widget_padding), child: Column(children: [view_1]))));
    return Scaffold(appBar: app_bar, drawer: _drawer, body: body);
  }
}
