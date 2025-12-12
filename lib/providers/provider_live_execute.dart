//--------------------------------------------------------------------------------- Location
// lib/providers/provider_live_execute.dart

//--------------------------------------------------------------------------------- Description
// This is provider for live_execute

//--------------------------------------------------------------------------------- Import
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/consts/model.dart';
import 'package:mkpanel_gui/tools/tools.dart';
import 'package:mkpanel_gui/providers/provider_page.dart';
import 'package:mkpanel_gui/models/model_live_execute.dart';
import 'package:mkpanel_gui/models/model_account.dart';
import 'package:mkpanel_gui/models/model_strategy.dart';
import 'package:mkpanel_gui/models/model_strategy_item.dart';

//--------------------------------------------------------------------------------- Global
typedef modelType_account = model_account;
typedef modelType_strategy = model_strategy;
typedef modelType_strategy_item = model_strategy_item;
typedef modelType_base = model_live_execute;
String title_base = models_title.live_execute;
String title_appbar = models_title.base;

//--------------------------------------------------------------------------------- Provider
class provider_live_execute with ChangeNotifier {
  //--------------------------------[Fields]
  var _context;
  var _drawer;
  var _prv;
  var _data_base;
  var _data_account;
  var _data_strategy;
  var _data_strategy_item;
  var _selected_strategy_id;
  var _selected_strategy_item_id;
  late modelType_base _model_base;
  late modelType_account _model_account;
  late modelType_strategy _model_strategy;
  late modelType_strategy_item _model_strategy_item;

  //--------------------------------[Contractor]
  provider_live_execute() {
    _model_base = modelType_base();
    _model_account = modelType_account();
    _model_strategy = modelType_strategy();
    _model_strategy_item = modelType_strategy_item();
  }

  //--------------------------------[Set]
  set context(value) => {(_context = value, _prv = Provider.of<Provider_Page>(_context, listen: false))};
  set drawer(value) => _drawer = value;

  //------------------------------[Logic]
  //----------[load]
  load([String model = 'all']) async {
    switch (model) {
      case 'base':
        _data_base = await _model_base.api('items', "?strategy_item_id=${_selected_strategy_item_id}");
      case 'strategy_item':
        _data_strategy_item = await _model_strategy_item.api('items', "?strategy_id=${_selected_strategy_id}");
        _selected_strategy_item_id = _data_strategy_item.first.id;
        _data_base = await _model_base.api('items', "?strategy_item_id=${_selected_strategy_item_id}");
      default:
        //Account
        _data_account = await _model_account.api('items');
        //Strategy
        _data_strategy = await _model_strategy.api('items');
        _selected_strategy_id = _data_strategy.first.id;
        //Strategy Item
        _data_strategy_item = await _model_strategy_item.api('items', "?strategy_id=${_selected_strategy_id}");
        _selected_strategy_item_id = _data_strategy_item.first.id;
        //Base
        _data_base = await _model_base.api('items', "?strategy_item_id=${_selected_strategy_item_id}");
        reload();
    }
  }

  //----------[reload]
  reload() => _prv.ui = view();

  //----------[api]
  api(type, modelType_base model) async {
    var result = await model.api(type);
    build_notification_2(_context, result);
    await load('base');
    reload();
  }

  //----------[strategy_select]
  strategy_select(value) async {
    _selected_strategy_id = value;
    await load('strategy_item');
    reload();
  }

  //----------[strategy_item_select]
  strategy_item_select(value) async {
    _selected_strategy_item_id = value;
    await load('base');
    reload();
  }

  //------------------------------[view]
  view() {
    //----------[drp_strategy]
    var drp_strategy = IntrinsicWidth(child: SizedBox(child: build_dropdownlist_1<modelType_strategy>(lable: 'Strategy', data: _data_strategy, selected_id: _selected_strategy_id, onChange: strategy_select)));
    //----------[drp_strategy_item]
    var drp_strategy_item = IntrinsicWidth(child: SizedBox(child: build_dropdownlist_1<modelType_strategy_item>(lable: 'Strategy Item', data: _data_strategy_item, selected_id: _selected_strategy_item_id, onChange: strategy_item_select)));
    //----------[ui]
    var ui = widget_ui(
      context: _context,
      title: title_base,
      data_base: _data_base,
      api: api,
      fields: models_fileds.live_execute,
      selected_strategy_item_id: _selected_strategy_item_id,
      data_account: _data_account,
    );
    //----------[app_bar]
    var app_bar = build_appbar_1(title: title_appbar);
    //----------[body]
    var body = SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(const_widget_padding),
          child: Column(
            children: [
              SizedBox(height: const_widget_padding),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(child: Padding(padding: EdgeInsets.only(right: const_widget_padding), child: drp_strategy)),
                  SizedBox(child: Padding(padding: EdgeInsets.only(right: const_widget_padding), child: drp_strategy_item)),
                ],
              ),
              SizedBox(height: const_widget_padding),
              SizedBox(child: Padding(padding: EdgeInsets.only(bottom: const_widget_padding), child: ui)),
            ],
          ),
        ),
      ),
    );
    //----------[return]
    return Scaffold(appBar: app_bar, drawer: _drawer, body: body);
  }
}

