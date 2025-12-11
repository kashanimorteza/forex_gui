//--------------------------------------------------------------------------------- location
// lib/providers/provider_user.dart

//--------------------------------------------------------------------------------- Description
// This is provider for user

//--------------------------------------------------------------------------------- Import
import 'package:flutter/material.dart';
import 'package:mkpanel_gui/models/model_user_card.dart';
import 'package:mkpanel_gui/models/model_xray_group.dart';
import 'package:provider/provider.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/consts/model.dart';
import 'package:mkpanel_gui/tools/tools.dart';
import 'package:mkpanel_gui/providers/provider_page.dart';
import 'package:mkpanel_gui/models/model_xray_plan.dart';
import 'package:mkpanel_gui/models/model_user_xray.dart';
import 'package:mkpanel_gui/models/model_user_group.dart';
import 'package:mkpanel_gui/models/model_user.dart';
import 'package:mkpanel_gui/ui/ui_user.dart';
import 'package:mkpanel_gui/models/model_user_payment.dart';

//--------------------------------------------------------------------------------- Global
String title = models_title.user;

//--------------------------------------------------------------------------------- Provider
class provider_user with ChangeNotifier {
  //--------------------------------[Fields]
  var _context;
  var _drawer;
  var _prv;
  var _state;
  var _search_txt_user;
  var _search_txt_service;
  var _search_subject;
  var _search_txt;
  var _search_drp;
  var _user_selected_id;
  var _user_selected_data;
  var _data_user_card;
  var _data_user_payment;
  var _data_user_group;
  var _data_xray_group;
  var _data_xray_plan;
  var _data_user_xray;
  var _data_base;
  late const_search_user _search_drp_user;
  late const_search_service _search_drp_service;
  late model_user _model_user;
  late model_user_group _model_user_group;
  late model_user_card _model_user_card;
  late model_user_payment _model_user_payment;
  late model_xray_group _model_xray_group;
  late model_user_xray _model_user_xray;
  late model_xray_plan _model_xray_plan;

  //--------------------------------[Contractor]
  provider_user() {
    _search_txt_user = '';
    _search_txt_service = '';
    _search_drp_user = const_search_user.User;
    _search_drp_service = const_search_service.Online;
    _model_user = model_user();
    _model_user_group = model_user_group();
    _model_user_card = model_user_card();
    _model_user_payment = model_user_payment();
    _model_user_xray = model_user_xray();
    _model_xray_plan = model_xray_plan();
    _model_xray_group = model_xray_group();
  }

  //--------------------------------[Set]
  set context(value) => {_context = value, _prv = Provider.of<Provider_Page>(_context, listen: false)};
  set drawer(value) => _drawer = value;

  //--------------------------------------------------------------------------------- Logic
  //----------[load]
  load([String model = 'all', int id = 0]) async {
    switch (model) {
      case 'base':
        _data_base = await _model_user.search(_search_subject, _search_drp, _search_txt);
      case 'user_selected':
        _user_selected_data = await _model_user.api('item', id = _user_selected_id);
      case 'user_card':
        _data_user_card = await _model_user_card.items(_user_selected_id);
      case 'user_payment':
        _data_user_payment = await _model_user_payment.items(_user_selected_id);
      case 'user_xray':
        _data_user_xray = await _model_user_xray.items(_user_selected_id);
      default:
        _data_base = await _model_user.search(_search_subject, _search_drp, _search_txt);
        _data_user_group = await _model_user_group.api('items');
        _data_xray_plan = await _model_xray_plan.api('items');
        _data_xray_group = await _model_xray_group.api('items');
        _state = const_page_state.View;
        reload();
    }
  }

  //----------[reload]
  reload() => _prv.ui = viewHandler();

