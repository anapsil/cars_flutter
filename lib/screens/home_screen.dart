import 'package:cars_flutter/models/user.dart';
import 'package:cars_flutter/network/cars_api.dart';
import 'package:cars_flutter/utils/prefs.dart';
import 'package:cars_flutter/widgets/cars_listview.dart';
import 'package:cars_flutter/widgets/drawer_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin<HomeScreen> {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _initTabs();
  }

  _initTabs() async {
    int tabIdx = await Prefs.getInt("tabIdx");
    _tabController = TabController(length: 3, vsync: this);

    setState(() {
      _tabController.index = tabIdx;
    });

    _tabController.addListener(() {
      Prefs.setInt("tabIdx", _tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
        bottom: _tabController == null
            ? null
            : TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: "Clássicos"),
            Tab(text: "Esportivos"),
            Tab(text: "Luxo"),
          ],
        ),
      ),
      body: _tabController == null
          ? Center(
        child: CircularProgressIndicator(),
      )
          : TabBarView(
        controller: _tabController,
        children: [
          CarsListView(CarType.classicos),
          CarsListView(CarType.esportivos),
          CarsListView(CarType.luxo),
        ],
      ),
      drawer: FutureBuilder(
        future: User.get(),
        builder: (context, snapshot) {
          User user = snapshot.data;
          return user != null ? DrawerList(user) : Container();
        },
      ),
    );
  }
}
