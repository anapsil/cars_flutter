import 'package:cars_flutter/models/user.dart';
import 'package:cars_flutter/widgets/drawer_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  User currentUser;

  HomeScreen(this.currentUser);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
      ),
      body: _body(),
      drawer: DrawerList(currentUser),
    );
  }

  _body() {
    return Container(
      child: Center(
        child: Text(currentUser.nome),
      ),
    );
  }
}
