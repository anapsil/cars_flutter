import 'dart:async';

import 'package:cars_flutter/bloc/simple_bloc.dart';
import 'package:cars_flutter/models/api_response.dart';
import 'package:cars_flutter/models/user.dart';
import 'package:cars_flutter/network/login_api.dart';

class LoginBloc extends SimpleBloc<bool> {
  Future<ApiResponse<User>> login(String login, String password) async {
    add(true);
    final ApiResponse response = await LoginApi.login(login, password);
    add(false);

    return response;
  }
}
