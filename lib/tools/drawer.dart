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
          ListTile(leading: Icon(Icons.dashboard), title: Text(models_menu.dashboard), onTap: () => {prv_page.page = const_model_list.dashboard, Navigator.pop(context)}),

          // Forex
          Divider(),
          ListTile(leading: Icon(Icons.vpn_lock), title: Text("Forex"), enabled: false),
          Divider(),
          ListTile(leading: Icon(Icons.person), title: Text(models_menu.instrument), onTap: () => {prv_page.page = const_model_list.instrument, Navigator.pop(context)}),
          ListTile(leading: Icon(Icons.person), title: Text(models_menu.account), onTap: () => {prv_page.page = const_model_list.account, Navigator.pop(context)}),

          // Profit Manager
          Divider(),
          ListTile(leading: Icon(Icons.vpn_lock), title: Text("Profit Manager"), enabled: false),
          Divider(),
          ListTile(leading: Icon(Icons.person), title: Text(models_menu.profit_manager), onTap: () => {prv_page.page = const_model_list.profit_manager, Navigator.pop(context)}),
          ListTile(leading: Icon(Icons.person), title: Text(models_menu.profit_manager_item), onTap: () => {prv_page.page = const_model_list.profit_manager_item, Navigator.pop(context)}),

          // Strategy
          Divider(),
          ListTile(leading: Icon(Icons.vpn_lock), title: Text("Strategy"), enabled: false),
          Divider(),
          ListTile(leading: Icon(Icons.person), title: Text(models_menu.strategy), onTap: () => {prv_page.page = const_model_list.strategy, Navigator.pop(context)}),
          ListTile(leading: Icon(Icons.person), title: Text(models_menu.strategy_item), onTap: () => {prv_page.page = const_model_list.strategy_item, Navigator.pop(context)}),

          // Execute
          Divider(),
          ListTile(leading: Icon(Icons.vpn_lock), title: Text("Execute"), enabled: false),
          Divider(),
          ListTile(leading: Icon(Icons.person), title: Text(models_menu.live_execute), onTap: () => {prv_page.page = const_model_list.live_execute, Navigator.pop(context)}),
          ListTile(leading: Icon(Icons.person), title: Text(models_menu.back_execute), onTap: () => {prv_page.page = const_model_list.back_execute, Navigator.pop(context)}),
        ],
      ),
    );
  }
}
