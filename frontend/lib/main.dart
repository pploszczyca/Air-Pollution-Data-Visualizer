import 'package:adpv_frontend/Repository/MockRepository.dart';
import 'package:adpv_frontend/Repository/RestClient.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'App.dart';


void testRest(){
  RestClient client = RestClient(Dio());
  print(client.getEndpointData(1));
}

Future main() async {
  await loadEnvFile();
  testRest();
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

Future loadEnvFile() async {
  await dotenv.load(fileName: ".env");
}
