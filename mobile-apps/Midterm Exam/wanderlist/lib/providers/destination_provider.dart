import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanderlist/model/destination.dart';

class DestinationNotifier extends Notifier <List<Destination>>{
  @override
  build() {
    initialize();
    return [];
  }
  
  void initialize() async{
    var data = await rootBundle.loadString('assets/data/bucketlist.json');

    var destMaps = jsonDecode(data);

    List<Destination> destinations = [];

    for (var x in destMaps){
      destinations.add(Destination.fromJson(x));
    }

    state = destinations;
  }

  Destination getDestinationById(String id){
    return state.firstWhere((x) => x.id == id);
  }

  void updateDestination(Destination x){
    state[state.indexOf(state.firstWhere((y) => y.id == x.id))] = x;

    var temp = state;
    state = [];
    state = temp;
  }
}

final destinationNotifierProvider 
  = NotifierProvider<DestinationNotifier, List<Destination>>(() => DestinationNotifier());
