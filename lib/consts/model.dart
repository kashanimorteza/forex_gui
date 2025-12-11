//--------------------------------------------------------------------------------- Location
// lib/consts/model.dart

//--------------------------------------------------------------------------------- Description
// Model const are here

//--------------------------------------------------------------------------------- Import

//--------------------------------------------------------------------------------- General
enum const_model_mode { view, edit }

enum const_model_list { dashboard, user, log, config, xray, service_v2ray, service_v2ray_server, service_v2ray_inbound, service_v2ray_service, service_v2ray_plan, service_v2ray_group, group, service, network, way, server, route, domain, alarm, display, certificate, telegram_instance }

class models_title {
  static const String dashboard = 'Dashboard';
  static const String user = 'User';
  static const String log = 'Log';
  static const String config = 'Config';
  static const String service_v2ray = 'V2ray';
  static const String service_v2ray_server = 'Server';
  static const String service_v2ray_inbound = 'Inbound';
  static const String service_v2ray_service = 'Service';
  static const String service_v2ray_plan = 'Plan';
  static const String service_v2ray_group = 'Group';
  static const String group = 'Group';
  static const String service = 'Service';
  static const String network = 'Networks';
  static const String way = 'Ways';
  static const String server = 'Servers';
  static const String route = 'Routes';
  static const String domain = 'Domains';
  static const String certificate = 'Certificates';
  static const String alarm = 'Alarms';
  static const String display = 'Displays';
  static const String xray_server = 'Server';
  static const String xray_inbound = 'Inbound';
  static const String plan_v2ray = 'V2ray Plan';
  static const String telegram_instance = 'Telegram';
}

class models_api {
  static const String dashboard = 'dashboard';
  static const String user = 'user';
  static const String user_card = 'user_card';
  static const String user_payment = 'user_payment';
  static const String user_xray = 'user_xray';
  static const String log = 'log';
  static const String config = 'config';
  static const String service_v2ray_server = 'xray_server';
  static const String service_v2ray_inbound = 'xray_inbound';
  static const String service_v2ray_service = 'xray_service';
  static const String service_v2ray_plan = 'xray_plan';
  static const String service_v2ray_group = 'xray_group';
  static const String group = 'group';
  static const String service = 'service';
  static const String network = 'network';
  static const String way = 'way';
  static const String server = 'server';
  static const String route = 'route_group';
  static const String domain = 'domain';
  static const String certificate = 'certificate';
  static const String alarm = 'alarm_group';
  static const String display = 'display_group';
  static const String telegram_instance = 'telegram';
}

