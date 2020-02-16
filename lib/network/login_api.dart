import 'dart:convert';

import 'package:cars_flutter/models/api_response.dart';
import 'package:cars_flutter/models/user.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  static Future<ApiResponse<User>> login(String login, String senha) async {
    try {
      var url = "https://carros-springboot.herokuapp.com/api/v2/login";

      Map<String, String> headers = {"Content-Type": "application/json"};

      Map params = {
        "username": login,
        "password": senha,
      };

      var response = await http.post(url, body: json.encode(params), headers: headers);
      print('Response body: ${response.body}');

      Map mapResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final user = User.fromJson(mapResponse);
        return ApiResponse.success(user);
      }
      return ApiResponse.error(mapResponse["error"]);
    } catch (error, exception) {
      print("Erro no login >> $error >> $exception");
      return ApiResponse.error("Não foi possível fazer o login.");
    }
  }
}