  //----------[action]
  api(type, model_user model) async {
    var result;
    if (type == "add") (result = await model.api('add'), load('base'));
    if (type == "update") result = await model.api('update');
    if (type == "enable") result = await model.status(type);
    if (type == "disable") result = await model.status(type);
    if (type == "delete") result = await model.status(type);
    result['status'] ? bul_not_1(_context, result['status'].toString(), isError: false) : bul_not_1(_context, result['status'].toString(), isError: true);
    load('base');
    reload();
  }

  //----------[search_user]
  search_user(String txt, const_search_user drp) async {
    _search_subject = 'user';
    _search_txt_user = txt;
    _search_drp_user = drp;
    _search_txt = txt;
    _search_drp = drp.name;
    await load('base');
    reload();
  }

  //----------[search_service]
  search_service(String txt, const_search_service drp) async {
    _search_subject = 'service';
    _search_txt_service = txt;
    _search_drp_service = drp;
    _search_txt = txt;
    _search_drp = drp.name;
    await load('base');
    reload();
  }

  //----------[action_select_user]
  action_select_user(int value) async {
    _state = const_page_state.Edit;
    _user_selected_id = value;
    await load('user_selected');
    await load('user_xray');
    await load('user_card');
    await load('user_payment');
    reload();
  }

  //----------[action_user_add]
  action_user_add(model_user model) async {
    //---get result
    var result = await model.add();
    //---show result
    if (result['status']) {
      bul_not_1(_context, result['status'].toString(), isError: false);
    } else {
      bul_not_1(_context, result['status'].toString(), isError: true);
    }
    //---reload
    await load('base');
    reload();
  }

  //----------[action_user_group_change]
  action_user_group_change(model_user model) async {
    //---get result
    var result = await model.api('update');
    //---show result
    if (result['status']) {
      bul_not_1(_context, result['status'].toString(), isError: false);
    } else {
      bul_not_1(_context, result['status'].toString(), isError: true);
    }
    //---reload
    await load('base');
    reload();
  }

  //----------[action_user_enable_change]
  action_user_enable_change(model_user model, bool value) async {
    //---get result
    var result;
    value ? result = await model.status('disable') : result = await model.status('enable');
    //---show result
    if (result['status']) {
      bul_not_1(_context, result['status'].toString(), isError: false);
    } else {
      bul_not_1(_context, result['status'].toString(), isError: true);
    }
    //---reload
    await load('base');
    reload();
  }

  //----------[action_user_delete_change]
  action_user_delete_change(model_user model, bool value) async {
    //---get result
    var result;
    value ? result = await model.status('enable') : result = await model.status('delete');
    //---show result
    if (result['status']) {
      bul_not_1(_context, result['status'].toString(), isError: false);
    } else {
      bul_not_1(_context, result['status'].toString(), isError: true);
    }
    //---reload
    await load('base');
    reload();
  }

  //----------[action_account]
  action_account(model_user user) async {
    //---get result
    var result = await user.api('update');
    //---show result
    if (result['status']) {
      bul_not_1(_context, result['status'].toString(), isError: false);
    } else {
      bul_not_1(_context, result['status'].toString(), isError: true);
    }
    //---reload
    await load('user_selected');
    reload();
  }

  //----------[action_card]
  action_card(String type, model_user_card model) async {
    var result;
    model.controllers['user_id']?.text = _user_selected_id.toString();
    result = (type == 'add') ? await model.add() : result;
    result = (type == 'update') ? await model.update() : result;
    result = (type == 'delete') ? await model.delete() : result;
    result['status'] ? bul_not_1(_context, result['status'].toString(), isError: false) : bul_not_1(_context, result['status'].toString(), isError: true);
    await load('user_card');
    reload();
  }

  //----------[action_payment]
  action_payment(String type, model_user_payment model) async {
    var result;
    model.controllers['user_id']?.text = _user_selected_id.toString();
    model.controllers['type']?.text = "in";
    result = (type == 'add') ? await model.add() : result;
    result['status'] ? bul_not_1(_context, result['status'].toString(), isError: false) : bul_not_1(_context, result['status'].toString(), isError: true);
    await load('user_payment');
    await load('user_selected');
    reload();
  }

