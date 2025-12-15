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
import 'package:mkpanel_gui/models/model_live_order.dart';
import 'package:mkpanel_gui/models/model_account.dart';
import 'package:mkpanel_gui/models/model_strategy.dart';
import 'package:mkpanel_gui/models/model_strategy_item.dart';

//--------------------------------------------------------------------------------- Global
typedef modelType_account = model_account;
typedef modelType_strategy = model_strategy;
typedef modelType_strategy_item = model_strategy_item;
typedef modelType_base = model_live_execute;
typedef modelType_order = model_live_order;
String title_base = models_title.live_execute;
String title_order = models_title.live_order;
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
  var _data_order;
  var _selected_strategy_id = 0;
  var _selected_strategy_item_id = 0;
  var _selected_execute_id = 0;
  late modelType_base _model_base;
  late modelType_account _model_account;
  late modelType_strategy _model_strategy;
  late modelType_strategy_item _model_strategy_item;
  late modelType_order _model_order;

  //--------------------------------[Contractor]
  provider_live_execute() {
    _model_base = modelType_base();
    _model_account = modelType_account();
    _model_strategy = modelType_strategy();
    _model_strategy_item = modelType_strategy_item();
    _model_order = modelType_order();
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
        if (_data_strategy_item.isNotEmpty)
          _selected_strategy_item_id = _data_strategy_item.first.id;
        else
          _selected_strategy_item_id = 0;

        _data_base = await _model_base.api('items', "?strategy_item_id=${_selected_strategy_item_id}");
      default:
        //Account
        _data_account = await _model_account.api('items');
        //Strategy
        _data_strategy = await _model_strategy.api('items');
        if (_data_strategy.isNotEmpty) _selected_strategy_id = _data_strategy.first.id;
        //Strategy Item
        _data_strategy_item = await _model_strategy_item.api('items', "?strategy_id=${_selected_strategy_id}");
        if (_data_strategy_item.isNotEmpty)
          _selected_strategy_item_id = _data_strategy_item.first.id;
        else
          _selected_strategy_item_id = 0;
        //Base
        _data_base = await _model_base.api('items', "?strategy_item_id=${_selected_strategy_item_id}");
        //Orders
        _selected_execute_id = _data_base.isNotEmpty ? _data_base.first.id : 0;
        _data_order = await _model_order.api('items', "?execute_id=${_selected_execute_id}");
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
    var drp_strategy = IntrinsicWidth(child: SizedBox(child: build_dropdownlist_1<modelType_strategy>(lable: 'Strategy', data: _data_strategy, selected_id: _selected_strategy_id, onChange: strategy_select)), stepWidth: 100);
    //----------[drp_strategy_item]
    var drp_strategy_item = IntrinsicWidth(child: SizedBox(child: build_dropdownlist_1<modelType_strategy_item>(lable: 'Item', data: _data_strategy_item, selected_id: _selected_strategy_item_id, onChange: strategy_item_select)), stepWidth: 100);
    //----------[drp_execute]
    var drp_execute = IntrinsicWidth(child: SizedBox(child: build_dropdownlist_1<modelType_base>(lable: 'Execute', data: _data_base, selected_id: _selected_strategy_item_id, onChange: strategy_item_select)), stepWidth: 100);
    //----------[ui]
    var ui_1 = widget_ui_1(
      context: _context,
      title: title_base,
      data_base: _data_base,
      api: api,
      fields: models_fileds.live_execute,
      selected_strategy_item_id: _selected_strategy_item_id,
      data_account: _data_account,
    );
    var ui_2 = widget_ui_2<modelType_order>(
      context: _context,
      title: models_title.live_order,
      data_base: _data_order,
      api: api,
      fields: models_fileds.live_order,
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
              SizedBox(child: Padding(padding: EdgeInsets.only(bottom: const_widget_padding), child: ui_1)),
              SizedBox(height: const_widget_padding),
              SizedBox(height: const_widget_padding),
              SizedBox(height: const_widget_padding),
              SizedBox(child: Padding(padding: EdgeInsets.only(right: const_widget_padding), child: drp_execute)),
              SizedBox(height: const_widget_padding),
              SizedBox(child: Padding(padding: EdgeInsets.only(bottom: const_widget_padding), child: ui_2)),
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
//--------------------------------[widget_ui_1]
Widget widget_ui_1<T_base, T_related_1>({
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
  if (data_account.isEmpty) return Center(child: Text('There is no Account'));
  if (selected_strategy_item_id == 0) return Center(child: Text('There is no strategy item'));
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
                DataColumn(label: build_text_1(title: 'Action')),
                DataColumn(label: build_text_1(title: 'Edit')),
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
                    DataCell(
                      value.status == 'start' ? IconButton(icon: const Icon(Icons.stop), onPressed: () => api("stop", value)) : IconButton(icon: const Icon(Icons.play_arrow), onPressed: () => api("start", value)),
                    ),
                    DataCell(build_action_2(status: (val) => api("status", value), edit: (val) => edit(value), delete: (val) => delete(value), value: value)),
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

//--------------------------------[widget_ui_2]
Widget widget_ui_2<T_base>({
  required BuildContext context,
  required String title,
  required List<modelType_order> data_base,
  required Function(String, modelType_base) api,
  Map<String, dynamic>? fields = const {},
}) {
  //-----[Variable]
  var items = null;
  var model = modelType_order();

  //-----[List]
  if (fields != null) items = fields['list'];
  if (data_base.isEmpty) return Center(child: Text('There is no Order'));
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: IntrinsicWidth(
      child: Card(
        child: Column(
          children: [
            //----------header
            DataTable(
              columns: [
                ...model.controllers.keys.where((String key) => (items == null || items.isEmpty || items.containsKey(key))).map((String key) {
                  return DataColumn(label: build_text_1(title: items?[key] ?? key));
                }).toList(),
              ],
              //----------rows
              rows: data_base.map((value1) {
                var value = (value1 as dynamic);
                return DataRow(
                  cells: [
                    ...model.controllers.keys.where((String key) {
                      bool hasKey = items?.containsKey(key) ?? false;
                      return items == null || items.isEmpty || hasKey;
                    }).map((String key) {
                      return build_datacell_1(value: value.getValueByKey(key).toString());
                    }).toList()
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
