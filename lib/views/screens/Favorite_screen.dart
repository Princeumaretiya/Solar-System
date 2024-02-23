import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../controller/SharePrefence.dart';
import 'Detail_screen.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    readJson();
    // TODO: implement initState
    valueFunction();
    super.initState();
  }

  List<String>? valuex;

  valueFunction() {
    SharedPref.getListString().then((value) {
      print(value);
      setState(() {
        valuex = value;
        print(valuex);
      });
    });
  }

  List _items = [];
  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/images/planet.json');
    final data = await json.decode(response);
    setState(() {
      _items = data;
    });
  }

  searchText(txtvalue) {
    for (int i = 0; i < _items.length; i++) {
      if (_items[i]['name'] == txtvalue) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Detail_Page(),
            ));
      } else {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        iconTheme: IconThemeData(size: 30,color: Colors.black),
        title: Text(
          "Favourite Planets",
          style: TextStyle(fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          "Favourite Planets Not Added!!!",
          style: TextStyle(color: Colors.black,fontSize: 15),
        ),
      ),
    );
  }
}
