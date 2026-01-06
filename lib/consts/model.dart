//--------------------------------------------------------------------------------- Location
// lib/consts/model.dart

//--------------------------------------------------------------------------------- Description
// Model const are here

//--------------------------------------------------------------------------------- Import

//--------------------------------------------------------------------------------- General
enum const_model_mode { view, edit }

enum const_model_list { dashboard, account, instrument, strategy, strategy_item, live_execute, live_order, live_order_detaile, back_execute, back_order, back_order_detaile, profit_manager, profit_manager_item, money_management }

class models_api {
  static const String dashboard = 'dashboard';
  static const String account = 'account';
  static const String instrument = 'instrument';
  static const String strategy = 'strategy';
  static const String strategy_item = 'strategy_item';
  static const String live_execute = 'live';
  static const String live_order = 'live';
  static const String live_order_detaile = 'live';
  static const String back_execute = 'back';
  static const String back_order = 'back';
  static const String back_order_detaile = 'back';
  static const String profit_manager = 'profit_manager';
  static const String profit_manager_item = 'profit_manager_item';
  static const String money_management = 'money_management';
}

class models_title {
  static const String base = 'Forex API';
  static const String dashboard = 'Dashboard';
  static const String account = 'Account';
  static const String instrument = 'Instrument';
  static const String strategy = 'Strategy';
  static const String strategy_item = 'Strategy Item';
  static const String live_execute = 'Execute : Live';
  static const String live_order = 'Order';
  static const String live_order_detaile = 'Details';
  static const String back_execute = 'Execute : Back';
  static const String back_order = 'Order';
  static const String back_order_detaile = 'Details';
  static const String profit_manager = 'Profit Manager : Strategy';
  static const String profit_manager_item = 'Profit Manager : Item';
  static const String money_management = 'Money Management';
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
  static const String live_order_detaile = 'Test Order Details';
  static const String back_execute = 'Test';
  static const String back_order = 'Test Order';
  static const String back_order_detaile = 'Test Order Details';
  static const String profit_manager = 'Strategy';
  static const String profit_manager_item = 'Item';
  static const String money_management = 'Money Management';
}

