//--------------------------------------------------------------------------------- Location
// lib/consts/model.dart

//--------------------------------------------------------------------------------- Description
// Model const are here

//--------------------------------------------------------------------------------- Import

//--------------------------------------------------------------------------------- General
enum const_model_mode { view, edit }

enum const_model_list { dashboard, account, instrument, strategy, strategy_item, live_execute, live_order }

class models_api {
  static const String dashboard = 'dashboard';
  static const String account = 'account';
  static const String instrument = 'instrument';
  static const String strategy = 'strategy';
  static const String strategy_item = 'strategy_item';
  static const String live_execute = 'live_execute';
  static const String live_order = 'live_order';
}

class models_title {
  static const String base = 'Forex API';
  static const String dashboard = 'Dashboard';
  static const String account = 'Account';
  static const String instrument = 'Instrument';
  static const String strategy = 'Strategy';
  static const String strategy_item = 'Strategy Item';
  static const String live_execute = 'Execute';
  static const String live_order = 'Order';
}

class models_menu {
  static const String base = 'Forex API';
  static const String dashboard = 'Dashboard';
  static const String account = 'Account';
  static const String instrument = 'Instrument';
  static const String strategy = 'Strategy';
  static const String strategy_item = 'Item';
  static const String live_execute = 'Live';
  static const String live_order = 'Live Order';
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
  static Map<String, dynamic> live_execute = {
    'list': {'id': 'Id', 'name': 'Name', 'status': 'Status'},
    'add': {'name': 'Name', 'description': 'Description'},
    'edit': {'name': 'Name', 'description': 'Description'},
  };
  static Map<String, dynamic> live_order = {
    'list': {'id': 'Id', 'date': 'Date', 'symbol': 'Symbol', 'action': 'Action', 'amount': 'Amount', 'profit': 'Profit', 'ask': 'Ask', 'bid': 'Bid', 'tp': 'TP', 'sl': 'SL', 'status': 'Status'},
    'add': {},
    'edit': {},
  };
}
