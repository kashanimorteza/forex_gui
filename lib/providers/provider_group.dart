//--------------------------------------------------------------------------------- location
// lib/providers/provider_group.dart

//--------------------------------------------------------------------------------- Description
// This is provider for group

//--------------------------------------------------------------------------------- Import
import 'package:flutter/material.dart';
import 'package:mkpanel_gui/models/model_alarm.dart';
import 'package:provider/provider.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/consts/model.dart';
import 'package:mkpanel_gui/tools/tools.dart';
import 'package:mkpanel_gui/providers/provider_page.dart';
import 'package:mkpanel_gui/models/model_user_group.dart';
import 'package:mkpanel_gui/models/model_service.dart';

//--------------------------------------------------------------------------------- Global
String title_group = models_title.group;

//--------------------------------------------------------------------------------- Provider
class provider_group with ChangeNotifier {
  //--------------------------------[Fields]
  var _context;
  var _drawer;
  var _prv;
  var _data_group;
  var _data_alarm;
  var _data_service;
  var _data_group_gi;
  var _group_selected_id;
  late model_user_group _model_user_group;
  late model_service _model_service;
  late model_alarm _model_alarm;

  //--------------------------------[Contractor]
  provider_group() {
    _model_user_group = model_user_group();
    _model_service = model_service();
    _model_alarm = model_alarm();
  }

  //--------------------------------[Set]
  set context(value) => {(_context = value, _prv = Provider.of<Provider_Page>(_context, listen: false))};
  set drawer(value) => _drawer = value;

  //------------------------------[Logic]
  //----------[load]
  load([String model = 'all']) async {
    switch (model) {
      case 'group':
        _data_group = await _model_user_group.api('items');
      case 'gi':
        _data_group_gi = await _model_user_group.gi_items(_group_selected_id);
      case 'select':
        _group_selected_id = _data_group.first.id;
        _data_group_gi = await _model_user_group.gi_items(_group_selected_id);
      default:
        _data_alarm = await _model_alarm.api('items');
        _data_group = await _model_user_group.api('items');
        _data_service = await _model_service.api('items');
        _group_selected_id = _data_group.first.id;
        _data_group_gi = await _model_user_group.gi_items(_group_selected_id);
        reload();
    }
  }

  //----------[reload]
  reload() async {
    _prv.ui = view();
  }

  //----------[api
  action(type, model_user_group model) async {
    type == "delete" ? _group_selected_id = null : null;
    build_notification_2(_context, await model.api(type));
    await load('group');
    await load('select');
    await load('gi');
    reload();
  }

  //----------[group_change]
  group_change(int service_id, bool enable) async {
    var result = await _model_user_group.gi_fill(_group_selected_id, service_id, enable);
    build_notification_2(_context, result);
    await load('gi');
    reload();
  }

  //----------[group_select]
  group_select(int value) async {
    _group_selected_id = value;
    await load('gi');
    reload();
  }

  //------------------------------[view]
  view() {
    //----------[drp_group]
    var drp_group = IntrinsicWidth(
        child: SizedBox(
            child: bul_drp_list<model_user_group>(
      lable: title_group,
      data: _data_group,
      selected_id: _group_selected_id,
      onChange: group_select,
    )));
    //----------[view_1]
    var view_1 = ui_1(
      context: _context,
      title: title_group,
      data_group: _data_group,
      data_alarm: _data_alarm,
      action: action,
      fields: models_fileds.group,
    );
    //----------[view_2]
    var view_2 = ui_2(
      title: "Services",
      data_service: _data_service,
      group_gi: _data_group_gi,
      action: group_change,
    );
    //----------[app_bar]
    var app_bar = build_appbar_1(title: title_group);
    //----------[body]
    var body = SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(const_widget_padding),
          child: Column(
            children: [
              SizedBox(child: Padding(padding: EdgeInsets.only(bottom: const_widget_padding), child: view_1)),
              SizedBox(child: Padding(padding: EdgeInsets.only(bottom: const_widget_padding), child: drp_group)),
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
  required List<model_user_group> data_group,
  required List<model_alarm> data_alarm,
  required Function(String, model_user_group) action,
  Map<String, dynamic>? fields = const {},
}) {
  //-----[Variable]
  var items = null;
  var model = model_user_group();
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
                    build_dropdownlist_3<model_alarm>(lable: 'Alarm', data: data_alarm, controller: model.controller_get('alarm_id'), selected_id: model.alarm_id),
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
  void edit(model_user_group model1) {
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
                    build_dropdownlist_3<model_alarm>(lable: 'Alarm', data: data_alarm, controller: model.controller_get('alarm_id'), selected_id: model.alarm_id),
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
  void delete(model_user_group model) {
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
                DataColumn(label: build_text_1(title: 'Alarm')),
                DataColumn(label: build_text_1(title: 'Action')),
              ],
              //----------rows
              rows: data_group.map((value) {
                final alarm_name = (data_alarm as dynamic).firstWhere((i) => i.id == value.alarm_id).name;
                return DataRow(
                  cells: [
                    ...model.controllers.keys.where((String key) {
                      bool hasKey = items?.containsKey(key) ?? false;
                      return items == null || items.isEmpty || hasKey;
                    }).map((String key) {
                      return build_datacell_1(value: value.getValueByKey(key).toString());
                    }).toList(),
                    build_datacell_1(value: alarm_name),
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
  required List<model_service> data_service,
  required List<dynamic> group_gi,
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
              rows: data_service.map((item) {
                var service = (item as dynamic);
                final Map<String, dynamic>? gi = group_gi.firstWhere(
                  (item) => item['item_id'] == service.id,
                  orElse: () => null,
                );
                selected = gi != null ? gi['enable'] : false;
                return DataRow(
                  cells: [
                    build_datacell_1(value: service.name),
                    build_datacell_1(value: service.description),
                    DataCell(Switch(value: selected, onChanged: (bool v) => action(service.id, v))),
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
