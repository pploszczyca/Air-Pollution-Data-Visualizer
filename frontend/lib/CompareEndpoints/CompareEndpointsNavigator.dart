import 'package:adpv_frontend/EndpointList/EnpointList.dart';
import 'package:adpv_frontend/Routing.dart';
import 'package:flutter/material.dart';

import '../Repository/AbstractEndpointRepository.dart';

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
          page =  EndpointList(repository: widget.repository,);
        }
        return MaterialPageRoute<dynamic>(
            builder: (context)=> page
        );
      },
    );
}
