import 'package:adpv_frontend/Repository/EndpointRepository/endpoint_gateway.dart';
import 'package:flutter/material.dart';

import '../Common/routing.dart';
import '../Views/endpoint_view.dart';
import '../Views/enpoint_list_view.dart';

class EndpointNavigator extends StatefulWidget {
  final EndpointGateway endpointGateway;

  const EndpointNavigator({required this.endpointGateway, Key? key})
      : super(key: key);

  @override
  State<EndpointNavigator> createState() => _EndpointNavigatorState();
}

class _EndpointNavigatorState extends State<EndpointNavigator> {
  @override
  Widget build(BuildContext context) => Navigator(
        onGenerateRoute: (RouteSettings settings) {
          late Widget page;
          if (settings.name == endpointListRoute) {
            page = EndpointListView(
              repository: widget.endpointGateway,
            );
          } else if (settings.name!.startsWith(endpointViewRoute)) {
            final endpointId = settings.name!.split("/")[2];
            page = EndpointView(
              endpointId: int.parse(endpointId),
              endpointGateway: widget.endpointGateway,
            );
          }

          return MaterialPageRoute<dynamic>(builder: (context) => page);
        },
      );
}
