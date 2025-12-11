//--------------------------------------------------------------------------------- location
// lib/providers/provider_service_v2ray_inbound.dart

//--------------------------------------------------------------------------------- Description
// This is provider for service_v2ray_inbound

//--------------------------------------------------------------------------------- Import
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/consts/model.dart';
import 'package:mkpanel_gui/tools/tools.dart';
import 'package:mkpanel_gui/providers/provider_page.dart';
import 'package:mkpanel_gui/models/model_service_v2ray_inbound.dart';

//--------------------------------------------------------------------------------- Global
typedef model_base = model_service_v2ray_inbound;
String title_base = models_title.service_v2ray_inbound;
String title_appbar = models_title.service_v2ray;

//--------------------------------------------------------------------------------- Provider
class provider_service_v2ray_inbound with ChangeNotifier {
  //--------------------------------[Fields]
  var _context;
  var _drawer;
  var _prv;
  var _data_base;
  late model_base _model_base;

  //--------------------------------[Contractor]
  provider_service_v2ray_inbound() {
    _model_base = modelType();
  }

  //--------------------------------[Set]
  set context(value) => {(_context = value, _prv = Provider.of<Provider_Page>(_context, listen: false))};
  set drawer(value) => _drawer = value;

  //------------------------------[Logic]
  //----------[load]
  load() async => {(_data_base = await _model_base.api('items'), reload())};

  //----------[reload]
  reload() => _prv.ui = view();

  //----------[api]
  action(type, model_base model) async {
    var result = await model.api(type);
    build_notification_2(_context, result);
    load();
  }

  //------------------------------[view]
  view() {
    //----------[ui]
    var ui = ui_inbound(
      context: _context,
      title: title_base,
      data_base: _data_base,
      transports: const_xray_transport.values,
      protocols: const_xray_protocol.values,
      action: action,
      fields: models_fileds.service_v2ray_inbound,
    );
    //----------[app_bar]
    var app_bar = build_appbar_1(title: title_appbar);
    //----------[body]
    var body = SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(const_widget_padding),
          child: Column(
            children: [ui],
          ),
        ),
      ),
    );
    //----------[return]
    return Scaffold(appBar: app_bar, drawer: _drawer, body: body);
  }
}

//--------------------------------------------------------------------------------- UI
//--------------------------------[ui_inbound]
Widget ui_inbound({
  required BuildContext context,
  required String title,
  required List<model_base> data_base,
  required List<const_xray_transport> transports,
  required List<const_xray_protocol> protocols,
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
    model.controllers['port'].text = '';
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
                    SizedBox(height: const_widget_padding),
                    build_dropdownlist_4<const_xray_transport>(lable: 'Transport', data: transports, controller: model.controller_get('transport'), selected_type: const_xray_transport.tcp),
                    SizedBox(height: const_widget_padding),
                    build_dropdownlist_4<const_xray_protocol>(lable: 'Protocol', data: protocols, controller: model.controller_get('protocol'), selected_type: const_xray_protocol.vless),
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
                    SizedBox(height: const_widget_padding),
                    build_dropdownlist_4<const_xray_transport>(lable: 'Transport', data: (transports as dynamic), controller: model.controller_get('transport'), selected_type: model.transport),
                    SizedBox(height: const_widget_padding),
                    build_dropdownlist_4<const_xray_protocol>(lable: 'Protocol', data: (protocols as dynamic), controller: model.controller_get('protocol'), selected_type: model.protocol),
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
  return IntrinsicWidth(
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
                  DataCell(build_action_1(onUpdate: (val) => edit(value), onDelete: (val) => delete(value), value: value)),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    ),
  );
}
