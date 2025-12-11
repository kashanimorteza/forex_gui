import 'dart:convert';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/tools/api.dart';

//--------------------------------------------------------------------------------- Global

//--------------------------------------------------------------------------------- Model
class model_admin {
  api(type, [int id = 0]) async {
    MyApi api_mdl = new MyApi();
    switch (type) {
      case 'cron_daily':
        return json.decode(await api_mdl.get('${const_api_url}/admin/cron_daily'));
      case 'cron_hourly':
        return json.decode(await api_mdl.get('${const_api_url}/admin/cron_hourly'));
      case 'cron_minly':
        return json.decode(await api_mdl.get('${const_api_url}/admin/cron_minly'));
    }
  }
}
