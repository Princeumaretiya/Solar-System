

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

import '../models/planets_model.dart';


class planet_Provider extends ChangeNotifier {
  List<PlanetInfo> allPlanets = [];

  planet_Provider() {
    loadJSON();
    notifyListeners();
  }

  void loadJSON() async {
    String res = await rootBundle.loadString('assets/json/planet.json');

    List allPlanet = jsonDecode(res);

    allPlanets = allPlanet.map((e) => PlanetInfo.fromMap(planet: e)).toList();

    notifyListeners();
  }
}