class models_fileds {
  static Map<String, dynamic> account = {
    'list': {'id': 'Id', 'name': 'Name', 'broker': 'Broker', 'type': 'Type', 'currency': 'Currency'},
    'add': {'name': 'Name', 'broker': 'Broker', 'type': 'Type', 'currency': 'Currency', 'server': 'Server', 'username': 'Username', 'password': 'Password', 'description': 'Description'},
    'edit': {'name': 'Name', 'broker': 'Broker', 'type': 'Type', 'currency': 'Currency', 'server': 'Server', 'username': 'Username', 'password': 'Password', 'description': 'Description'},
  };
  static Map<String, dynamic> instrument = {
    'list': {'id': 'Id', 'name': 'Name', 'instrument': 'Instrument', 'category': 'Category', 'priority': 'Priority', 'point_size': 'Point Size', 'digits': 'Digits'},
    'add': {'name': 'Name', 'instrument': 'Instrument', 'category': 'Category', 'priority': 'Priority', 'point_size': 'Point Size', 'digits': 'Digits', 'description': 'Description'},
    'edit': {'name': 'Name', 'instrument': 'Instrument', 'category': 'Category', 'priority': 'Priority', 'point_size': 'Point Size', 'digits': 'Digits', 'description': 'Description'},
  };
  static Map<String, dynamic> strategy = {
    'list': {'id': 'Id', 'name': 'Name', 'description': 'Description'},
    'add': {'name': 'Name', 'description': 'Description'},
    'edit': {'name': 'Name', 'description': 'Description'},
  };
  static Map<String, dynamic> strategy_item = {
    'list': {'id': 'Id', 'name': 'Name', 'symbols': 'Symbols', 'actions': 'Actions', 'amount': 'Amount', 'tp_pips': 'TP Pips', 'sl_pips': 'SL Pips', 'limit_profit': 'Limit Profit'},
    'add': {'name': 'Name', 'symbols': 'Symbols', 'actions': 'Actions', 'amount': 'Amount', 'tp_pips': 'TP Pips', 'sl_pips': 'SL Pips', 'limit_profit': 'Limit Profit'},
    'edit': {'name': 'Name', 'symbols': 'Symbols', 'actions': 'Actions', 'amount': 'Amount', 'tp_pips': 'TP Pips', 'sl_pips': 'SL Pips', 'limit_profit': 'Limit Profit', 'params': 'Param', 'description': 'Description'},
  };
  static Map<String, dynamic> live_execute = {
    'list': {'id': 'Id', 'name': 'Name', 'date_from': 'From', 'date_to': 'To', 'status': 'Status', 'step': 'Step'},
    'add': {'name': 'Name', 'date_from': 'From', 'date_to': 'To', 'step': 'Step', 'description': 'Description'},
    'edit': {'name': 'Name', 'date_from': 'From', 'date_to': 'To', 'step': 'Step', 'description': 'Description'},
  };
  static Map<String, dynamic> live_order = {
    'list': {'id': 'Id', 'father_id': 'Father', 'date_open': 'Open', 'price_open': 'Price', 'date_close': 'Close', 'price_close': 'Price', 'profit': 'Profit', 'status': 'Status', 'symbol': 'Symbol', 'action': 'Action', 'amount': 'Amount', 'tp': 'TP', 'sl': 'SL'},
    'add': {},
    'edit': {},
  };
  static Map<String, dynamic> live_order_detaile = {
    'list': {
      'step': 'Step',
      'date_from': 'From',
      'date_to': 'To',
      'trade_all': 'Trade',
      'trade_open': 'Open',
      'trade_close': 'Close',
      'trade_buy': 'Buy',
      'trade_sell': 'Sell',
      'profit_all': 'Profit',
      'profit_positive': 'Positive',
      'profit_negative': 'Negative',
      'profit_close_min': 'P-C(min)',
      'profit_close_max': 'P-C(max)',
      'profit_open_min': 'P-O(min)',
      'profit_open_max': 'P-O(max)',
      'profit_min': 'P(min)',
      'profit_max': 'P(max)',
      'param': 'Param'
    },
    'add': {},
    'edit': {},
  };
  static Map<String, dynamic> back_execute = {
    'list': {'id': 'Id', 'name': 'Name', 'date_from': 'From', 'date_to': 'To', 'status': 'Status', 'step': 'Step'},
    'add': {'name': 'Name', 'date_from': 'From', 'date_to': 'To', 'step': 'Step'},
    'edit': {'name': 'Name', 'date_from': 'From', 'date_to': 'To', 'step': 'Step', 'description': 'Description'},
  };
  static Map<String, dynamic> back_order = {
    'list': {'id': 'Id', 'father_id': 'Father', 'date_open': 'Open', 'price_open': 'Price', 'date_close': 'Close', 'price_close': 'Price', 'profit': 'Profit', 'status': 'Status', 'symbol': 'Symbol', 'action': 'Action', 'amount': 'Amount', 'tp': 'TP', 'sl': 'SL', 'spread': 'SP', 'profit_manager': 'PM'},
    'add': {},
    'edit': {},
  };
  static Map<String, dynamic> back_order_detaile = {
    'list': {
      'step': 'Step',
      'date_from': 'From',
      'date_to': 'To',
      'trade_all': 'Trade',
      'trade_open': 'Open',
      'trade_close': 'Close',
      'trade_buy': 'Buy',
      'trade_sell': 'Sell',
      'profit_all': 'Profit',
      'profit_positive': 'Positive',
      'profit_negative': 'Negative',
      'profit_close_min': 'Close(min)',
      'profit_close_max': 'Close(max)',
      'profit_open_min': 'Open(min)',
      'profit_open_max': 'Open(max)',
      'profit_min': 'P(min)',
      'profit_max': 'P(max)',
      'param': 'Param'
    },
    'add': {},
    'edit': {},
  };
  static Map<String, dynamic> profit_manager = {
    'list': {'id': 'Id', 'name': 'Name', 'description': 'Description'},
    'add': {'name': 'Name'},
    'edit': {'name': 'Name', 'description': 'Description'},
  };
  static Map<String, dynamic> profit_manager_item = {
    'list': {'id': 'Id', 'name': 'Name', 'value': 'Profit', 'tp_value': 'TP', 'sl_value': 'SL'},
    'add': {'name': 'Name', 'value': 'Profit', 'tp_value': 'TP', 'sl_value': 'SL'},
    'edit': {'name': 'Name', 'value': 'Profit', 'tp_value': 'TP', 'sl_value': 'SL', 'description': 'Description'},
  };
  static Map<String, dynamic> money_management = {
    'list': {'id': 'Id', 'name': 'Name', 'balance': 'Balance', 'risk': 'Risk', 'limit_trade': 'Limit Trade', 'limit_profit': 'Limit Profit', 'limit_loss': 'Limit Loss', 'limit_stop': 'Limit Stop'},
    'add': {'name': 'Name', 'balance': 'Balance', 'risk': 'Risk', 'limit_trade': 'Limit Trade', 'limit_profit': 'Limit Profit', 'limit_loss': 'Limit Loss', 'limit_stop': 'Limit Stop'},
    'edit': {'name': 'Name', 'balance': 'Balance', 'risk': 'Risk', 'limit_trade': 'Limit Trade', 'limit_profit': 'Limit Profit', 'limit_loss': 'Limit Loss', 'limit_stop': 'Limit Stop', 'description': 'Description'},
  };
}
