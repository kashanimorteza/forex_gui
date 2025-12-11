//--------------------------------------------------------------------------------- Location
// lib/ui/ui_user.dart

//--------------------------------------------------------------------------------- Description
// This is ui for user

//--------------------------------------------------------------------------------- Import
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/tools/tools.dart';

//--------------------------------------------------------------------------------- UI : ui_search
Widget ui_search<model_user, model_group>({
  required BuildContext context,
  required String title,
  required String data_user,
  required String data_service,
  required const_search_user drp_user,
  required const_search_service drp_service,
  required model_user instance_user, //users
  required List<model_group> data_groups, //groups
  required Function(model_user) action_user_add,
  required Function(String, const_search_user) action_search_user,
  required Function(String, const_search_service) action_search_service,
  Map<String, dynamic>? fields = const {},
}) {
  TextEditingController ctr_txt_user = TextEditingController(text: data_user);
  TextEditingController ctr_txt_service = TextEditingController(text: data_service);
  const_search_user ctl_drp_user = drp_user;
  const_search_service ctl_drp_service = drp_service;
  void btn_search_user() => action_search_user(ctr_txt_user.text, ctl_drp_user);
  void btn_search_service() => action_search_service(ctr_txt_service.text, ctl_drp_service);

  //-----[Add]
  void add() {
    var items = null;
    if (fields != null) items = fields['add'];
    var model = (instance_user as dynamic);
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
                    build_dropdownlist_3<model_group>(lable: 'Group', data: data_groups, controller: model.controller_get('group_id'), selected_id: (data_groups.first as dynamic).id),
                    SizedBox(height: const_widget_padding),
                    ...model.controllers.entries.where((entry) => items == null || items.isEmpty || items.containsKey(entry.key)).map((entry) => build_Row_3(items?[entry.key] ?? entry.key, model.controller_get(entry.key))).toList(),
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
                TextButton(onPressed: () => {action_user_add(model), Navigator.pop(context)}, child: Text('Add')),
              ],
            );
          },
        );
      },
    );
  }

  //-----[View]
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: IntrinsicWidth(
      child: Card(
        child: Column(
          children: [
            //----------Title
            build_header_3(title: title, leftButton: build_icon_btn_1(onPressed: add, model: const_btn_models.add)),
            //----------Items
            Padding(
              padding: const EdgeInsets.all(const_widget_padding),
              child: Column(
                children: [
                  //----------Search user
                  SizedBox(height: const_widget_padding),
                  Row(
                    children: [
                      build_text_field_1(lable: 'User', controller: ctr_txt_user),
                      SizedBox(width: 10),
                      build_dropdownlist_2<const_search_user>(data: const_search_user.values.toList(), selected_type: ctl_drp_user, onChange: (const_search_user newValue) => ctl_drp_user = newValue),
                      SizedBox(width: 10),
                      build_btn_1(lable: 'Search User', action: btn_search_user),
                    ],
                  ),
                  //----------Search Service
                  SizedBox(height: const_widget_padding),
                  Row(
                    children: [
                      build_text_field_1(lable: 'Service', controller: ctr_txt_service),
                      SizedBox(width: 10),
                      build_dropdownlist_2(data: const_search_service.values.toList(), selected_type: ctl_drp_service, onChange: (const_search_service newValue) => ctl_drp_service = newValue),
                      SizedBox(width: 10),
                      build_btn_1(lable: 'Search Service', action: btn_search_service),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

//--------------------------------------------------------------------------------- UI : ui_users
Widget ui_users<model_user, model_group>({
  required BuildContext context,
  required String title,
  required List<model_user>? users,
  required List<model_group> groups,
  required Function(model_user) action_user_group_change,
  required Function(model_user, bool) action_user_enable_change,
  required Function(model_user, bool) action_user_delete_change,
  required Function(int) action_select_user,
}) {
  int index = 0;

  //-----[change_group]
  void change_group(model_user mdl) {
    var model = (mdl as dynamic);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, set) {
            return AlertDialog(
              title: Text('Edit Group'),
              content: SingleChildScrollView(
                child: Column(
                  children: [build_dropdownlist_3<model_group>(lable: 'Group', data: groups, controller: model.controller_get('group_id'), selected_id: model.group_id)],
                ),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
                TextButton(
                  onPressed: () {
                    action_user_group_change(model);
                    Navigator.pop(context);
                  },
                  child: Text('Update'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  //-----[List]
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: IntrinsicWidth(
      child: Column(
        children: [
          Card(
            child: Column(
              children: [
                build_header_2(title: title),
                if (users != null && users.isNotEmpty)
                  DataTable(
                    columns: [
                      DataColumn(label: build_text_1(title: 'INX')),
                      DataColumn(label: build_text_1(title: 'Id')),
                      DataColumn(label: build_text_1(title: 'Username')),
                      DataColumn(label: build_text_1(title: 'Today')),
                      DataColumn(label: build_text_1(title: 'Balance')),
                      DataColumn(label: build_text_1(title: 'Credit')),
                      DataColumn(label: build_text_1(title: 'Group')),
                      DataColumn(label: build_text_1(title: 'Enable')),
                      DataColumn(label: build_text_1(title: 'Delete')),
                    ],
                    rows: users.map((row) {
                      index = index + 1;
                      var user = row as dynamic;
                      final group_name = (groups as dynamic).firstWhere((i) => i.id == user.group_id).name;
                      return DataRow(
                        cells: [
                          DataCell(Text(index.toString())),
                          DataCell(Text(user.id.toString())),
                          DataCell(Text(user.username.toString()), onTap: () => action_select_user(user.id)),
                          DataCell(Text(formatBytes(user.today_used).toString())),
                          DataCell(Text(user.balance.toString())),
                          DataCell(Text(user.credit.toString())),
                          DataCell(Text(group_name), onTap: () => change_group(user)),
                          DataCell(build_icon_1(isAccepted: user.enable), onTap: () => action_user_enable_change(user, user.enable)),
                          DataCell(build_icon_1(isAccepted: user.delete), onTap: () => action_user_delete_change(user, user.delete)),
                        ],
                      );
                    }).toList(),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.all(const_widget_padding),
                    child: Text('No data available'),
                  ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

//--------------------------------------------------------------------------------- UI : ui_card
Widget ui_card<T_base>({
  required BuildContext context,
  required String title,
  required T_base model_base,
  required List<T_base> data_base,
  required Function(String, T_base) action,
  Map<String, dynamic>? fields = const {},
}) {
  var items = null;

  //-----[Add]
  void add() {
    var model = (model_base as dynamic);
    model.controller_clear();
    if (fields != null) items = fields['add'];
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
  void edit(T_base mdl) {
    var model = (mdl as dynamic);
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
  void delete(T_base mdl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete'),
          content: Text('Are you sure you want to delete ${(mdl as dynamic).card}?'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
            TextButton(onPressed: () => {action("delete", mdl), Navigator.pop(context)}, child: Text('Delete')),
          ],
        );
      },
    );
  }

  //-----[return]
  var model = (model_base as dynamic);
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
    ),
  );
}

//--------------------------------------------------------------------------------- UI : ui_payment
Widget ui_payment<T_base>({
  required BuildContext context,
  required String title,
  required T_base model_base,
  required List<T_base> data_base,
  required Function(String, T_base) action,
  Map<String, dynamic>? fields = const {},
}) {
  var items = null;

  //-----[Add]
  void add() {
    var model = (model_base as dynamic);
    model.controller_clear();
    if (fields != null) items = fields['add'];
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

  //-----[return]
  var model = (model_base as dynamic);
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

//--------------------------------------------------------------------------------- UI : ui_xray
Widget ui_xray<model_user, model_user_xray, model_xray_group, model_xray_plan>({
  required BuildContext context,
  required String title,
  required model_user_xray instance_model_user_xray,
  required model_xray_group instance_model_xray_group,
  required model_xray_plan instance_model_xray_plan,
  required List<model_user_xray> data_user_xray,
  required List<model_xray_group> data_xray_group,
  required List<model_xray_plan> data_xray_plan,
  required Function(int, int, String) action_xray_add,
  required Function(model_user_xray) action_xray_delete,
  required Function(model_user_xray) action_xray_update,
  required Function(int, int) action_xray_group_change,
  required Function(int, int) action_xray_plan_change,
  required Function(int, bool) action_xray_status_change,
  required Function(int) action_xray_config_get,
  required Function(int) action_xray_uuid_change,
  required Function(int) action_xray_reset,
  Map<String, dynamic>? fields = const {},
}) {
  //-----[Variable]
  var items = null;

  //-----[uuid_change]
  uuid_change(service_id) => action_xray_uuid_change(service_id);

  //-----[reset]
  reset(service_id) => action_xray_reset(service_id);

  //-----[edit_group]
  void edit_group(int id, int group_id) {
    ValueNotifier<int> ctl = ValueNotifier<int>(group_id);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, set) {
            return AlertDialog(
              title: Text('Edit Group'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    build_dropdownlist_3<model_xray_group>(lable: 'Group', data: data_xray_group, controller: ctl, selected_id: group_id),
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
                TextButton(
                  onPressed: () {
                    action_xray_group_change(id, ctl.value);
                    Navigator.pop(context);
                  },
                  child: Text('Update'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  //-----[edit_plan]
  void edit_plan(int id, int plan_id) {
    ValueNotifier<int> ctl = ValueNotifier<int>(plan_id);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, set) {
            return AlertDialog(
              title: Text('Edit Plan'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    build_dropdownlist_3<model_xray_plan>(lable: 'Plan', data: data_xray_plan, controller: ctl, selected_id: plan_id),
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
                TextButton(
                  onPressed: () {
                    action_xray_plan_change(id, ctl.value);
                    Navigator.pop(context);
                  },
                  child: Text('Update'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  //-----[getConfig]
  void getConfig(service_id) async {
    var config = await action_xray_config_get(service_id);
    config = config['data']['configs'];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        List<Map<String, dynamic>> configs = List<Map<String, dynamic>>.from(config);
        return AlertDialog(
          title: const Text('Configs'),
          content: SingleChildScrollView(
            child: Column(
              children: configs.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Column(
                    children: [
                      Text(item['group'] + ' | ' + item['network'] + ' | ' + item['way'] + ' | ' + item['route'] + ' | ' + item['inbound_transport'] + ' | ' + item['inbound_protocol'] + ' | ' + item['inbound_port'].toString()),
                      CopyTextWidget(text: item['config'], backgroundColor: Colors.green[50]),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  //-----[Add]
  void add() {
    var model = (instance_model_user_xray as dynamic);
    if (fields != null) items = fields['add'];
    model.controller_clear();
    int selected_group_id = (data_xray_group.first as dynamic).id;
    int selected_plan_id = (data_xray_plan.first as dynamic).id;
    ValueNotifier<int> ctl_group = ValueNotifier<int>(selected_group_id);
    ValueNotifier<int> ctl_plan = ValueNotifier<int>(selected_plan_id);
    TextEditingController ctl_name = TextEditingController();
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
                    //---Group
                    build_dropdownlist_3<model_xray_group>(lable: 'Group', data: data_xray_group, controller: ctl_group, selected_id: selected_group_id),
                    SizedBox(height: const_widget_padding),
                    //---Plan
                    build_dropdownlist_3<model_xray_plan>(lable: 'Plan', data: data_xray_plan, controller: ctl_plan, selected_id: selected_plan_id),
                    SizedBox(height: const_widget_padding),
                    //---Name
                    TextField(
                      controller: ctl_name,
                      decoration: InputDecoration(labelText: 'Name', border: OutlineInputBorder()),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
                TextButton(onPressed: () => {action_xray_add(ctl_group.value, ctl_plan.value, ctl_name.text), Navigator.pop(context)}, child: Text('Add')),
              ],
            );
          },
        );
      },
    );
  }

  //-----[Update]
  void update(model_user_xray model1) {
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
                TextButton(onPressed: () => {action_xray_update(model), Navigator.pop(context)}, child: Text('Update')),
              ],
            );
          },
        );
      },
    );
  }

  //-----[Delete]
  void delete(model_user_xray model) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete'),
          content: Text('Are you sure you want to delete ${(model as dynamic).name}?'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
            TextButton(
              onPressed: () => {action_xray_delete(model), Navigator.pop(context)},
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  //-----[List]
  var model = (instance_model_user_xray as dynamic);
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
                DataColumn(label: build_text_1(title: 'Group')),
                DataColumn(label: build_text_1(title: 'Plan')),
                DataColumn(label: build_text_1(title: 'PU')),
                DataColumn(label: build_text_1(title: 'VU')),
                DataColumn(label: build_text_1(title: 'BU')),
                DataColumn(label: build_text_1(title: 'TU')),
                DataColumn(label: build_text_1(title: 'Online')),
                DataColumn(label: build_text_1(title: 'Enable')),
                DataColumn(label: build_text_1(title: 'Config')),
                DataColumn(label: build_text_1(title: 'UUID')),
                DataColumn(label: build_text_1(title: 'reset')),
                DataColumn(label: build_text_1(title: 'Action')),
              ],
              //----------rows
              rows: data_user_xray.map((entry) {
                var value = (entry as dynamic);
                String group_name = (data_xray_group as dynamic).firstWhere((i) => i.id == value.group_id).name;
                String plan_name = (data_xray_plan as dynamic).firstWhere((i) => i.id == value.plan_id).name;
                return DataRow(
                  cells: [
                    ...model.controllers.keys.where((String key) {
                      bool hasKey = items?.containsKey(key) ?? false;
                      return items == null || items.isEmpty || hasKey;
                    }).map((String key) {
                      return build_datacell_1(value: value.getValueByKey(key).toString());
                    }).toList(),
                    DataCell(Text(group_name), onTap: () => edit_group(value.id, value.group_id)),
                    DataCell(Text(plan_name), onTap: () => edit_plan(value.id, value.plan_id)),
                    build_datacell_1(value: value.period_used.toString()),
                    build_datacell_1(value: value.validity_used.toString()),
                    build_datacell_1(value: formatBytes(value.bandwith_used).toString()),
                    build_datacell_1(value: formatBytes(value.today_used).toString()),
                    DataCell(build_icon_1(isAccepted: value.online)),
                    DataCell(build_icon_1(isAccepted: value.enable), onTap: () => action_xray_status_change(value.id, value.enable)),
                    DataCell(build_btn_2(action: getConfig, value: value.id, lable: 'Config')),
                    DataCell(build_btn_2(action: uuid_change, value: value.id, lable: 'Change')),
                    DataCell(build_btn_2(action: reset, value: value.id, lable: 'Reset')),
                    DataCell(build_action_1(onUpdate: (val) => update(value), onDelete: (val) => delete(value), value: value)),
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

//--------------------------------------------------------------------------------- UI : ui_v2ray
class CopyTextWidget extends StatelessWidget {
  final String text;
  final String buttonLabel;
  final double? width;
  final double? height;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;

  const CopyTextWidget({
    super.key,
    required this.text,
    this.buttonLabel = 'Copy',
    this.width,
    this.height,
    this.textStyle,
    this.backgroundColor,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding ?? const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.grey[200],
        borderRadius: borderRadius ?? BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: SelectableText(
              text,
              style: textStyle ?? Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.copy),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: text));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Copied to clipboard'),
                  behavior: SnackBarBehavior.floating,
                  action: SnackBarAction(
                    label: 'Dismiss',
                    onPressed: () {},
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