  //----------[action_xray_add]
  action_xray_add(int group_id, int plan_id, String name) async {
    //---get result
    var result = await _model_user_xray.add(_user_selected_id, group_id, plan_id, name);
    //---show result
    if (result['status']) {
      bul_not_1(_context, result['status'].toString(), isError: false);
    } else {
      bul_not_1(_context, result['status'].toString(), isError: true);
    }
    //---reload
    await load('user_xray');
    await load('user_payment');
    await load('user_selected');
    reload();
  }

  //----------[action_xray_update]
  action_xray_update(model_user_xray model) async {
    //---get result
    var result = await model.update();
    //---show result
    if (result['status']) {
      bul_not_1(_context, result['status'].toString(), isError: false);
    } else {
      bul_not_1(_context, result['status'].toString(), isError: true);
    }
    //---reload
    await load('user_xray');
    reload();
  }

  //----------[action_xray_delete]
  action_xray_delete(model_user_xray model) async {
    //---get result
    var result = await model.delete();
    //---show result
    if (result['status']) {
      bul_not_1(_context, result['status'].toString(), isError: false);
    } else {
      bul_not_1(_context, result['status'].toString(), isError: true);
    }
    //---reload
    await load('user_xray');
    reload();
  }

  //----------[action_xray_group_change]
  action_xray_group_change(int id, int group_id) async {
    //---get result
    var result = await _model_user_xray.group_change(id, group_id);
    //---show result
    if (result['status']) {
      bul_not_1(_context, result['status'].toString(), isError: false);
    } else {
      bul_not_1(_context, result['status'].toString(), isError: true);
    }
    //---reload
    await load('user_xray');
    reload();
  }

  //----------[action_xray_plan_change]
  action_xray_plan_change(int id, int plan_id) async {
    //---get result
    var result = await _model_user_xray.plan_change(id, plan_id);
    //---show result
    if (result['status']) {
      bul_not_1(_context, result['status'].toString(), isError: false);
    } else {
      bul_not_1(_context, result['status'].toString(), isError: true);
    }
    //---reload
    await load('user_xray');
    reload();
  }

  //----------[action_xray_status_change]
  action_xray_status_change(int id, bool status) async {
    //---get result
    var result = await _model_user_xray.status_change(id, !status);
    //---show result
    if (result['status']) {
      bul_not_1(_context, result['status'].toString(), isError: false);
    } else {
      bul_not_1(_context, result['status'].toString(), isError: true);
    }
    //---reload
    await load('user_xray');
    reload();
  }

  //----------[action_xray_uuid_change]
  action_xray_uuid_change(int id) async {
    //---get result
    var result = await _model_user_xray.uuid_change(id);
    //---show result
    if (result['status']) {
      bul_not_1(_context, result['status'].toString(), isError: false);
    } else {
      bul_not_1(_context, result['status'].toString(), isError: true);
    }
    //---reload
    await load('user_xray');
    reload();
  }

  //----------[action_xray_config_get]
  action_xray_config_get(int id) async {
    //---get result
    var result = await _model_user_xray.config_get(id);
    //---show result
    if (result['status']) {
      bul_not_1(_context, result['status'].toString(), isError: false);
    } else {
      bul_not_1(_context, result['status'].toString(), isError: true);
    }
    //---return
    return result;
  }

  //----------[action_xray_reset]
  action_xray_reset(int id) async {
    //---get result
    var result = await _model_user_xray.reset(id);
    //---show result
    if (result['status']) {
      bul_not_1(_context, result['status'].toString(), isError: false);
    } else {
      bul_not_1(_context, result['status'].toString(), isError: true);
    }
    //---reload
    await load('user_xray');
    await load('user_selected');
    await load('user_payment');
    reload();
  }

