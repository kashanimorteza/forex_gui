//--------------------------------------------------------------------------------- Location
// lib/ui/ui_service_v2ray_inbound.dart

//--------------------------------------------------------------------------------- Description
// This is ui for ui_service_v2ray_inbound

//--------------------------------------------------------------------------------- Import
import 'package:flutter/material.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/tools/tools.dart';

//--------------------------------------------------------------------------------- UI
//--------------------------------[ui_inbound]
Widget ui_inbound<T_base>({
  required BuildContext context,
  required String title,
  required List<T_base> data_base,
  required List<const_xray_transport> data_related_1,
  required List<const_xray_protocol> data_related_2,
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
                    build_dropdownlist_4<const_xray_transport>(lable: 'Transport', data: data_related_1, controller: model.controller_get('transport'), selected_type: const_xray_transport.tcp),
                    SizedBox(height: const_widget_padding),
                    build_dropdownlist_4<const_xray_protocol>(lable: 'Protocol', data: data_related_2, controller: model.controller_get('protocol'), selected_type: const_xray_protocol.vless),
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
                    ...model.controllers.entries.where((entry) => items == null || items.isEmpty || items.containsKey(entry.key)).map((entry) => build_Row_3(items?[entry.key] ?? entry.key, model.controller_get(entry.key))).toList(),
                    SizedBox(height: const_widget_padding),
                    build_dropdownlist_4<const_xray_transport>(lable: 'Transport', data: (data_related_1 as dynamic), controller: model.controller_get('transport'), selected_type: model.transport),
                    SizedBox(height: const_widget_padding),
                    build_dropdownlist_4<const_xray_protocol>(lable: 'Protocol', data: (data_related_2 as dynamic), controller: model.controller_get('protocol'), selected_type: model.protocol),
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
