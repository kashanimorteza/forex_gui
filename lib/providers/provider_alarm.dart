//--------------------------------------------------------------------------------- location
// lib/providers/provider_alarm.dart

//--------------------------------------------------------------------------------- Description
// This is provider for alarm

//--------------------------------------------------------------------------------- Import
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/consts/model.dart';
import 'package:mkpanel_gui/tools/tools.dart';
import 'package:mkpanel_gui/providers/provider_page.dart';
import 'package:mkpanel_gui/models/model_alarm.dart';

//--------------------------------------------------------------------------------- Global
typedef model_base = model_alarm;
String title = models_title.alarm;

//--------------------------------------------------------------------------------- Provider
class provider_alarm with ChangeNotifier {
  //--------------------------------[Fields]
  var _context;
  var _drawer;
  var _prv;
  var _data_base;
  var _data_items;
  var _data_gi;
  var _selected_id;
  late model_base _model_base;

  //--------------------------------[Contractor]
  provider_alarm() {
    _model_base = model_base();
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
      case 'items':
        _data_items = await _model_base.api('alarm_items');
      case 'gi':
        _data_gi = await _model_base.gi_items(_selected_id);
      case 'select':
        _selected_id = _data_base.first.id;
        _data_gi = await _model_base.gi_items(_selected_id);
      default:
        _data_base = await _model_base.api('items');
        _data_items = await _model_base.api('alarm_items');
        _selected_id = _data_base.first.id;
        _data_gi = await _model_base.gi_items(_selected_id);
        reload();
    }
  }

//----------[reload]
  reload() async {
    _prv.ui = view();
  }

  //----------[api]
  action(type, model_base model) async {
    type == "delete" ? _selected_id = null : null;
    build_notification_2(_context, await model.api(type));
    await load('base');
    await load('select');
    await load('gi');
    reload();
  }

  //----------[group_select]
  group_select(int value) async {
    _selected_id = value;
    await load('gi');
    reload();
  }

  //----------[gi_change]
  gi_change(int item_id, String item, dynamic value) async {
    var result = await _model_base.gi_fill(_selected_id, item_id, item, value);
    build_notification_2(_context, result);
    await load('gi');
    reload();
  }

  //------------------------------[view]
  view() {
    //----------[drp_display]
    var drp_display = IntrinsicWidth(
        child: SizedBox(
            child: bul_drp_list<model_base>(
      lable: title,
      data: _data_base,
      selected_id: _selected_id,
      onChange: group_select,
    )));
    //----------[view_1]
    var view_1 = ui_1(
      context: _context,
      title: title,
      data_base: _data_base,
      action: action,
      fields: models_fileds.display,
    );
    //----------[view_2]
    var view_2 = ui_2(
      title: "Items",
      base_id: _selected_id,
      data_items: _data_items,
      display_gi: _data_gi,
      action: gi_change,
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
              SizedBox(child: Padding(padding: EdgeInsets.only(bottom: const_widget_padding), child: view_1)),
              SizedBox(child: Padding(padding: EdgeInsets.only(bottom: const_widget_padding), child: drp_display)),
              SizedBox(child: Padding(padding: EdgeInsets.only(bottom: const_widget_padding), child: view_2)),
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
//------------------------------[ui_1]
Widget ui_1({
  required BuildContext context,
  required String title,
  required List<model_base> data_base,
  required Function(String, model_base) action,
  Map<String, dynamic>? fields = const {},
}) {
  //-----[Variable]
  var items = null;
  var model = model_base();
  //-----[Add]
  void add() {
    if (fields != null) items = fields['add'];
    model.controller_clear();
    model.controllers['id'].text = '';
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
                TextButton(onPressed: () => {action("add", model), Navigator.pop(context)}, child: Text('Add')),
              ],
            );
          },
        );
      },
    );
  }

  //-----[Edit]
  void edit(model_base model1) {
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
                TextButton(onPressed: () => {action("update", model), Navigator.pop(context)}, child: Text('Update')),
              ],
            );
          },
        );
      },
    );
  }

  //-----[Delete]
  void delete(model_base model) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete'),
          content: Text('Are you sure you want to delete ${(model as dynamic).name}?'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
            TextButton(onPressed: () => {action("delete", model), Navigator.pop(context)}, child: Text('Delete')),
          ],
        );
      },
    );
  }

  //-----[return]
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
                DataColumn(label: build_text_1(title: 'Action')),
              ],
              //----------rows
              rows: data_base.map((value) {
                return DataRow(
                  cells: [
                    ...model.controllers.keys.where((String key) {
                      bool hasKey = items?.containsKey(key) ?? false;
                      return items == null || items.isEmpty || hasKey;
                    }).map((String key) {
                      return build_datacell_1(value: value.getValueByKey(key).toString());
                    }).toList(),
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

//------------------------------[ui_1]
Widget ui_2<T_base>({
  required String title,
  required int base_id,
  required List<dynamic> data_items,
  required List<dynamic> display_gi,
  required Function(int, String, dynamic) action,
}) {
  //-----[Variable]
  bool selected = false;
  String count = '';
  String limit = '';
  //-----[View]
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: IntrinsicWidth(
      child: Card(
        child: Column(
          children: [
            //--------Title
            build_header_2(title: title),
            //--------Headers
            DataTable(
              columns: [
                DataColumn(label: build_text_1(title: 'Name')),
                DataColumn(label: build_text_1(title: 'Count')),
                DataColumn(label: build_text_1(title: 'Limit')),
                DataColumn(label: build_text_1(title: 'Select')),
              ],
              //--------Items
              rows: data_items.map((item) {
                final Map<String, dynamic>? gi = display_gi.firstWhere(
                  (row) => row['group_id'] == base_id && row['item_id'] == item.id,
                  orElse: () => null,
                );
                if (gi != null) {
                  selected = gi['enable'];
                  count = gi['count'].toString();
                  limit = gi['limit'].toString();
                } else {
                  selected = false;
                  count = '';
                  limit = '';
                }
                return DataRow(
                  cells: [
                    build_datacell_1(value: item.name),
                    DataCell(TextField(controller: TextEditingController(text: count), onChanged: (String v) => v != "" ? action(item.id, "count", v) : null)),
                    DataCell(TextField(controller: TextEditingController(text: limit), onChanged: (String v) => v != "" ? action(item.id, "limit", v) : null)),
                    DataCell(Switch(value: selected, onChanged: (bool newValue) => action(item.id, "enable", newValue))),
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
