import 'package:adpv_frontend/Repository/EndpointRepository/endpoint_gateway.dart';
import 'package:adpv_frontend/Views/profile_view.dart';
import 'package:flutter/material.dart';

class ProfileNavigator extends StatefulWidget {
  final EndpointGateway endpointGateway;

  const ProfileNavigator({required this.endpointGateway, Key? key})
      : super(key: key);

  @override
  State<ProfileNavigator> createState() => _ProfileNavigatorState();
}

class _ProfileNavigatorState extends State<ProfileNavigator> {
  @override
  Widget build(BuildContext context) => Navigator(
        onGenerateRoute: (settings) {
          late Widget page;
          page = const ProfileView();
          return MaterialPageRoute<dynamic>(builder: (context) => page);
        },
      );
}
