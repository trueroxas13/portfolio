import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanderlist/model/country.dart';

class CountriesNotifier extends Notifier<List<Country>>{
  @override
  List<Country> build() {
    initialize();
    return [];
  }
  
  void initialize() async{
    var data = await rootBundle.loadString('assets/data/countries.json');

    var countriesMap = jsonDecode(data);

    List<Country> countries = [];
    for(var x in countriesMap){
      countries.add(Country.fromJson(x));
    }
    state = countries;
  }
}

final countriesNotifierProvider = NotifierProvider<CountriesNotifier, List<Country>>(() => CountriesNotifier(),);