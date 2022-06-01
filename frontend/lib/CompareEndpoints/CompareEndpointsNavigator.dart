import 'package:adpv_frontend/CompareEndpoints/CompareChartsView.dart';
import 'package:adpv_frontend/EndpointList/EndpointView/EndpointView.dart';
import 'package:adpv_frontend/EndpointList/EnpointList.dart';
import 'package:adpv_frontend/Repository/EndpointRepository.dart';
import 'package:flutter/material.dart';

class CompareEndpointsNavigator extends StatefulWidget {
  EndpointRepository endpointRepository;

  CompareEndpointsNavigator({Key? key, required this.endpointRepository})
      : super(key: key);

  @override
  State<CompareEndpointsNavigator> createState() => _CompareEndpointsNavigatorState();
}

class _CompareEndpointsNavigatorState extends State<CompareEndpointsNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
                return CompareChartsView();
            },
        );
      },
    );
  }
}
