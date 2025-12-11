//--------------------------------------------------------------------------------- location
// lib/providers/provider_display.dart

//--------------------------------------------------------------------------------- Description
// This is provider for display

//--------------------------------------------------------------------------------- Import
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/consts/model.dart';
import 'package:mkpanel_gui/tools/tools.dart';
import 'package:mkpanel_gui/providers/provider_page.dart';
import 'package:mkpanel_gui/models/model_display.dart';

//--------------------------------------------------------------------------------- Global
String title_display = models_title.display;

//--------------------------------------------------------------------------------- Provider
class provider_display with ChangeNotifier {
  //--------------------------------[Fields]
  var _context;
  var _drawer;
  var _prv;
  var _data_display;
  var _data_items;
  var _data_display_gi;
  var _display_selected_id;
  late model_display _model_display;

  //--------------------------------[Contractor]
  provider_display() {
    _model_display = model_display();
  }

  //--------------------------------[Set]
  set context(value) => {(_context = value, _prv = Provider.of<Provider_Page>(_context, listen: false))};
  set drawer(value) => _drawer = value;

  //------------------------------[Logic]
  //----------[load]
  load([String model = 'all']) async {
    switch (model) {
      case 'display':
        _data_display = await _model_display.api('items');
      case 'items':
        _data_items = await _model_display.api('display_items');
      case 'gi':
        _data_display_gi = await _model_display.gi_items(_display_selected_id);
      case 'select':
        _display_selected_id = _data_display.first.id;
        _data_display_gi = await _model_display.gi_items(_display_selected_id);
      default:
        _data_display = await _model_display.api('items');
        _data_items = await _model_display.api('display_items');
        _display_selected_id = _data_display.first.id;
        _data_display_gi = await _model_display.gi_items(_display_selected_id);
        reload();
    }
  }

  //----------[reload]
  reload() async {
    _prv.ui = view();
  }

  //----------[api
  action(type, model_display model) async {
    type == "delete" ? _display_selected_id = null : null;
    build_notification_2(_context, await model.api(type));
    await load('display');
    await load('select');
    await load('gi');
    reload();
  }

  //----------[display_change]
  display_change(int service_id, bool enable) async {
    var result = await _model_display.gi_fill(_display_selected_id, service_id, enable);
    build_notification_2(_context, result);
    await load('gi');
    reload();
  }

  //----------[display_select]
  display_select(int value) async {
    _display_selected_id = value;
    await load('gi');
    reload();
  }

  //------------------------------[view]
  view() {
    //----------[drp_display]
    var drp_display = IntrinsicWidth(
        child: SizedBox(
            child: bul_drp_list<model_display>(
      lable: title_display,
      data: _data_display,
      selected_id: _display_selected_id,
      onChange: display_select,
    )));
    //----------[view_1]
    var view_1 = ui_1(
      context: _context,
      title: title_display,
      data_display: _data_display,
      action: action,
      fields: models_fileds.display,
    );
    //----------[view_2]
    var view_2 = ui_2(
      title: "Items",
      data_items: _data_items,
      display_gi: _data_display_gi,
      action: display_change,
    );
    //----------[app_bar]
    var app_bar = build_appbar_1(title: title_display);
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
  required List<model_display> data_display,
  required Function(String, model_display) action,
  Map<String, dynamic>? fields = const {},
}) {
  //-----[Variable]
  var items = null;
  var model = model_display();
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
  void edit(model_display model1) {
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
  void delete(model_display model) {
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
              rows: data_display.map((value) {
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

//------------------------------[ui_2]
Widget ui_2({
  required String title,
  required List<dynamic> data_items,
  required List<dynamic> display_gi,
  required Function(int, bool) action,
}) {
  bool selected = false;
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
                DataColumn(label: build_text_1(title: 'Service')),
                DataColumn(label: build_text_1(title: 'Description')),
                DataColumn(label: build_text_1(title: 'Select')),
              ],
              //--------Items
              rows: data_items.map((item) {
                final Map<String, dynamic>? gi = display_gi.firstWhere(
                  (row) => row['item_id'] == item.id,
                  orElse: () => null,
                );
                selected = gi != null ? gi['enable'] : false;
                return DataRow(
                  cells: [
                    build_datacell_1(value: item.name),
                    build_datacell_1(value: item.description),
                    DataCell(Switch(value: selected, onChanged: (bool v) => action(item.id, v))),
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
