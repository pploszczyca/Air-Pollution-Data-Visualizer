import 'package:adpv_frontend/Repository/EndpointRepository/EndpointGateway.dart';
import 'package:flutter/material.dart';

import '../Common/Routing.dart';
import '../Views/EnpointListView.dart';

class CompareEndpointsNavigator extends StatefulWidget {
  final EndpointGateway endpointGateway;

  const CompareEndpointsNavigator({required this.endpointGateway, Key? key})
      : super(key: key);

  @override
  State<CompareEndpointsNavigator> createState() =>
      _CompareEndpointsNavigatorState();
}

class _CompareEndpointsNavigatorState extends State<CompareEndpointsNavigator> {
  @override
  Widget build(BuildContext context) => Navigator(
        onGenerateRoute: (RouteSettings settings) {
          late Widget page;
          if (settings.name == compareEndpointsRoute) {
            page = EndpointListView(
              repository: widget.endpointGateway,
            );
          }
          return MaterialPageRoute<dynamic>(builder: (context) => page);
        },
      );
}
