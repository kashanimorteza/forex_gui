//--------------------------------------------------------------------------------- location
// lib/providers/provider_certificate.dart

//--------------------------------------------------------------------------------- Description
// This is provider for certificate

//--------------------------------------------------------------------------------- Import
import 'package:flutter/material.dart';
import 'package:mkpanel_gui/models/model_domain.dart';
import 'package:provider/provider.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/consts/model.dart';
import 'package:mkpanel_gui/tools/tools.dart';
import 'package:mkpanel_gui/providers/provider_page.dart';
import 'package:mkpanel_gui/models/model_certificate.dart';
import 'package:mkpanel_gui/models/model_server.dart';

//--------------------------------------------------------------------------------- Global
typedef modelType_base = model_certificate;
typedef modelType_related_1 = model_domain;
typedef modelType_related_2 = model_server;
String title_base = models_title.certificate;

//--------------------------------------------------------------------------------- Provider
class provider_certificate with ChangeNotifier {
  //--------------------------------[Fields]
  var _context;
  var _drawer;
  var _prv;
  var _data_base;
  var _data_related_1;
  var _data_related_2;
  late modelType_base _model_base;
  late modelType_related_1 _model_related_1;
  late modelType_related_2 _model_related_2;

  //--------------------------------[Contractor]
  provider_certificate() {
    _model_base = modelType_base();
    _model_related_1 = modelType_related_1();
    _model_related_2 = modelType_related_2();
  }

  //--------------------------------[Set]
  set context(value) => {(_context = value, _prv = Provider.of<Provider_Page>(_context, listen: false))};
  set drawer(value) => _drawer = value;

  //------------------------------[Logic]
  //----------[load]
  load([String model = 'all']) async {
    switch (model) {
      case 'base':
        _data_base = await _model_base.api('items');
      default:
        _data_base = await _model_base.api('items');
        _data_related_1 = await _model_related_1.api('items');
        _data_related_2 = await _model_related_2.api('items');
    }
    reload();
  }

  //----------[reload]
  reload() => _prv.ui = view();

  //----------[api]
  api(type, modelType_base model) async {
    var result = await model.api(type);
    build_notification_2(_context, result);
    load('base');
  }

  //------------------------------[view]
  view() {
    //----------[view_1]
    var view_1 = ui_1<modelType_base, modelType_related_1, modelType_related_2>(
      context: _context,
      title: title_base,
      model_base: _model_base,
      data_base: _data_base,
      data_related_1: _data_related_1,
      data_related_2: _data_related_2,
      action: api,
      fields: models_fileds.certificate,
    );
    //----------[app_bar]
    var app_bar = build_appbar_1(title: title_base);
    //----------[body]
    var body = SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(const_widget_padding),
          child: Column(
            children: [
              view_1,
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
Widget ui_1<T_base, T_related_1, T_related_2>({
  required BuildContext context,
  required String title,
  required T_base model_base,
  required List<T_base> data_base,
  required List<T_related_1> data_related_1, //domains
  required List<T_related_2> data_related_2, //servers
  required Function(String, T_base) action,
  Map<String, dynamic>? fields = const {},
}) {
  var items = null;
  var model = (data_base.first as dynamic);

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
                    build_dropdownlist_3<T_related_1>(lable: 'Domain', data: data_related_1, controller: model.controller_get('domain_id'), selected_id: model.domain_id),
                    SizedBox(height: const_widget_padding),
                    build_dropdownlist_3<T_related_2>(lable: 'Server', data: data_related_2, controller: model.controller_get('server_id'), selected_id: model.server_id),
                    SizedBox(height: const_widget_padding),
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
  void edit(T_base model1) {
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
                    build_dropdownlist_3<T_related_1>(lable: 'Domain', data: data_related_1, controller: model.controller_get('domain_id'), selected_id: model.domain_id),
                    SizedBox(height: const_widget_padding),
                    build_dropdownlist_3<T_related_2>(lable: 'Server', data: data_related_2, controller: model.controller_get('server_id'), selected_id: model.server_id),
                    SizedBox(height: const_widget_padding),
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
  void delete(T_base model) {
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
                DataColumn(label: build_text_1(title: 'Domain')),
                DataColumn(label: build_text_1(title: 'Server')),
                DataColumn(label: build_text_1(title: 'Action')),
              ],
              //----------rows
              rows: data_base.map((value1) {
                var value = (value1 as dynamic);
                final domainName = (data_related_1 as dynamic).firstWhere((i) => i.id == value.domain_id).name;
                final server_name = (data_related_2 as dynamic).firstWhere((i) => i.id == value.server_id).name;
                return DataRow(
                  cells: [
                    ...model.controllers.keys.where((String key) {
                      bool hasKey = items?.containsKey(key) ?? false;
                      return items == null || items.isEmpty || hasKey;
                    }).map((String key) {
                      return build_datacell_1(value: value.getValueByKey(key).toString());
                    }).toList(),
                    build_datacell_1(value: domainName),
                    build_datacell_1(value: server_name),
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
