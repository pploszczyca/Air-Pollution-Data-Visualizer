import 'package:flutter/material.dart';

import '../Common/Routing.dart';
import '../Repository/AbstractEndpointRepository.dart';
import '../Views/EnpointListView.dart';

class CompareEndpointsNavigator extends StatefulWidget {
  final AbstractEndpointRepository repository;

  const CompareEndpointsNavigator({required this.repository, Key? key})
      : super(key: key);

  @override
  State<CompareEndpointsNavigator> createState() => _CompareEndpointsNavigatorState();
}

class _CompareEndpointsNavigatorState extends State<CompareEndpointsNavigator> {
  @override
  Widget build(BuildContext context) => Navigator(
      onGenerateRoute: (RouteSettings settings) {
        late Widget page;
        if(settings.name == compareEndpointsRoute){
          page =  EndpointListView(repository: widget.repository,);
        }
        return MaterialPageRoute<dynamic>(
            builder: (context)=> page
        );
      },
    );
}
