import 'package:adpv_frontend/Repository/AdminRepository/AdminGateway.dart';
import 'package:adpv_frontend/Repository/EndpointRepository/EndpointGateway.dart';
import 'package:adpv_frontend/Repository/UserRepository/UserGateway.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'App.dart';

Future main() async {
  await loadEnvFile();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final UserGateway userGateway = UserGateway();
  final EndpointGateway endpointGateway = EndpointGateway();
  final AdminGateway adminGateway = AdminGateway();

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'APDV Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: App(
          endpointGateway: endpointGateway,
          userGateway: userGateway,
          adminGateway: adminGateway,
        ),
      );
}

Future loadEnvFile() async {
  await dotenv.load(fileName: ".env");
}
