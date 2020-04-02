import 'package:cars_flutter/bloc/simple_bloc.dart';
import 'package:cars_flutter/models/car.dart';
import 'package:cars_flutter/network/cars_api.dart';

class CarsBloc extends SimpleBloc<List<Car>> {
  loadCars(String type) async {
    try {
      List<Car> cars = await CarsApi.getCars(type);
      add(cars);
    } catch (e) {
      addError(e);
    }
  }
}
