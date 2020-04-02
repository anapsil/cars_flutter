import 'package:cars_flutter/models/car.dart';
import 'package:cars_flutter/network/cars_api.dart';
import 'package:mobx/mobx.dart';

part 'cars_model.g.dart';

class CarsModel = CarsModelBase with _$CarsModel;

abstract class CarsModelBase with Store {
  @observable
  List<Car> cars;

  @observable
  Exception error;

  @action
  loadCars(String type) async {
    try {
      cars = await CarsApi.getCars(type);
    } catch (e) {
      error = e;
    }
  }
}
