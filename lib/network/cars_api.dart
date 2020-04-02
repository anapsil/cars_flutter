import 'dart:convert' as convert;

import 'package:cars_flutter/models/car.dart';
import 'package:cars_flutter/models/user.dart';
import 'package:http/http.dart' as http;

class CarType {
  static final String classicos = "classicos";
  static final String esportivos = "esportivos";
  static final String luxo = "luxo";
}

class CarsApi {
  static Future<List<Car>> getCars(String type) async {
    final User user = await User.get();
    var url = "https://carros-springboot.herokuapp.com/api/v2/carros/tipo/$type";
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${user.token}",
    };

    print("GET > $url");

    var response = await http.get(url, headers: headers);
    String json = response.body;
    List list = convert.json.decode(json);

    return list.map<Car>((map) => Car.fromJson(map)).toList();
  }
}
