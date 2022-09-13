import 'package:adpv_frontend/Views/profile_view.dart';
import 'package:flutter/material.dart';

import '../Repository/UserRepository/user_gateway.dart';

class ProfileNavigator extends StatefulWidget {
  final UserGateway userGateway;

  const ProfileNavigator({required this.userGateway, Key? key})
      : super(key: key);

  @override
  State<ProfileNavigator> createState() => _ProfileNavigatorState();
}

class _ProfileNavigatorState extends State<ProfileNavigator> {
  @override
  Widget build(BuildContext context) => Navigator(
        onGenerateRoute: (settings) => MaterialPageRoute<dynamic>(
          builder: (context) => ProfileView(widget.userGateway),
        ),
      );
}
