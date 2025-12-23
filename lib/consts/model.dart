//--------------------------------------------------------------------------------- Location
// lib/consts/model.dart

//--------------------------------------------------------------------------------- Description
// Model const are here

//--------------------------------------------------------------------------------- Import

//--------------------------------------------------------------------------------- General
enum const_model_mode { view, edit }

enum const_model_list { dashboard, account, instrument, strategy, strategy_item, live_execute, live_order, back_execute, back_order, back_order_detaile }

class models_api {
  static const String dashboard = 'dashboard';
  static const String account = 'account';
  static const String instrument = 'instrument';
  static const String strategy = 'strategy';
  static const String strategy_item = 'strategy_item';
  static const String live_execute = 'live_execute';
  static const String live_order = 'live_order';
  static const String back_execute = 'back_execute';
  static const String back_order = 'back_order';
  static const String back_order_detaile = 'back_order';
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
  static const String back_execute = 'Back Test';
  static const String back_order = 'Back Order';
  static const String back_order_detaile = 'Back Order Details';
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
  static const String back_execute = 'Test';
  static const String back_order = 'Test Order';
  static const String back_order_detaile = 'Test Order Details';
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
    'list': {'id': 'Id', 'name': 'Name', 'symbols': 'Symbols', 'actions': 'Actions', 'amount': 'Amount', 'tp_pips': 'TP Pips', 'sl_pips': 'SL Pips', 'limit_trade': 'Limit Trade', 'limit_profit': 'Limit Profit', 'limit_loss': 'Limit Loss'},
    'add': {'name': 'Name', 'symbols': 'Symbols', 'actions': 'Actions', 'amount': 'Amount', 'tp_pips': 'TP Pips', 'sl_pips': 'SL Pips', 'limit_trade': 'Limit Trade', 'limit_profit': 'Limit Profit', 'limit_loss': 'Limit Loss', 'enable': 'Enable', 'description': 'Description'},
    'edit': {'name': 'Name', 'symbols': 'Symbols', 'actions': 'Actions', 'amount': 'Amount', 'tp_pips': 'TP Pips', 'sl_pips': 'SL Pips', 'limit_trade': 'Limit Trade', 'limit_profit': 'Limit Profit', 'limit_loss': 'Limit Loss', 'description': 'Description'},
  };
  static Map<String, dynamic> live_execute = {
    'list': {'id': 'Id', 'name': 'Name', 'status': 'Status'},
    'add': {'name': 'Name', 'description': 'Description'},
    'edit': {'name': 'Name', 'description': 'Description'},
  };
  static Map<String, dynamic> live_order = {
    'list': {'id': 'Id', 'date': 'Date', 'trade_id': 'Trade', 'symbol': 'Symbol', 'action': 'Action', 'amount': 'Amount', 'profit': 'Profit', 'ask': 'Ask', 'bid': 'Bid', 'tp': 'TP', 'sl': 'SL', 'status': 'Status'},
    'add': {},
    'edit': {},
  };
  static Map<String, dynamic> back_execute = {
    'list': {'id': 'Id', 'name': 'Name', 'date_from': 'From', 'date_to': 'To', 'status': 'Status', 'count': 'Count'},
    'add': {'name': 'Name', 'date_from': 'From', 'date_to': 'To', 'count': 'Count', 'description': 'Description'},
    'edit': {'name': 'Name', 'date_from': 'From', 'date_to': 'To', 'count': 'Count', 'description': 'Description'},
  };
  static Map<String, dynamic> back_order = {
    'list': {'id': 'Id', 'count': 'Count', 'father_id': 'Father', 'date_open': 'Open', 'price_open': 'Open', 'date_close': 'Close', 'price_close': 'Close', 'profit': 'Profit', 'status': 'Status', 'symbol': 'Symbol', 'action': 'Action', 'amount': 'Amount'},
    'add': {},
    'edit': {},
  };
  static Map<String, dynamic> back_order_detaile = {
    'list': {'count': 'Count', 'date_from': 'From', 'date_to': 'To', 'all_count': 'Count', 'profit': 'Profit', 'open_count': 'Open', 'close_count': 'Close', 'profit_min': 'Profit(min)', 'profit_max': 'Profit(max)', 'loss_min': 'Loss(min)', 'loss_max': 'Loss(max)'},
    'add': {},
    'edit': {},
  };
}
