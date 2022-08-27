import 'dart:async';

import 'package:animal_app/MM/MMPlaces.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:location/location.dart';

import 'MM/MM.dart';
import 'MM/MMWidget.dart';

import 'MMap/MGoogleMap.dart' ;

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('地圖'),
      ),
      body: MyMapPage(),
    );
  }
}
class MyMapPage extends StatefulWidget {
  const MyMapPage({Key? key}) : super(key: key);

  @override
  State<MyMapPage> createState() => _MyMapPageState();
}

class _MyMapPageState extends State<MyMapPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(children: [
        MGoogleMap(),

      ],),
    );
  }
}