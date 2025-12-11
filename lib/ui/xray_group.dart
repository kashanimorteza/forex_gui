//--------------------------------------------------------------------------------- location
// lib/ui/ui_service_v2ray_group.dart

//--------------------------------------------------------------------------------- Description
// This is ui for service v2ray group

//--------------------------------------------------------------------------------- Import
import 'package:flutter/material.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/tools/tools.dart';

//--------------------------------------------------------------------------------- UI ; ui_group
Widget ui_group<T_base, T_related_1, T_related_2>({
  required BuildContext context,
  required String title,
  required List<T_base> data_base,
  required List<T_related_1> data_related_1, //alarm
  required List<T_related_2> data_related_2, //display
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
                    ...model.controllers.entries.where((entry) => items == null || items.isEmpty || items.containsKey(entry.key)).map((entry) => build_Row_3(items?[entry.key] ?? entry.key, model.controller_get(entry.key))).toList(),
                    SizedBox(height: const_widget_padding),
                    build_dropdownlist_3<T_related_1>(lable: 'Alarm', data: data_related_1, controller: model.controller_get('alarm_id'), selected_id: model.alarm_id),
                    SizedBox(height: const_widget_padding),
                    build_dropdownlist_3<T_related_2>(lable: 'Display', data: data_related_2, controller: model.controller_get('display_id'), selected_id: model.display_id),
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
                    build_dropdownlist_3<T_related_1>(lable: 'Alarm', data: data_related_1, controller: model.controller_get('alarm_id'), selected_id: model.alarm_id),
                    SizedBox(height: const_widget_padding),
                    build_dropdownlist_3<T_related_2>(lable: 'Display', data: data_related_2, controller: model.controller_get('display_id'), selected_id: model.display_id),
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
                DataColumn(label: build_text_1(title: 'Alarm')),
                DataColumn(label: build_text_1(title: 'Display')),
                DataColumn(label: build_text_1(title: 'Action')),
              ],
              //----------rows
              rows: data_base.map((value1) {
                var value = (value1 as dynamic);
                final alarmName = (data_related_1 as dynamic).firstWhere((i) => i.id == value.alarm_id).name;
                final display_name = (data_related_2 as dynamic).firstWhere((i) => i.id == value.display_id).name;
                return DataRow(
                  cells: [
                    ...model.controllers.keys.where((String key) {
                      bool hasKey = items?.containsKey(key) ?? false;
                      return items == null || items.isEmpty || hasKey;
                    }).map((String key) {
                      return build_datacell_1(value: value.getValueByKey(key).toString());
                    }).toList(),
                    build_datacell_1(value: alarmName),
                    build_datacell_1(value: display_name),
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

//--------------------------------------------------------------------------------- ui_v2ray_network
Widget ui_v2ray_network<T_base>({
  required String title,
  required List<T_base> data_base,
  required List<dynamic> data_gi,
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
                DataColumn(label: build_text_1(title: 'Id')),
                DataColumn(label: build_text_1(title: 'Network')),
                DataColumn(label: build_text_1(title: 'Select')),
              ],
              //--------Items
              rows: data_base.map((data) {
                var item = (data as dynamic);
                final Map<String, dynamic>? gi = data_gi.firstWhere(
                  (row) => row['network_id'] == item.id,
                  orElse: () => null,
                );
                selected = gi != null ? gi['enable'] : false;
                return DataRow(
                  cells: [
                    build_datacell_1(value: item.id.toString()),
                    build_datacell_1(value: item.name),
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

//--------------------------------------------------------------------------------- ui_v2ray_way
Widget ui_v2ray_way<T_base>({
  required String title,
  required List<T_base> data_base,
  required List<dynamic> data_gi,
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
                DataColumn(label: build_text_1(title: 'Id')),
                DataColumn(label: build_text_1(title: 'Way')),
                DataColumn(label: build_text_1(title: 'Select')),
              ],
              //--------Items
              rows: data_base.map((data) {
                var item = (data as dynamic);
                final Map<String, dynamic>? gi = data_gi.firstWhere(
                  (row) => row['way_id'] == item.id,
                  orElse: () => null,
                );
                selected = gi != null ? gi['enable'] : false;
                return DataRow(
                  cells: [
                    build_datacell_1(value: item.id.toString()),
                    build_datacell_1(value: item.name),
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

//--------------------------------------------------------------------------------- ui_v2ray_route
Widget ui_v2ray_route<T_base>({
  required String title,
  required List<T_base> data_base,
  required List<dynamic> data_gi,
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
                DataColumn(label: build_text_1(title: 'Id')),
                DataColumn(label: build_text_1(title: 'Route')),
                DataColumn(label: build_text_1(title: 'Select')),
              ],
              //--------Items
              rows: data_base.map((data) {
                var item = (data as dynamic);
                final Map<String, dynamic>? gi = data_gi.firstWhere(
                  (row) => row['route_id'] == item.id,
                  orElse: () => null,
                );
                selected = gi != null ? gi['enable'] : false;
                return DataRow(
                  cells: [
                    build_datacell_1(value: item.id.toString()),
                    build_datacell_1(value: item.name),
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

//--------------------------------------------------------------------------------- ui_v2ray_plan
Widget ui_v2ray_plan<T_base>({
  required String title,
  required List<T_base> data_base,
  required List<dynamic> data_gi,
  required Function(int, String, String) action,
}) {
  bool selected = false;
  String value = '';
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
                DataColumn(label: build_text_1(title: 'Id')),
                DataColumn(label: build_text_1(title: 'Name')),
                DataColumn(label: build_text_1(title: 'Price')),
                DataColumn(label: build_text_1(title: 'Value')),
                DataColumn(label: build_text_1(title: 'Select')),
              ],
              //--------Items
              rows: data_base.map((data) {
                var item = (data as dynamic);
                final Map<String, dynamic>? gi = data_gi.firstWhere(
                  (row) => row['plan_id'] == item.id,
                  orElse: () => null,
                );
                value = gi != null ? gi['value'].toString() : '';
                selected = gi != null ? gi['enable'] : false;
                return DataRow(
                  cells: [
                    build_datacell_1(value: item.id.toString()),
                    build_datacell_1(value: item.name),
                    build_datacell_1(value: item.price.toString()),
                    DataCell(TextField(controller: TextEditingController(text: value), onChanged: (String v) => v != "" ? action(item.id, "value", v) : null)),
                    DataCell(Switch(value: selected, onChanged: (bool v) => action(item.id, "enable", v.toString()))),
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

//--------------------------------------------------------------------------------- ui_v2ray_inbound
Widget ui_v2ray_inbound<T_base>({
  required String title,
  required List<T_base> data_base,
  required List<dynamic> data_gi,
  required Function(int, String, bool) action,
}) {
  bool selected = false;
  bool display = false;
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
                DataColumn(label: build_text_1(title: 'Id')),
                DataColumn(label: build_text_1(title: 'Name')),
                DataColumn(label: build_text_1(title: 'Display')),
                DataColumn(label: build_text_1(title: 'Select')),
              ],
              //--------Items
              rows: data_base.map((data) {
                var item = (data as dynamic);
                final Map<String, dynamic>? gi = data_gi.firstWhere(
                  (row) => row['inbound_id'] == item.id,
                  orElse: () => null,
                );
                display = gi != null ? gi['display'] : false;
                selected = gi != null ? gi['enable'] : false;
                return DataRow(
                  cells: [
                    build_datacell_1(value: item.id.toString()),
                    build_datacell_1(value: item.name),
                    DataCell(Switch(value: display, onChanged: (bool v) => action(item.id, "display", v))),
                    DataCell(Switch(value: selected, onChanged: (bool v) => action(item.id, "enable", v))),
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
