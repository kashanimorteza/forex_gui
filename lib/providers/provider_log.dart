//--------------------------------------------------------------------------------- location
// lib/providers/provider_log.dart

//--------------------------------------------------------------------------------- Description
// This is provider for log

//--------------------------------------------------------------------------------- Import
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/consts/model.dart';
import 'package:mkpanel_gui/tools/tools.dart';
import 'package:mkpanel_gui/providers/provider_page.dart';
import 'package:mkpanel_gui/models/model_log.dart';

//--------------------------------------------------------------------------------- Global
String title = models_title.log;

//--------------------------------------------------------------------------------- Provider
class provider_log with ChangeNotifier {
  //--------------------------------[Fields]
  var _context;
  var _drawer;
  var _prv;
  var _data_items;
  var _data_display;
  late model_log _model_base;

  //--------------------------------[Contractor]
  provider_log() {
    _model_base = modelType();
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
      case 'items':
        _data_items = await _model_base.items();
      default:
        _data_items = await _model_base.items();
    }
    reload();
  }

  //----------[reload]
  reload() => _prv.ui = view();

  //----------[action]
  action(action, item) async {
    switch (action) {
      case 'reload':
        _data_items = await _model_base.items();
        reload();
      case 'display':
        _data_display = await _model_base.item(item);
        reload();
      case 'clear':
        await _model_base.clear(item);
        _data_display = [];
        load();
        reload();
      case 'truncate':
        await _model_base.truncate();
        _data_display = [];
        load();
        reload();
    }
  }

  //--------------------------------------------------------------------------------- UI
  //------------------------------[view]
  view() {
    //----------[view_1]
    var view_1 = ui_1(
      context: _context,
      title: 'Subjects',
      dataList: _data_items,
      action: action,
    );
    //----------[view_2]
    var view_2 = ui_2(
      title: "Detaile",
      data: _data_display,
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
              Padding(padding: EdgeInsets.all(const_widget_padding), child: view_1),
              Padding(padding: EdgeInsets.all(const_widget_padding), child: view_2),
            ],
          ),
        ),
      ),
    );

    //----------[return]
    return Scaffold(appBar: app_bar, drawer: _drawer, body: body);
  }
}

//------------------------------[ui_1]
Widget ui_1({
  required BuildContext context,
  required String title,
  required List<dynamic> dataList,
  required Function(String, String) action,
}) {
  //-----[action]
  reload() => action('reload', '');
  truncate() => action('truncate', '');
  display(item) => action('display', item);
  clear(item) => action('clear', item);

  var leftButton = Row(children: [
    build_icon_btn_1(onPressed: reload, model: const_btn_models.refresh),
    SizedBox(width: 5),
    build_icon_btn_1(onPressed: truncate, model: const_btn_models.clear),
  ]);

  //-----[return]
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: IntrinsicWidth(
      child: Card(
        child: Column(
          children: [
            //----------Title
            build_header_3(title: title, leftButton: leftButton),
            //----------Table
            DataTable(
              columns: [
                DataColumn(label: build_text_1(title: 'Item')),
                DataColumn(label: build_text_1(title: 'Count')),
                DataColumn(label: build_text_1(title: '')),
                DataColumn(label: build_text_1(title: '')),
              ],
              rows: dataList.map<DataRow>((item) {
                return DataRow(
                  cells: [
                    build_datacell_1(value: item['name']),
                    build_datacell_1(value: item['count'].toString()),
                    DataCell(build_btn_2(action: display, value: item['name'], lable: 'Display')),
                    DataCell(build_btn_2(action: clear, value: item['name'], color_background: Colors.red, lable: 'Clear')),
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
  required List<dynamic>? data,
}) {
  //-----[Check data]
  if (data == null || data.isEmpty) return const SizedBox.shrink();
  //-----[Keys]
  final keys = data.first.keys.toList();
  //-----[return]
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: IntrinsicWidth(
      child: Card(
        child: Column(
          children: [
            //----------Title
            build_header_2(title: title),
            //----------Table
            DataTable(
              columns: [...keys.map((key) => DataColumn(label: build_text_1(title: key)))],
              rows: data.map<DataRow>((item) {
                return DataRow(cells: [...keys.map((key) => build_datacell_1(value: item[key].toString()))]);
              }).toList(),
            ),
          ],
        ),
      ),
    ),
  );
}
