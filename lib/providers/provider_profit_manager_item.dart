//--------------------------------------------------------------------------------- Location
// lib/providers/provider_profit_manager_item.dart

//--------------------------------------------------------------------------------- Description
// This is provider for profit_manager_item

//--------------------------------------------------------------------------------- Import
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/consts/model.dart';
import 'package:mkpanel_gui/tools/tools.dart';
import 'package:mkpanel_gui/providers/provider_page.dart';
import 'package:mkpanel_gui/models/model_profit_manager_item.dart';
import 'package:mkpanel_gui/models/model_profit_manager.dart';

//--------------------------------------------------------------------------------- Global
typedef modelType_profit_manager = model_profit_manager;
typedef modelType_base = model_profit_manager_item;
String title_base = models_title.profit_manager_item;
String title_appbar = models_title.base;

//--------------------------------------------------------------------------------- Provider
class provider_profit_manager_item with ChangeNotifier {
  //--------------------------------[Fields]
  var _context;
  var _drawer;
  var _prv;
  var _data_base;
  var _data_profit_manager;
  var _selected_profit_manager_id = 0;
  late modelType_base _model_base;
  late modelType_profit_manager _model_profit_manager;

  //--------------------------------[Contractor]
  provider_profit_manager_item() {
    _model_base = modelType_base();
    _model_profit_manager = modelType_profit_manager();
  }

  //--------------------------------[Set]
  set context(value) => {(_context = value, _prv = Provider.of<Provider_Page>(_context, listen: false))};
  set drawer(value) => _drawer = value;

  //------------------------------[Logic]
  //----------[load]
  load([String model = 'all']) async {
    switch (model) {
      case 'base':
        _data_base = await _model_base.api('items', "?profit_manager_id=${_selected_profit_manager_id}");
      default:
        _data_profit_manager = await _model_profit_manager.api('items');
        if (_data_profit_manager.isNotEmpty) _selected_profit_manager_id = _data_profit_manager.first.id;
        _data_base = await _model_base.api('items', "?profit_manager_id=${_selected_profit_manager_id}");
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

  //----------[profit_manager_select]
  profit_manager_select(value) async {
    _selected_profit_manager_id = value;
    await load('base');
    reload();
  }

  //------------------------------[view]
  view() {
    //----------[drp_profit_manager]
    var drp_profit_manager = IntrinsicWidth(child: SizedBox(child: build_dropdownlist_1<modelType_profit_manager>(lable: 'Strategy', data: _data_profit_manager, selected_id: _selected_profit_manager_id, onChange: profit_manager_select)), stepWidth: 150);
    //----------[ui]
    var ui = widget_ui(
      context: _context,
      title: title_base,
      data_base: _data_base,
      api: api,
      fields: models_fileds.profit_manager_item,
      selected_profit_manager_id: _selected_profit_manager_id,
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
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(child: Padding(padding: EdgeInsets.only(right: const_widget_padding), child: drp_profit_manager)),
                ],
              ),
              SizedBox(height: 10),
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
  required int selected_profit_manager_id,
}) {
  //-----[Variable]
  var items = null;
  var model = modelType_base();

  //-----[Add]
  void add() {
    if (fields != null) items = fields['add'];
    model.controller_clear();
    model.controllers['id'].text = '';
    model.controllers['profit_manager_id'].value = selected_profit_manager_id;
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
  if (selected_profit_manager_id == 0) return Center(child: Text('No data available'));
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
                DataColumn(label: build_text_1(title: 'Edit')),
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
                    }).toList(),
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
