//--------------------------------------------------------------------------------- location
// lib/main.dart

//--------------------------------------------------------------------------------- Description
// This is api module for working with api on the server

//--------------------------------------------------------------------------------- Import
import 'consts/general.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mkpanel_gui/tools/tools.dart';
import 'package:mkpanel_gui/providers/provider_drawer.dart';
import 'package:mkpanel_gui/providers/provider_screen.dart';
import 'package:mkpanel_gui/providers/provider_page.dart';
import 'package:mkpanel_gui/providers/provider_account.dart';
import 'package:mkpanel_gui/providers/provider_instrument.dart';
import 'package:mkpanel_gui/providers/provider_strategy.dart';
import 'package:mkpanel_gui/providers/provider_strategy_item.dart';
import 'package:mkpanel_gui/providers/provider_live_execute.dart';
import 'package:mkpanel_gui/providers/provider_back_execute.dart';
import 'package:mkpanel_gui/providers/provider_profit_manager.dart';
import 'package:mkpanel_gui/providers/provider_profit_manager_item.dart';
import 'package:mkpanel_gui/providers/provider_money_management.dart';

//--------------------------------------------------------------------------------- Main
void main() {
  //--------------------[Variable]
  OSLists os = GetOS();
  DeviceLists device = DeviceLists.desktop;

  //--------------------[RunApp]
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Provider_Drawer(os: os, device: device),
        ),
        ChangeNotifierProvider(create: (context) => Provider_Screen()),
        ChangeNotifierProvider(create: (context) => Provider_Page()),
        ChangeNotifierProvider(create: (context) => provider_account()),
        ChangeNotifierProvider(create: (context) => provider_instrument()),
        ChangeNotifierProvider(create: (context) => provider_strategy()),
        ChangeNotifierProvider(create: (context) => provider_strategy_item()),
        ChangeNotifierProvider(create: (context) => provider_live_execute()),
        ChangeNotifierProvider(create: (context) => provider_back_execute()),
        ChangeNotifierProvider(create: (context) => provider_profit_manager()),
        ChangeNotifierProvider(create: (context) => provider_profit_manager_item()),
        ChangeNotifierProvider(create: (context) => provider_money_management()),
      ],
      child: MyApp(),
    ),
  );
}

//--------------------------------------------------------------------------------- MyApp
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var prv_screen = Provider.of<Provider_Screen>(context, listen: false);
      prv_screen.updateScreenSize(MediaQuery.of(context).size.width);
      final prv_drawer = Provider.of<Provider_Drawer>(context, listen: false);
      prv_drawer.device = prv_screen.device;
    });
    return MaterialApp(home: MyHomePage());
  }
}

//--------------------------------------------------------------------------------- MyHomePage
class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//--------------------------------------------------------------------------------- _MyHomePageState
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    print('--- MyHomePage : build');
    final prv_drawer = Provider.of<Provider_Drawer>(context, listen: false);
    final prv_page = Provider.of<Provider_Page>(context, listen: true);
    prv_page.drawer ??= prv_drawer.drawer;
    prv_page.context ??= context;
    return prv_page.ui;
  }
}
