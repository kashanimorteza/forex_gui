//--------------------------------------------------------------------------------- Location
// lib/consts/model.dart

//--------------------------------------------------------------------------------- Description
// Model const are here

//--------------------------------------------------------------------------------- Import

//--------------------------------------------------------------------------------- General
enum const_model_mode { view, edit }

enum const_model_list { dashboard, account, instrument, strategy, strategy_item, test_live, user, log, config, xray, service_v2ray, service_v2ray_server, service_v2ray_inbound, service_v2ray_service, service_v2ray_plan, service_v2ray_group, group, service, network, server, route, domain, alarm, display, certificate, telegram_instance }

class models_title {
  static const String base = 'Forex API';
  static const String dashboard = 'Dashboard';
  static const String account = 'Account';
  static const String instrument = 'Instrument';
  static const String strategy = 'Strategy';
  static const String strategy_item = 'Strategy Item';
  static const String test_live = 'Test Live';
}

class models_api {
  static const String dashboard = 'dashboard';
  static const String account = 'account';
  static const String instrument = 'instrument';
  static const String strategy = 'strategy';
  static const String strategy_item = 'strategy_item';
  static const String test_live = 'test_live';
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
  static Map<String, dynamic> strategy = {
    'list': {'id': 'Id', 'name': 'Name'},
    'add': {'name': 'Name', 'description': 'Description'},
    'edit': {'name': 'Name', 'description': 'Description'},
  };
  static Map<String, dynamic> strategy_item = {
    'list': {'id': 'Id', 'name': 'Name', 'params': 'Params'},
    'add': {'name': 'Name', 'params': 'Params', 'description': 'Description'},
    'edit': {'name': 'Name', 'params': 'Params', 'description': 'Description'},
  };
  static Map<String, dynamic> test_live = {
    'list': {'id': 'Id', 'date': 'Date', 'name': 'Name', 'strategy_item_id': 'Strategy Item ID', 'account_id': 'Account ID', 'status': 'Status'},
    'add': {'date': 'Date', 'name': 'Name', 'strategy_item_id': 'Strategy Item ID', 'account_id': 'Account ID', 'status': 'Status', 'description': 'Description'},
    'edit': {'date': 'Date', 'name': 'Name', 'strategy_item_id': 'Strategy Item ID', 'account_id': 'Account ID', 'status': 'Status', 'description': 'Description'},
  };
}
