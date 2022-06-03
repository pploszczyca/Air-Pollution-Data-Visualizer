import 'package:adpv_frontend/EndpointList/EnpointList.dart';
import 'package:adpv_frontend/Repository/EndpointRepository.dart';
import 'package:flutter/material.dart';

import 'App.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final EndpointRepository endpointRepository = EndpointRepository.mock();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'APDV Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: App(endpointRepository: endpointRepository),
    );
  }
}
