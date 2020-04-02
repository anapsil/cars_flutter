import 'package:cars_flutter/models/car.dart';
import 'package:cars_flutter/screens/car_screen.dart';
import 'package:cars_flutter/utils/nav.dart';
import 'package:flutter/material.dart';

class CarsListView extends StatelessWidget {
  final List<Car> cars;

  CarsListView(this.cars);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
          itemCount: cars != null ? cars.length : 0,
          itemBuilder: (context, index) {
            Car car = cars[index];

            return Card(
              color: Colors.grey[100],
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(child: Image.network(car.urlFoto ?? "http://www.livroandroid.com.br/livro/carros/classicos/Camaro_SS.png", width: 250)),
                    Text(car.nome ?? "", maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 20)),
                    Text(car.descricao ?? "", style: TextStyle(fontSize: 16)),
                    ButtonBar(
                      children: <Widget>[
                        FlatButton(child: const Text('DETALHES'), onPressed: () => _onClickCar(context, car)),
                        FlatButton(child: const Text('SHARE'), onPressed: () {}),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  _onClickCar(BuildContext context, Car car) {
    push(context, CarScreen(car));
  }
}
