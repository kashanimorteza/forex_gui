//--------------------------------------------------------------------------------- location
// lib/models/model_log.dart

//--------------------------------------------------------------------------------- Description
// This is model for log

//--------------------------------------------------------------------------------- Import
import 'dart:convert';
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/consts/model.dart';
import 'package:mkpanel_gui/tools/api.dart';

//--------------------------------------------------------------------------------- Global
typedef modelType = model_log;
String api_route = models_api.log;

//--------------------------------------------------------------------------------- Model
class model_log {
  //--------------------------------[items]
  items() async {
    MyApi api_mdl = new MyApi();
    var data1 = json.decode(await api_mdl.get('${const_api_url}/${api_route}/items'));
    List<dynamic> data2 = data1['data'];
    return data2;
  }

  //--------------------------------[item]
  item(String name) async {
    MyApi api_mdl = new MyApi();
    var data1 = json.decode(await api_mdl.get('${const_api_url}/${api_route}/item?name=${name}'));
    List<dynamic> data2 = data1['data'];
    return data2;
  }

  //--------------------------------[clear]
  clear(String name) async {
    MyApi api_mdl = new MyApi();
    var result = json.decode(await api_mdl.get('${const_api_url}/${api_route}/clear?name=${name}'));
    return result;
  }

  //--------------------------------[truncate]
  truncate() async {
    MyApi api_mdl = new MyApi();
    var result = json.decode(await api_mdl.get('${const_api_url}/${api_route}/clear'));
    return result;
  }
}
