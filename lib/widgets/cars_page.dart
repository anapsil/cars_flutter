import 'package:cars_flutter/bloc/cars_model.dart';
import 'package:cars_flutter/models/car.dart';
import 'package:cars_flutter/widgets/cars_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CarsPage extends StatefulWidget {
  final String type;

  CarsPage(this.type);

  @override
  _CarsPageState createState() => _CarsPageState();
}

class _CarsPageState extends State<CarsPage> with AutomaticKeepAliveClientMixin<CarsPage> {
  final _model = CarsModel();

  @override
  void initState() {
    super.initState();
    _model.loadCars(widget.type);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Observer(
      builder: (_) {
        List<Car> cars = _model.cars;
        if (_model.error != null) {
          return Center(
            child: Text(
              "Não foi possível buscar os carros",
              style: TextStyle(
                color: Colors.red,
                fontSize: 22,
              ),
            ),
          );
        }
        if (cars == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return CarsListView(cars);
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
