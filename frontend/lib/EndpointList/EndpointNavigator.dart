import 'package:adpv_frontend/EndpointList/EndpointView/EndpointView.dart';
import 'package:adpv_frontend/EndpointList/EnpointList.dart';
import 'package:adpv_frontend/Routing.dart';
import 'package:flutter/material.dart';

import '../Repository/AbstractEndpointRepository.dart';

class EndpointNavigator extends StatefulWidget {
  final AbstractEndpointRepository repository;

  const EndpointNavigator({required this.repository, Key? key})
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
            page = EndpointList(
              repository: widget.repository,
            );
          } else if (settings.name!.startsWith(endpointViewRoute)) {
            var endpointId = settings.name!.split("/")[2];
            page = EndpointView(
                endpointData: widget.repository
                    .getEndpointData(int.parse(endpointId), null, null));
          }

          return MaterialPageRoute<dynamic>(builder: (context) => page);
        },
      );
}
