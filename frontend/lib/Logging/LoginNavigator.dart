import 'package:adpv_frontend/EndpointList/EnpointList.dart';
import 'package:adpv_frontend/Routing.dart';
import 'package:flutter/material.dart';

import '../Repository/AbstractEndpointRepository.dart';
import 'LoginView.dart';

class LoginNavigator extends StatefulWidget {

  const LoginNavigator({Key? key})
      : super(key: key);

  @override
  State<LoginNavigator> createState() => _LoginNavigatorState();
}

class _LoginNavigatorState extends State<LoginNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        late Widget page;
        page = const LoginView();

        return MaterialPageRoute<dynamic>(builder: (context) {
          return page;
        });
      },
    );
  }
}
