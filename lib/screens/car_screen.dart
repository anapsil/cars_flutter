import 'package:cars_flutter/models/car.dart';
import 'package:flutter/material.dart';

class CarScreen extends StatelessWidget {
  Car car;

  CarScreen(this.car);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(car.nome)),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Image.network(car.urlFoto),
    );
  }
}
