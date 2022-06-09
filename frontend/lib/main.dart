import 'package:adpv_frontend/Repository/MockRepository.dart';
import 'package:adpv_frontend/Repository/RestClient.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'App.dart';
import 'Providers/CompareEndpointsModel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final EndpointRepository endpointRepository = EndpointRepository.mock();
  final RestClient restClient = RestClient(Dio());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'APDV Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: App(
          endpointRepository: endpointRepository,
          repository: restClient,
        ),
    );
  }
}
