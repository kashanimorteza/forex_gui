//--------------------------------------------------------------------------------- Location
// lib/consts/model.dart

//--------------------------------------------------------------------------------- Description
// Model const are here

//--------------------------------------------------------------------------------- Import

//--------------------------------------------------------------------------------- General
enum const_model_mode { view, edit }

enum const_model_list { dashboard, account, instrument, user, log, config, xray, service_v2ray, service_v2ray_server, service_v2ray_inbound, service_v2ray_service, service_v2ray_plan, service_v2ray_group, group, service, network, server, route, domain, alarm, display, certificate, telegram_instance }

class models_title {
  static const String base = 'Forex API';
  static const String dashboard = 'Dashboard';
  static const String account = 'Account';
  static const String instrument = 'Instrument';
}

class models_api {
  static const String dashboard = 'dashboard';
  static const String account = 'account';
  static const String instrument = 'instrument';
}

class models_fileds {
  static Map<String, dynamic> account = {
    'list': {'id': 'Id', 'name': 'Name', 'broker': 'Broker', 'type': 'Type', 'currency': 'Currency'},
    'add': {'name': 'Name', 'broker': 'Broker', 'type': 'Type', 'currency': 'Currency', 'server': 'Server', 'username': 'Username', 'password': 'Password', 'description': 'Description'},
    'edit': {'name': 'Name', 'broker': 'Broker', 'type': 'Type', 'currency': 'Currency', 'server': 'Server', 'username': 'Username', 'password': 'Password', 'description': 'Description'},
  };
  static Map<String, dynamic> instrument = {
    'list': {'id': 'Id', 'name': 'Name', 'instrument': 'Instrument', 'category': 'Category', 'priority': 'Priority'},
    'add': {'name': 'Name', 'instrument': 'Instrument', 'category': 'Category', 'priority': 'Priority', 'description': 'Description'},
    'edit': {'name': 'Name', 'instrument': 'Instrument', 'category': 'Category', 'priority': 'Priority', 'description': 'Description'},
  };
}
