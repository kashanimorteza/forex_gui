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
          ListTile(leading: Icon(Icons.person), title: Text(models_title.instrument), onTap: () => {prv_page.page = const_model_list.instrument, Navigator.pop(context)}),
          ListTile(leading: Icon(Icons.person), title: Text(models_title.account), onTap: () => {prv_page.page = const_model_list.account, Navigator.pop(context)}),
          Divider(),
        ],
      ),
    );
  }
}
