//--------------------------------------------------------------------------------- location
// lib/tools/api.dart

//--------------------------------------------------------------------------------- Description
// This is api module for working with api on the server

//--------------------------------------------------------------------------------- Import
import 'package:http/http.dart' as http;
import 'dart:convert';

//--------------------------------------------------------------------------------- MyApi
class MyApi {
  //--------------------------------[Post]
  post(String url, data) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    return response.body;
  }

  //--------------------------------[Get]
  get(String url) async {
    final response = await http.get(Uri.parse(url));
    return response.body;
  }

  //--------------------------------[Put]
  put(String url, data) async {
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    return response.body;
  }

  //--------------------------------[Del]
  del(String url) async {
    final response = await http.delete(Uri.parse(url));
    return response.body;
  }
}