  //--------------------------------------------------------------------------------- UI
  viewHandler() {
    //----------[Variable]
    List<Widget> view = [];
    List<String> tabTitles = [];
    //----------[app_bar]
    var app_bar = build_appbar_1(title: title);
    //----------State:View
    if (_state == const_page_state.View) {
      var view_1 = ui_search<model_user, model_user_group>(
        context: _context,
        title: 'Users',
        data_user: _search_txt_user,
        data_service: _search_txt_service,
        drp_user: _search_drp_user,
        drp_service: _search_drp_service,
        action_search_user: search_user,
        action_search_service: search_service,
        action_user_add: action_user_add,
        instance_user: model_user(),
        data_groups: _data_user_group,
        fields: models_fileds.user,
      );
      var view_2 = ui_users<model_user, model_user_group>(
        context: _context,
        title: 'List',
        users: _data_base,
        groups: _data_user_group,
        action_user_group_change: action_user_group_change,
        action_user_enable_change: action_user_enable_change,
        action_user_delete_change: action_user_delete_change,
        action_select_user: action_select_user,
      );
      view = [
        Padding(padding: EdgeInsets.all(const_widget_padding), child: view_1),
        Padding(padding: EdgeInsets.all(const_widget_padding), child: view_2),
      ];
      var body = SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(const_widget_padding),
            child: Column(children: view),
          ),
        ),
      );
      return Scaffold(appBar: app_bar, drawer: _drawer, body: body);
    }
    //----------State:Edit
    if (_state == const_page_state.Edit) {
      tabTitles = ['Account', 'Card', 'Payment', 'Xray'];
      var ui_update = bul_dict_model<model_user>(
        title: 'Account',
        model: _user_selected_data,
        action: action_account,
        fields: models_fileds.user,
        size_lable: 200,
      );
      var view_card = ui_card<model_user_card>(
        context: _context,
        title: 'Card',
        model_base: _model_user_card,
        data_base: _data_user_card,
        action: action_card,
        fields: models_fileds.user_card,
      );
      var view_payment = ui_payment<model_user_payment>(
        context: _context,
        title: 'Payment',
        model_base: _model_user_payment,
        data_base: _data_user_payment,
        action: action_payment,
        fields: models_fileds.user_payment,
      );
      var view_xray = ui_xray<model_user, model_user_xray, model_xray_group, model_xray_plan>(
        context: _context,
        title: 'Xray',
        instance_model_user_xray: _model_user_xray,
        instance_model_xray_group: _model_xray_group,
        instance_model_xray_plan: _model_xray_plan,
        data_user_xray: _data_user_xray,
        data_xray_group: _data_xray_group,
        data_xray_plan: _data_xray_plan,
        action_xray_add: action_xray_add,
        action_xray_delete: action_xray_delete,
        action_xray_update: action_xray_update,
        action_xray_group_change: action_xray_group_change,
        action_xray_plan_change: action_xray_plan_change,
        action_xray_status_change: action_xray_status_change,
        action_xray_uuid_change: action_xray_uuid_change,
        action_xray_config_get: action_xray_config_get,
        action_xray_reset: action_xray_reset,
        fields: models_fileds.user_xray,
      );
      view = [
        Padding(padding: EdgeInsets.all(const_widget_padding), child: ui_update),
        Padding(padding: EdgeInsets.all(const_widget_padding), child: view_card),
        Padding(padding: EdgeInsets.all(const_widget_padding), child: view_payment),
        Padding(padding: EdgeInsets.all(const_widget_padding), child: view_xray),
      ];
      var body = DefaultTabController(
        length: view.length,
        child: Column(
          children: [
            TabBar(isScrollable: true, tabs: tabTitles.map((title) => Tab(text: title)).toList()),
            Expanded(child: TabBarView(children: view.map((widget) => SingleChildScrollView(child: Center(child: widget))).toList())),
          ],
        ),
      );
      return Scaffold(appBar: app_bar, drawer: _drawer, body: body);
    }
  }
}
