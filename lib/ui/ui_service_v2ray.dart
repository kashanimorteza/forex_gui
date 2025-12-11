//--------------------------------------------------------------------------------- location
// lib/ui/ui_service_v2ray_group.dart

//--------------------------------------------------------------------------------- Description
// This is ui for service v2ray group

//--------------------------------------------------------------------------------- Import
import 'package:flutter/material.dart';
import 'package:mkpanel_gui/tools/tools.dart';
import 'package:mkpanel_gui/models/model_general.dart';
import 'package:mkpanel_gui/models/model_network.dart';
import 'package:mkpanel_gui/models/model_route.dart';
import 'package:mkpanel_gui/models/model_way.dart';
import 'package:mkpanel_gui/models/model_service_v2ray_inbound.dart';

//--------------------------------------------------------------------------------- ui_v2ray_network
Widget ui_v2ray_network({
  required Map<String, model_network_item>? model_base,
  required List<model_network>? data_base,
  required Function(int, bool) action,
}) {
  bool selected = false;
  return IntrinsicWidth(
    child: Card(
      child: Column(
        children: [
          //----------Title
          build_header_2(title: "Networks"),
          //----------header
          DataTable(
            columns: [
              DataColumn(label: build_text_1(title: 'Name')),
              DataColumn(label: build_text_1(title: 'Select')),
            ],
            //----------rows
            rows: (data_base ?? []).map((value) {
              selected = model_base?[value.id.toString()]?.enable ?? false;
              return DataRow(
                cells: [
                  DataCell(Text(value.name)),
                  DataCell(Switch(value: selected, onChanged: (bool v) => action(value.id, v))),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    ),
  );
}

//--------------------------------------------------------------------------------- ui_v2ray_network
Widget ui_v2ray_way({
  required Map<String, model_way_item>? model_base,
  required List<model_way>? data_base,
  required Function(int, bool) action,
}) {
  bool selected = false;
  return IntrinsicWidth(
    child: Card(
      child: Column(
        children: [
          //----------Title
          build_header_2(title: "Ways"),
          //----------header
          DataTable(
            columns: [
              DataColumn(label: build_text_1(title: 'Name')),
              DataColumn(label: build_text_1(title: 'Select')),
            ],
            //----------rows
            rows: (data_base ?? []).map((value) {
              selected = model_base?[value.id.toString()]?.enable ?? false;
              return DataRow(
                cells: [
                  DataCell(Text(value.name)),
                  DataCell(Switch(value: selected, onChanged: (bool v) => action(value.id, v))),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    ),
  );
}

//--------------------------------------------------------------------------------- ui_v2ray_route
Widget ui_v2ray_route({
  required Map<String, bool>? model_base,
  required List<model_route>? data_base,
  required Function(int, bool) action,
}) {
  bool selected = false;
  return IntrinsicWidth(
    child: Card(
      child: Column(
        children: [
          //----------Title
          build_header_2(title: "Routes"),
          //----------header
          DataTable(
            columns: [
              DataColumn(label: build_text_1(title: 'Name')),
              DataColumn(label: build_text_1(title: 'Select')),
            ],
            //----------rows
            rows: (data_base ?? []).map((value) {
              selected = model_base?[value.id.toString()] ?? false;
              return DataRow(
                cells: [
                  DataCell(Text(value.name)),
                  DataCell(Switch(value: selected, onChanged: (bool v) => action(value.id, v))),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    ),
  );
}

//--------------------------------------------------------------------------------- ui_v2ray_inbound
Widget ui_v2ray_inbound({
  required Map<String, model_inbound_item>? model_base,
  required List<model_service_v2ray_inbound>? data_base,
  required Function(String, int, bool) action,
}) {
  bool selected = false;
  bool displayed = false;
  return IntrinsicWidth(
    child: Card(
      child: Column(
        children: [
          //----------Title
          build_header_2(title: "Inbounds"),
          //----------header
          DataTable(
            columns: [
              DataColumn(label: build_text_1(title: 'Name')),
              DataColumn(label: build_text_1(title: 'Display')),
              DataColumn(label: build_text_1(title: 'Select')),
            ],
            //----------rows
            rows: (data_base ?? []).map((value) {
              selected = model_base?[value.id.toString()]?.enable ?? false;
              displayed = model_base?[value.id.toString()]?.display ?? false;
              return DataRow(
                cells: [
                  DataCell(Text(value.name)),
                  DataCell(Switch(value: selected, onChanged: (bool v) => action('enable', value.id, v))),
                  DataCell(Switch(value: displayed, onChanged: (bool v) => action('display', value.id, v))),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    ),
  );
}
