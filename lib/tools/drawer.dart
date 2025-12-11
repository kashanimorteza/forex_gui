//--------------------------------------------------------------------------------- location
// lib/tools/drawer.dart

//--------------------------------------------------------------------------------- Description
// This is drawers

//--------------------------------------------------------------------------------- Import
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mkpanel_gui/providers/provider_page.dart';
import 'package:mkpanel_gui/consts/model.dart';

//--------------------------------------------------------------------------------- DrawerDesktop
class DrawerDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prv_page = Provider.of<Provider_Page>(context, listen: false);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // Header
          DrawerHeader(decoration: BoxDecoration(color: Colors.blue), child: Text('MKVPN', style: TextStyle(color: Colors.white, fontSize: 24))),

          // Dashboard
          ListTile(leading: Icon(Icons.dashboard), title: Text(models_title.dashboard), onTap: () => {prv_page.page = const_model_list.dashboard, Navigator.pop(context)}),
          ListTile(leading: Icon(Icons.person), title: Text(models_title.user), onTap: () => {prv_page.page = const_model_list.user, Navigator.pop(context)}),
          ListTile(leading: Icon(Icons.person), title: Text(models_title.log), onTap: () => {prv_page.page = const_model_list.log, Navigator.pop(context)}),
          Divider(),

          // V2ray Section
          ListTile(leading: Icon(Icons.vpn_lock), title: Text("V2ray"), enabled: false),
          Divider(),
          ListTile(
              leading: Icon(Icons.dns_outlined), // Changed from router
              title: Text(models_title.service_v2ray_server),
              onTap: () => {prv_page.page = const_model_list.service_v2ray_server, Navigator.pop(context)}),
          ListTile(
              leading: Icon(Icons.input), // Changed from router
              title: Text(models_title.service_v2ray_inbound),
              onTap: () => {prv_page.page = const_model_list.service_v2ray_inbound, Navigator.pop(context)}),
          ListTile(
              leading: Icon(Icons.view_timeline), // Changed from router
              title: Text(models_title.service_v2ray_plan),
              onTap: () => {prv_page.page = const_model_list.service_v2ray_plan, Navigator.pop(context)}),
          ListTile(leading: Icon(Icons.cloud_queue), title: Text(models_title.service_v2ray_group), onTap: () => {prv_page.page = const_model_list.service_v2ray_group, Navigator.pop(context)}),

          Divider(),

          // Objects Section
          ListTile(leading: Icon(Icons.category), title: Text("Objects"), enabled: false),
          Divider(),
          ListTile(leading: Icon(Icons.groups), title: Text(models_title.group), onTap: () => {prv_page.page = const_model_list.group, Navigator.pop(context)}),
          ListTile(leading: Icon(Icons.settings_applications), title: Text(models_title.config), onTap: () => {prv_page.page = const_model_list.config, Navigator.pop(context)}),
          ListTile(leading: Icon(Icons.miscellaneous_services), title: Text(models_title.service), onTap: () => {prv_page.page = const_model_list.service, Navigator.pop(context)}),
          ListTile(leading: Icon(Icons.domain), title: Text(models_title.domain), onTap: () => {prv_page.page = const_model_list.domain, Navigator.pop(context)}),
          ListTile(
              leading: Icon(Icons.security), // Changed from domain
              title: Text(models_title.certificate),
              onTap: () => {prv_page.page = const_model_list.certificate, Navigator.pop(context)}),
          ListTile(leading: Icon(Icons.network_check), title: Text(models_title.network), onTap: () => {prv_page.page = const_model_list.network, Navigator.pop(context)}),
          ListTile(leading: Icon(Icons.alt_route), title: Text(models_title.way), onTap: () => {prv_page.page = const_model_list.way, Navigator.pop(context)}),
          ListTile(leading: Icon(Icons.warning), title: Text(models_title.alarm), onTap: () => {prv_page.page = const_model_list.alarm, Navigator.pop(context)}),
          ListTile(leading: Icon(Icons.display_settings), title: Text(models_title.display), onTap: () => {prv_page.page = const_model_list.display, Navigator.pop(context)}),
          ListTile(leading: Icon(Icons.dns), title: Text(models_title.server), onTap: () => {prv_page.page = const_model_list.server, Navigator.pop(context)}),
          ListTile(leading: Icon(Icons.route), title: Text(models_title.route), onTap: () => {prv_page.page = const_model_list.route, Navigator.pop(context)}),
          ListTile(leading: Icon(Icons.route), title: Text(models_title.telegram_instance), onTap: () => {prv_page.page = const_model_list.telegram_instance, Navigator.pop(context)}),
        ],
      ),
    );
  }
}
