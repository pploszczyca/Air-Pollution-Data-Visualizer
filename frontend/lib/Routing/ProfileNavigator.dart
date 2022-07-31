import 'package:adpv_frontend/Views/ProfileView.dart';
import 'package:flutter/material.dart';

import '../Repository/AbstractEndpointRepository.dart';

class ProfileNavigator extends StatefulWidget {
  final AbstractEndpointRepository endpointRepository;

  const ProfileNavigator({required this.endpointRepository, Key? key})
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
