import 'package:cars_flutter/bloc/loripsum_bloc.dart';
import 'package:cars_flutter/models/car.dart';
import 'package:flutter/material.dart';

class CarScreen extends StatefulWidget {
  Car car;

  CarScreen(this.car);

  @override
  _CarScreenState createState() => _CarScreenState();
}

class _CarScreenState extends State<CarScreen> {
  final _loripsumBloc = LoripsumBloc();

  @override
  void initState() {
    super.initState();
    _loripsumBloc.fetch();
  }

  @override
  void dispose() {
    super.dispose();
    _loripsumBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.car.nome),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.place), onPressed: _onClickMap),
          IconButton(icon: Icon(Icons.videocam), onPressed: _onClickVideo),
          PopupMenuButton<String>(
            onSelected: (value) => _onPopupMenuItemSelected(value),
            itemBuilder: (context) {
              return [
                PopupMenuItem(value: "Edit", child: Text("Edit")),
                PopupMenuItem(value: "Delete", child: Text("Delete")),
                PopupMenuItem(value: "Share", child: Text("Share")),
              ];
            },
          )
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          Image.network(widget.car.urlFoto),
          _header(),
          Divider(),
          _content(),
        ],
      ),
    );
  }

  Row _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 16),
            Text(widget.car.nome, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(widget.car.tipo, style: TextStyle(fontSize: 16)),
          ],
        ),
        Row(
          children: <Widget>[
            IconButton(icon: Icon(Icons.favorite, size: 40, color: Colors.red), onPressed: _onClickFavorite),
            IconButton(icon: Icon(Icons.share, size: 40), onPressed: _onClickShare)
          ],
        ),
      ],
    );
  }

  void _onClickMap() {}

  void _onClickVideo() {}

  _onPopupMenuItemSelected(String value) {
    switch (value) {
      case "Edit":
        print("Edit");
        break;
      case "Delete":
        print("Delete");
        break;
      case "Share":
        print("Share");
        break;
    }
  }

  void _onClickFavorite() {}

  void _onClickShare() {}

  _content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 16),
        Text(widget.car.descricao, style: TextStyle(fontSize: 16)),
        SizedBox(height: 16),
        StreamBuilder(
          stream: _loripsumBloc.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            return Text(snapshot.data, style: TextStyle(fontSize: 16));
          },
        )
      ],
    );
  }
}
