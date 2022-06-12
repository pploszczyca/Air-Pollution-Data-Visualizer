import 'package:adpv_frontend/Profile/ProfileView.dart';
import 'package:adpv_frontend/Repository/MockRepository.dart';
import 'package:flutter/material.dart';

class ProfileNavigator extends StatefulWidget {
  final EndpointRepository endpointRepository;

  const ProfileNavigator({Key? key, required this.endpointRepository})
      : super(key: key);

  @override
  State<ProfileNavigator> createState() => _ProfileNavigatorState();
}

class _ProfileNavigatorState extends State<ProfileNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        late Widget page;
        page = const ProfileView();

        return MaterialPageRoute<dynamic>(
            builder: (context){
              return page;
            }
        );
      },
    );
  }
}
