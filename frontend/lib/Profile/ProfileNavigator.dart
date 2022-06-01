import 'package:adpv_frontend/CompareEndpoints/CompareEndpointsView.dart';
import 'package:adpv_frontend/EndpointList/EndpointView/EndpointView.dart';
import 'package:adpv_frontend/EndpointList/EnpointList.dart';
import 'package:adpv_frontend/Profile/ProfileView.dart';
import 'package:adpv_frontend/Repository/EndpointRepository.dart';
import 'package:adpv_frontend/Routing.dart';
import 'package:flutter/material.dart';

class ProfileNavigator extends StatefulWidget {
  EndpointRepository endpointRepository;

  ProfileNavigator({Key? key, required this.endpointRepository})
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
        if(settings.name ==profileRoute){
          page = const ProfileView();
        }

        return MaterialPageRoute<dynamic>(
            builder: (context){
              return page;
            }
        );
      },
    );
  }
}
