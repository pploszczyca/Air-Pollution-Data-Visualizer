import 'package:adpv_frontend/CompareEndpoints/CompareEndpointsView.dart';
import 'package:adpv_frontend/EndpointList/EndpointNavigator.dart';
import 'package:adpv_frontend/EndpointList/EnpointList.dart';
import 'package:adpv_frontend/Profile/ProfileView.dart';
import 'package:adpv_frontend/Repository/EndpointRepository.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  EndpointRepository endpointRepository;

  App({Key? key, required this.endpointRepository}) : super(key: key);


  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: <Widget>[
            EndpointNavigator(endpointRepository: widget.endpointRepository),
            CompareChartsView(),
            ProfileView(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            _buildNavigationItem("Endpoint List"),
            _buildNavigationItem("Compare Endpoints"),
            _buildNavigationItem("Profile"),
          ],
          onTap: (index) => setState(() {
            _selectedIndex = index;
          }),
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.pink,
        ));
  }

  BottomNavigationBarItem _buildNavigationItem(String stringLabel) {
    return BottomNavigationBarItem(
      icon: const Icon(Icons.layers),
      label: stringLabel,
    );
  }
}
