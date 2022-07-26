import 'package:flutter/material.dart';

import '../Common/Routing.dart';
import '../Repository/AbstractEndpointRepository.dart';
import '../Views/EndpointView.dart';
import '../Views/EnpointListView.dart';

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
            page = EndpointListView(
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
