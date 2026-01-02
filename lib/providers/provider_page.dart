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
import 'package:mkpanel_gui/providers/provider_account.dart';
import 'package:mkpanel_gui/providers/provider_instrument.dart';
import 'package:mkpanel_gui/providers/provider_strategy.dart';
import 'package:mkpanel_gui/providers/provider_strategy_item.dart';
import 'package:mkpanel_gui/providers/provider_live_execute.dart';
import 'package:mkpanel_gui/providers/provider_back_execute.dart';
import 'package:mkpanel_gui/providers/provider_profit_manager.dart';

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
    _prv = Provider.of<provider_account>(_context, listen: false);
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
    if (_page == const_model_list.account) _prv = Provider.of<provider_account>(_context, listen: false);
    if (_page == const_model_list.instrument) _prv = Provider.of<provider_instrument>(_context, listen: false);
    if (_page == const_model_list.strategy) _prv = Provider.of<provider_strategy>(_context, listen: false);
    if (_page == const_model_list.strategy_item) _prv = Provider.of<provider_strategy_item>(_context, listen: false);
    if (_page == const_model_list.live_execute) _prv = Provider.of<provider_live_execute>(_context, listen: false);
    if (_page == const_model_list.back_execute) _prv = Provider.of<provider_back_execute>(_context, listen: false);
    if (_page == const_model_list.profit_manager) _prv = Provider.of<provider_profit_manager>(_context, listen: false);
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
