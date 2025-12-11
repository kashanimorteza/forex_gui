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
import 'package:mkpanel_gui/providers/provider_start.dart';
import 'package:mkpanel_gui/providers/provider_dashboard.dart';
import 'package:mkpanel_gui/providers/provider_user.dart';
import 'package:mkpanel_gui/providers/provider_log.dart';
import 'package:mkpanel_gui/providers/provider_config.dart';
import 'package:mkpanel_gui/providers/provider_service_v2ray_server.dart';
import 'package:mkpanel_gui/providers/provider_service_v2ray_inbound.dart';
import 'package:mkpanel_gui/providers/provider_xray_plan.dart';
import 'package:mkpanel_gui/providers/provider_xray_group.dart';
import 'package:mkpanel_gui/providers/provider_service.dart';
import 'package:mkpanel_gui/providers/provider_group.dart';
import 'package:mkpanel_gui/providers/provider_network.dart';
import 'package:mkpanel_gui/providers/provider_way.dart';
import 'package:mkpanel_gui/providers/provider_server.dart';
import 'package:mkpanel_gui/providers/provider_domain.dart';
import 'package:mkpanel_gui/providers/provider_certificate.dart';
import 'package:mkpanel_gui/providers/provider_route.dart';
import 'package:mkpanel_gui/providers/provider_alarm.dart';
import 'package:mkpanel_gui/providers/provider_display.dart';
import 'package:mkpanel_gui/providers/provider_telegram_instance.dart';

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
        ChangeNotifierProvider(create: (context) => provider_start()),
        ChangeNotifierProvider(create: (context) => provider_dashboard()),
        ChangeNotifierProvider(create: (context) => provider_user()),
        ChangeNotifierProvider(create: (context) => provider_log()),
        ChangeNotifierProvider(create: (context) => provider_config()),
        ChangeNotifierProvider(create: (context) => provider_service_v2ray_server()),
        ChangeNotifierProvider(create: (context) => provider_service_v2ray_inbound()),
        ChangeNotifierProvider(create: (context) => provider_service_v2ray_plan()),
        ChangeNotifierProvider(create: (context) => provider_xray_group()),
        ChangeNotifierProvider(create: (context) => provider_service()),
        ChangeNotifierProvider(create: (context) => provider_domain()),
        ChangeNotifierProvider(create: (context) => provider_certificate()),
        ChangeNotifierProvider(create: (context) => provider_network()),
        ChangeNotifierProvider(create: (context) => provider_way()),
        ChangeNotifierProvider(create: (context) => provider_route()),
        ChangeNotifierProvider(create: (context) => provider_server()),
        ChangeNotifierProvider(create: (context) => provider_route()),
        ChangeNotifierProvider(create: (context) => provider_group()),
        ChangeNotifierProvider(create: (context) => provider_alarm()),
        ChangeNotifierProvider(create: (context) => provider_display()),
        ChangeNotifierProvider(create: (context) => provider_telegram_instance()),
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
