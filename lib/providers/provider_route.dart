//--------------------------------------------------------------------------------- location
// lib/providers/provider_route.dart

//--------------------------------------------------------------------------------- Description
// This is provider for route

//--------------------------------------------------------------------------------- Import
import 'package:flutter/material.dart';
import 'package:mkpanel_gui/models/model_certificate.dart';
import 'package:mkpanel_gui/models/model_domain.dart';
import 'package:provider/provider.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/consts/model.dart';
import 'package:mkpanel_gui/tools/tools.dart';
import 'package:mkpanel_gui/providers/provider_page.dart';
import 'package:mkpanel_gui/models/model_route.dart';
import 'package:mkpanel_gui/models/model_server.dart';

//--------------------------------------------------------------------------------- Global
String title_route = models_title.route;

//--------------------------------------------------------------------------------- Provider
class provider_route with ChangeNotifier {
  //--------------------------------[Fields]
  var _context;
  var _drawer;
  var _prv;
  var _data_route;
  var _data_domain;
  var _data_certificate;
  var _data_server;
  var _data_route_gi;
  var _route_selected_id;
  late model_route _model_route;
  late model_domain _model_domain;
  late model_certificate _model_certificate;
  late model_server _model_server;

  //--------------------------------[Contractor]
  provider_route() {
    _model_route = model_route();
    _model_domain = model_domain();
    _model_certificate = model_certificate();
    _model_server = model_server();
  }

  //--------------------------------[Set]
  set context(value) => {(_context = value, _prv = Provider.of<Provider_Page>(_context, listen: false))};
  set drawer(value) => _drawer = value;

  //------------------------------[Logic]
  //----------[load]
  load([String model = 'all']) async {
    switch (model) {
      case 'route':
        _data_route = await _model_route.api('items');
      case 'gi':
        _data_route_gi = await _model_route.gi_items(_route_selected_id);
      case 'select':
        _route_selected_id = _data_route.first.id;
        _data_route_gi = await _model_route.gi_items(_route_selected_id);
      default:
        _data_route = await _model_route.api('items');
        _data_domain = await _model_domain.api('items');
        _data_certificate = await _model_certificate.api('items');
        _data_server = await _model_server.api('items');
        _route_selected_id = _data_route.first.id;
        _data_route_gi = await _model_route.gi_items(_route_selected_id);
        reload();
    }
  }

  //----------[reload]
  reload() async {
    _prv.ui = view();
  }

  //----------[api
  action(type, model_route model) async {
    type == "delete" ? _route_selected_id = null : null;
    build_notification_2(_context, await model.api(type));
    await load('route');
    await load('select');
    await load('gi');
    reload();
  }

  //----------[route_change]
  route_change(int server_id, bool enable) async {
    var result = await _model_route.gi_fill(_route_selected_id, server_id, enable);
    build_notification_2(_context, result);
    await load('gi');
    reload();
  }

  //----------[route_select]
  route_select(int value) async {
    _route_selected_id = value;
    await load('gi');
    reload();
  }

  //------------------------------[view]
  view() {
    //----------[drp_route]
    var drp_route = IntrinsicWidth(
        child: SizedBox(
            child: bul_drp_list<model_route>(
      lable: title_route,
      data: _data_route,
      selected_id: _route_selected_id,
      onChange: route_select,
    )));
    //----------[view_1]
    var view_1 = ui_1<model_route, model_domain, model_certificate>(
      context: _context,
      title: title_route,
      model_route: _model_route,
      data_route: _data_route,
      data_related_1: _data_domain,
      data_related_2: _data_certificate,
      action: action,
      fields: models_fileds.route,
    );
    //----------[view_2]
    var view_2 = ui_2(
      title: "Servers",
      data_server: _data_server,
      route_gi: _data_route_gi,
      action: route_change,
    );
    //----------[app_bar]
    var app_bar = build_appbar_1(title: title_route);
    //----------[body]
    var body = SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(const_widget_padding),
          child: Column(
            children: [
              SizedBox(child: Padding(padding: EdgeInsets.only(bottom: const_widget_padding), child: view_1)),
              SizedBox(child: Padding(padding: EdgeInsets.only(bottom: const_widget_padding), child: drp_route)),
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
Widget ui_1<T_route, T_related_1, T_related_2>({
  required BuildContext context,
  required String title,
  required T_route model_route,
  required List<T_route> data_route,
  required List<T_related_1> data_related_1, //domain
  required List<T_related_2> data_related_2, //certification
  required Function(String, T_route) action,
  Map<String, dynamic>? fields = const {},
}) {
  var items = null;
  var model = (data_route.first as dynamic);

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
                    build_dropdownlist_4<const_route_type>(lable: "Type", data: const_route_type.values, controller: model.controller_get('type'), selected_type: const_route_type.domain),
                    SizedBox(height: const_widget_padding),
                    build_dropdownlist_3<T_related_1>(lable: 'Domain', data: data_related_1, controller: model.controller_get('domain_id'), selected_id: model.domain_id),
                    SizedBox(height: const_widget_padding),
                    build_dropdownlist_3<T_related_2>(lable: 'Certificate', data: data_related_2, controller: model.controller_get('certificate_id'), selected_id: model.certificate_id),
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
  void edit(T_route model1) {
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
                    build_dropdownlist_4<const_route_type>(lable: "Type", data: const_route_type.values, controller: model.controller_get('type'), selected_type: model.type),
                    SizedBox(height: const_widget_padding),
                    build_dropdownlist_3<T_related_1>(lable: 'Domain', data: data_related_1, controller: model.controller_get('domain_id'), selected_id: model.domain_id),
                    SizedBox(height: const_widget_padding),
                    build_dropdownlist_3<T_related_2>(lable: 'Certificate', data: data_related_2, controller: model.controller_get('certificate_id'), selected_id: model.certificate_id),
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
  void delete(T_route model) {
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
                DataColumn(label: build_text_1(title: 'Certificate')),
                DataColumn(label: build_text_1(title: 'Action')),
              ],
              //----------rows
              rows: data_route.map((value1) {
                var value = (value1 as dynamic);
                final domainName = (data_related_1 as dynamic).firstWhere((i) => i.id == value.domain_id).name;
                final certification = (data_related_2 as dynamic).firstWhere((i) => i.id == value.certificate_id).name;
                return DataRow(
                  cells: [
                    ...model.controllers.keys.where((String key) {
                      bool hasKey = items?.containsKey(key) ?? false;
                      return items == null || items.isEmpty || hasKey;
                    }).map((String key) {
                      return build_datacell_1(value: value.getValueByKey(key).toString());
                    }).toList(),
                    build_datacell_1(value: domainName),
                    build_datacell_1(value: certification),
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
  required List<model_server> data_server,
  required List<dynamic> route_gi,
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
                DataColumn(label: build_text_1(title: 'Server')),
                DataColumn(label: build_text_1(title: 'Description')),
                DataColumn(label: build_text_1(title: 'Select')),
              ],
              //--------Items
              rows: data_server.map((item) {
                var server = (item as dynamic);
                final Map<String, dynamic>? gi = route_gi.firstWhere(
                  (item) => item['item_id'] == server.id,
                  orElse: () => null,
                );
                selected = gi != null ? gi['enable'] : false;
                return DataRow(
                  cells: [
                    build_datacell_1(value: server.name),
                    build_datacell_1(value: server.description),
                    DataCell(Switch(value: selected, onChanged: (bool v) => action(server.id, v))),
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