//--------------------------------------------------------------------------------- UI
//--------------------------------[widget_ui]
Widget widget_ui<T_base, T_related_1>({
  required BuildContext context,
  required String title,
  required List<modelType_base> data_base,
  required Function(String, modelType_base) api,
  Map<String, dynamic>? fields = const {},
  required int selected_strategy_item_id,
  required List<model_account> data_account,
}) {
  //-----[Variable]
  var items = null;
  var model = modelType_base();

  //-----[Add]
  void add() {
    if (fields != null) items = fields['add'];
    model.controller_clear();
    model.controllers['id'].text = '';
    model.controllers['strategy_item_id'].value = selected_strategy_item_id;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, set) {
            return AlertDialog(
              title: Text('Add'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    build_dropdownlist_3<model_account>(lable: 'Account', data: data_account, controller: model.controller_get('account_id'), selected_id: data_account.first.id),
                    SizedBox(height: const_widget_padding),
                    ...model.controllers.entries.where((entry) => items == null || items.isEmpty || items.containsKey(entry.key)).map((entry) => build_Row_3(items?[entry.key] ?? entry.key, model.controller_get(entry.key))).toList(),
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
                TextButton(onPressed: () => {api("add", model), Navigator.pop(context)}, child: Text('Add')),
              ],
            );
          },
        );
      },
    );
  }

  //-----[Edit]
  void edit(modelType_base model1) {
    var model = (model1 as dynamic);
    if (fields != null) items = fields['edit'];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, set) {
            return AlertDialog(
              title: Text('Edit'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    build_dropdownlist_3<model_account>(lable: 'Account', data: data_account, controller: model.controller_get('account_id'), selected_id: model.account_id),
                    SizedBox(height: const_widget_padding),
                    ...model.controllers.entries.where((entry) => items == null || items.isEmpty || items.containsKey(entry.key)).map((entry) => build_Row_3(items?[entry.key] ?? entry.key, model.controller_get(entry.key))).toList(),
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
                TextButton(onPressed: () => {api("update", model), Navigator.pop(context)}, child: Text('Update')),
              ],
            );
          },
        );
      },
    );
  }

  //-----[Delete]
  void delete(modelType_base model) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete'),
          content: Text('Are you sure you want to delete ${(model as dynamic).name}?'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
            TextButton(onPressed: () => {api("delete", model), Navigator.pop(context)}, child: Text('Delete')),
          ],
        );
      },
    );
  }

  //-----[List]
  if (fields != null) items = fields['list'];
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: IntrinsicWidth(
      child: Card(
        child: Column(
          children: [
            //----------Title
            build_header_3(title: title, leftButton: build_icon_btn_1(onPressed: add, model: const_btn_models.add)),
            //----------header
            DataTable(
              columns: [
                ...model.controllers.keys.where((String key) => (items == null || items.isEmpty || items.containsKey(key))).map((String key) {
                  return DataColumn(label: build_text_1(title: items?[key] ?? key));
                }).toList(),
                DataColumn(label: build_text_1(title: 'Account')),
                DataColumn(label: build_text_1(title: 'Enable')),
                DataColumn(label: build_text_1(title: 'Action')),
              ],
              //----------rows
              rows: data_base.map((value1) {
                var value = (value1 as dynamic);
                final account_name = (data_account as dynamic).firstWhere((i) => i.id == value.account_id).name;
                return DataRow(
                  cells: [
                    ...model.controllers.keys.where((String key) {
                      bool hasKey = items?.containsKey(key) ?? false;
                      return items == null || items.isEmpty || hasKey;
                    }).map((String key) {
                      return build_datacell_1(value: value.getValueByKey(key).toString());
                    }).toList(),
                    build_datacell_1(value: account_name),
                    DataCell(build_icon_1(isAccepted: value.enable), onTap: () => api("status", value)),
                    DataCell(build_action_1(onUpdate: (val) => edit(value), onDelete: (val) => delete(value), value: value)),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    ),
  );
}
