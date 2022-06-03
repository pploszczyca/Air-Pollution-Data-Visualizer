import 'package:adpv_frontend/EndpointList/EnpointList.dart';
import 'package:adpv_frontend/Repository/EndpointRepository.dart';
import 'package:adpv_frontend/Routing.dart';
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
        late Widget page;
        if(settings.name == compareEndpointsRoute){
          page =  EndpointList(endpointRepository: widget.endpointRepository,);
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
