import 'dart:ui';

import 'package:adpv_frontend/Repository/EndpointRepository/endpoint_gateway.dart';
import 'package:adpv_frontend/Repository/UserRepository/user_gateway.dart';
import 'package:adpv_frontend/Widgets/common_widgets.dart';
import 'package:adpv_frontend/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/assertions.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'Views/Logging/login_view.dart';

Future main() async {
  await loadEnvFile();
  FlutterError.onError = (error) {
    runApp(MyApp());
  };
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final UserGateway userGateway = UserGateway();

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'APDV Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
          future: userGateway.isMemoryTokenValid(),
          builder: (context, snapshot) {

            try {
              if (snapshot.hasData == null) {
                return loadingInCenter();
              }
              if (snapshot.data == true) {
                return App(
                  userGateway: userGateway,
                  endpointGateway: EndpointGateway(userGateway),
                );
              } else {
                return LoginView(
                  userGateway: userGateway,
                );
              }
            } catch (error) {
              Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
              return LoginView(
                userGateway: userGateway,
              );
            }
          },
        ),
      );
}

Future loadEnvFile() async {
  await dotenv.load(fileName: ".env");
}
