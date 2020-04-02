import 'package:cars_flutter/bloc/simple_bloc.dart';
import 'package:cars_flutter/network/loripsum_api.dart';

class LoripsumBloc extends SimpleBloc<String> {
  static String lorim;

  fetch() async {
    String text = lorim ?? await LoripsumApi.getLoripsum();

    lorim = text;

    add(text);
  }
}
