import 'package:adpv_frontend/Repository/EndpointRepository/endpoint_gateway.dart';
import 'package:adpv_frontend/Repository/UserRepository/user_gateway.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app.dart';

Future main() async {
  await loadEnvFile();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final UserGateway userGateway = UserGateway();
  final EndpointGateway endpointGateway = EndpointGateway();

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'APDV Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: App(
          endpointGateway: endpointGateway,
          userGateway: userGateway,
        ),
      );
}

Future loadEnvFile() async {
  await dotenv.load(fileName: ".env");
}
