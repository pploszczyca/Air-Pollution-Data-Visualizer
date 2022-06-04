import 'package:adpv_frontend/EndpointList/EndpointView/EndpointView.dart';
import 'package:adpv_frontend/EndpointList/EnpointList.dart';
import 'package:adpv_frontend/Repository/MockRepository.dart';
import 'package:adpv_frontend/Routing.dart';
import 'package:flutter/material.dart';



class EndpointNavigator extends StatefulWidget {
  EndpointRepository endpointRepository;

  EndpointNavigator({Key? key, required this.endpointRepository})
      : super(key: key);

  @override
  State<EndpointNavigator> createState() => _EndpointNavigatorState();
}

class _EndpointNavigatorState extends State<EndpointNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        late Widget page;
        if(settings.name == endpointListRoute){
          print(settings.name);
          page =  EndpointList(endpointRepository: widget.endpointRepository,);
        }else if(settings.name!.startsWith(endpointViewRoute)){
          var endpointName = settings.name!.split("/")[2];

          page = EndpointView(endpoint: widget.endpointRepository.getEndpoint(endpointName));
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
