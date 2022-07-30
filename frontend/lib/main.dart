import 'package:adpv_frontend/Repository/EndpointRepository/RestEndpointRepository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'App.dart';

Future main() async {
  await loadEnvFile();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final RestEndpointRepository restEndpointRepository =
      RestEndpointRepository(Dio());

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'APDV Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: App(
          repository: restEndpointRepository,
        ),
      );
}

Future loadEnvFile() async {
  await dotenv.load(fileName: ".env");
}