class models_fileds {
  static Map<String, dynamic> config = {
    'list': {},
    'add': {},
    'edit': {
      'name': 'Name',
      'panel': 'Panel',
      'email': 'Email',
      'web': 'Web',
      'timeZone': 'Time Zone',
      'warp_port': 'Warp Port',
      'webapi_port': 'Webapi Port',
      'log_lines': 'Log Lines',
      'cron_daily_time': 'Cron Daily Time',
      'cron_hourly_period': 'Cron Hourly Period',
      'cron_minly_period': 'Cron Minly Period',
      'cron_delay': 'Cron Delay',
      'config_number': 'Config Number',
      'free_group_id': 'Free Group ID',
      'current_user_id': 'Current User ID',
      'base_group_id': 'Base Group ID',
      'end_group_id': 'End Group ID',
      'current_group_id': 'Current Group ID',
      'bank_account_name': 'Bank Account Name',
      'bank_account_card': 'Bank Account Card',
      'traffic_today': 'Traffic Today',
      'traffic_yesterday': 'Traffic Yesterday',
      'traffic_month': 'Traffic Month',
      'log_folder': 'Log Folder',
      'backup_folder': 'Backup Folder',
      'link_config_service_v2ray': 'Link V2ray',
      'certificate_dir': 'Certificate Directory',
      'debug': 'Debug',
      'log': 'Log',
      'verbose': 'Verbose'
    }
  };
  static Map<String, dynamic> service_v2ray_server = {
    'list': {'version': 'Version', 'config_url': 'Config', 'api_host': 'Host', 'api_port': 'Port'},
    'add': {'version': 'Version', 'config_url': 'Config', 'api_host': 'Host', 'api_port': 'Port'},
    'edit': {'version': 'Version', 'config_url': 'Config', 'api_host': 'Host', 'api_port': 'Port'},
  };
  static Map<String, dynamic> service_v2ray_inbound = {
    'list': {'id': 'Id', 'name': 'Name', 'port': 'Port', 'transport': 'TRA', 'protocol': 'PRO', 'tls': 'TLS', 'enable': 'Enable'},
    'add': {'name': 'Name', 'path': 'Path', 'port': 'Port', 'tls': 'TLS', 'enable': 'Enable'},
    'edit': {'name': 'Name', 'path': 'Path', 'port': 'Port', 'tls': 'TLS', 'enable': 'Enable'}
  };
  static Map<String, dynamic> service_v2ray_service = {
    'list': {
      'id': 'Id',
      'name': 'Name',
      'pre': 'Pre',
      'plan_id': 'Plan Id',
      'group_id': 'Group Id',
      'uuid': 'UUID',
      'period_used': 'Period used',
      'validity_used': 'Validity used',
      'bandwith_used': 'Bandwith used',
      'first': 'First',
      'last_connection': 'Last Connection',
      'start': 'Start',
      'after_start': 'After Start',
      'period_fix': 'Period Fix',
      'reserve_renew_validity': 'Reserve Validity',
      'reserve_renew_bandwith': 'Reserve Bandwith',
      'online': 'Online',
      'enable': 'Enable'
    },
    'add': {
      'id': 'Id',
      'name': 'Name',
      'pre': 'Pre',
      'plan_id': 'Plan Id',
      'group_id': 'Group Id',
      'uuid': 'UUID',
      'period_used': 'Period used',
      'validity_used': 'Validity used',
      'bandwith_used': 'Bandwith used',
      'first': 'First',
      'last_connection': 'Last Connection',
      'start': 'Start',
      'after_start': 'After Start',
      'period_fix': 'Period Fix',
      'reserve_renew_validity': 'Reserve Validity',
      'reserve_renew_bandwith': 'Reserve Bandwith',
      'online': 'Online',
      'enable': 'Enable'
    },
    'edit': {
      'id': 'Id',
      'name': 'Name',
      'pre': 'Pre',
      'plan_id': 'Plan Id',
      'group_id': 'Group Id',
      'uuid': 'UUID',
      'period_used': 'Period used',
      'validity_used': 'Validity used',
      'bandwith_used': 'Bandwith used',
      'today_used': 'Today used',
      'first': 'First',
      'last_connection': 'Last Connection',
      'start': 'Start',
      'after_start': 'After Start',
      'period_fix': 'Period Fix',
      'reserve_renew_validity': 'Reserve Validity',
      'reserve_renew_bandwith': 'Reserve Bandwith',
      'online': 'Online',
      'enable': 'Enable'
    },
  };
  static Map<String, dynamic> service_xray_plan = {
    'list': {'id': 'Id', 'name': 'Name', 'enable': 'Enable', 'period_limit': 'PL', 'validity_limit': 'VL', 'bandwith_limit': 'BL', 'price': 'Price'},
    'add': {'name': 'Name', 'description': 'Description', 'enable': 'Enable', 'period_limit': 'PL', 'validity_limit': 'VL', 'bandwith_limit': 'BL', 'price': 'Price'},
    'edit': {'name': 'Name', 'description': 'Description', 'enable': 'Enable', 'period_limit': 'PL', 'Validity_limit': 'VL', 'bandwith_limit': 'BL', 'price': 'Price'},
  };
  static Map<String, dynamic> user = {
    'list': {},
    'add': {'tg_id': 'Telegram', 'username': 'Username', 'name': 'Name'},
    'edit': {
      'father_id': 'Father ID',
      'username': 'Username',
      'name': 'Name',
      'email': 'Email',
      'phone': 'Phone',
      'register_date': 'Register Date',
      'balance': 'Balance',
      'credit': 'Credit',
      'auth_username': 'Auth Username',
      'auth_password': 'Auth Password',
      'auth_key': 'Auth Key',
      'today_used': 'Today used',
      'last_connection': 'Last connection',
      'online': 'Online',
      'tg_id': 'Telegram ID',
      'tg_sum_of_message': 'Telegram Message Count',
      'tg_join_robot': 'Telegram Join Robot',
      'tg_join_channel': 'Telegram Join Channel',
      'os_iphone': 'iPhone',
      'os_android': 'Android',
      'os_windows': 'Windows',
      'os_linux': 'Linux',
      'os_mac': 'Mac',
      'display': 'Display',
      'trusted': 'Trusted'
    },
  };
  static Map<String, dynamic> user_card = {
    'list': {'card': 'Card'},
    'add': {'card': 'Card'},
    'edit': {'card': 'Card'},
  };
  static Map<String, dynamic> user_payment = {
    'add': {'amount': 'Amount', 'data': 'Data'},
    'edit': {},
    'list': {'date': 'Date', 'amount': 'Amount', 'type': 'Type', 'data': 'Data', 'balance_befor': 'BB', 'balance_after': 'BA'},
  };
  static Map<String, dynamic> group = {
    'list': {'id': 'Id', 'name': 'Name', 'pre': 'Pre', 'description': 'Description', 'enable': 'Enable'},
    'add': {'name': 'Name', 'pre': 'Pre', 'description': 'Description', 'enable': 'Enable'},
    'edit': {'name': 'Name', 'pre': 'Pre', 'description': 'Description', 'enable': 'Enable'},
  };
  static Map<String, dynamic> service = {
    'list': {'id': 'Id', 'name': 'Name', 'pre': 'Prefix', 'description': 'Description', 'enable': 'Enable'},
    'add': {'name': 'Name', 'pre': 'Prefix', 'description': 'Description', 'enable': 'Enable'},
    'edit': {'name': 'Name', 'pre': 'Prefix', 'description': 'Description', 'enable': 'Enable'},
  };
  static Map<String, dynamic> domain = {
    'list': {'id': 'Id', 'name': 'Name', 'address': 'Address', 'description': 'Description', 'enable': 'Enable'},
    'add': {'name': 'Name', 'address': 'Address', 'zoneid': 'Zone-Id', 'accountid': 'Account-Id', 'token': 'Token', 'description': 'Description', 'enable': 'Enable'},
    'edit': {'name': 'Name', 'address': 'Address', 'zoneid': 'Zone-Id', 'accountid': 'Account-Id', 'token': 'Token', 'description': 'Description', 'enable': 'Enable'},
  };
  static Map<String, dynamic> certificate = {
    'list': {'id': 'Id', 'name': 'Name', 'sub': 'Sub', 'enable': 'Enable'},
    'add': {'name': 'Name', 'sub': 'Sub', 'description': 'Description', 'enable': 'Enable'},
    'edit': {'name': 'Name', 'sub': 'Sub', 'description': 'Description', 'enable': 'Enable'},
  };
  static Map<String, dynamic> network = {
    'list': {'id': 'Id', 'name': 'Name', 'pre': 'Prefix', 'enable': 'Enable'},
    'add': {'name': 'Name', 'pre': 'Prefix', 'description': 'Description', 'enable': 'Enable'},
    'edit': {'name': 'Name', 'pre': 'Prefix', 'description': 'Description', 'enable': 'Enable'},
  };
  static Map<String, dynamic> way = {
    'list': {'id': 'Id', 'name': 'Name', 'pre': 'Prefix', 'enable': 'Enable'},
    'add': {'name': 'Name', 'pre': 'Prefix', 'description': 'Description', 'enable': 'Enable'},
    'edit': {'name': 'Name', 'pre': 'Prefix', 'description': 'Description', 'enable': 'Enable'},
  };
  static Map<String, dynamic> alarm = {
    'list': {'id': 'Id', 'name': 'Name', 'enable': 'Enable'},
    'add': {'name': 'Name', 'description': 'Description', 'enable': 'Enable'},
    'edit': {'name': 'Name', 'description': 'Description', 'enable': 'Enable'},
  };
  static Map<String, dynamic> display = {
    'list': {'id': 'Id', 'name': 'Name', 'enable': 'Enable'},
    'add': {'name': 'Name', 'description': 'Description', 'enable': 'Enable'},
    'edit': {'name': 'Name', 'description': 'Description', 'enable': 'Enable'},
  };
  static Map<String, dynamic> user_account = {
    'list': {},
    'add': {},
    'edit': {'father_id': 'Father Id', 'username': 'Username', 'name': 'Name', 'email': 'Email', 'phone': 'Phone', 'balance': 'Balance', 'credit': 'Credit', 'register_date': 'Register Date', 'display': 'Display', 'trusted': 'Trust'},
  };
  static Map<String, dynamic> user_xray = {
    'list': {'id': 'Id', 'name': 'Name'},
    'add': {'name': 'Name'},
    'edit': {'name': 'Name', 'uuid': 'UUID', 'period_used': 'Period used', 'validity_used': 'Validity used', 'bandwith_used': 'Bandwith used', 'first': 'First', 'start': 'Start', 'last_connection': 'Last connection', 'after_start': 'After Start', 'period_fix': 'Period Fix', 'reserve_renew_validity': 'Reserve Validity', 'reserve_renew_bandwith': 'Reserve Bandwith'},
  };
  static Map<String, dynamic> wallet = {
    'list': {'balance': 'Balance', 'credit': 'Credit'},
    'add': {'balance': 'Balance', 'credit': 'Credit'},
    'edit': {'balance': 'Balance', 'credit': 'Credit'},
  };
  static Map<String, dynamic> server = {
    'list': {'id': 'Id', 'name': 'Name', 'ipv4': 'IPV4', 'description': 'Description', 'enable': 'Enable'},
    'add': {'name': 'Name', 'ipv4': 'IPV4', 'ipv6': 'IPV6', 'description': 'Description', 'enable': 'Enable'},
    'edit': {'name': 'Name', 'ipv4': 'IPV4', 'ipv6': 'IPV6', 'description': 'Description', 'enable': 'Enable'},
  };
  static Map<String, dynamic> route = {
    'list': {'id': 'Id', 'name': 'Name', 'enable': 'Enable', 'type': 'Type'},
    'add': {'name': 'Name', 'title': 'Title', 'description': 'Description', 'enable': 'Enable', 'type': 'Type'},
    'edit': {'name': 'Name', 'title': 'Title', 'description': 'Description', 'enable': 'Enable', 'type': 'Type'}
  };
  static Map<String, dynamic> telegram_instance = {
    'add': {'name': 'Name', 'robot_username': 'Username', 'support_username': 'Support', 'support_channel': 'Channel', 'bot_api_id': 'Api', 'bot_api_hash': 'Hash', 'bot_token': 'Tokey', 'link': 'Link', 'bot_delay': 'Delay', 'send_support': 'Support send', 'enable': 'Enable'},
    'edit': {'name': 'Name', 'robot_username': 'Username', 'support_username': 'Support', 'support_channel': 'Channel', 'bot_api_id': 'Api', 'bot_api_hash': 'Hash', 'bot_token': 'Tokey', 'link': 'Link', 'bot_delay': 'Delay', 'send_support': 'Support send', 'enable': 'Enable'},
    'list': {'id': 'Id', 'name': 'Name', 'robot_username': 'Username', 'send_support': 'Support send', 'enable': 'Enable'},
  };
}
