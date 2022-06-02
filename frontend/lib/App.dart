import 'package:adpv_frontend/Repository/EndpointRepository.dart';
import 'package:flutter/material.dart';

import 'CompareEndpoints/CompareEndpointsView.dart';
import 'EndpointList/EndpointNavigator.dart';
import 'Profile/ProfileView.dart';

class App extends StatefulWidget {
  EndpointRepository endpointRepository;

  App({Key? key, required this.endpointRepository}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  _AppState();

  int _selectedIndex = 0;
  late final List<Widget> _navigationOptions = <Widget>[
    EndpointNavigator(endpointRepository: widget.endpointRepository),
    const CompareChartsView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    
    if (queryData.size.width > 560) {
      return _buildRailNavigationScaffold();
    }
    else {
      return _buildBottomNavigationScaffold();
    }
  }
  
  Scaffold _buildRailNavigationScaffold() {
    Widget _navi = Expanded(
      flex: 1,
      child: NavigationRail(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        labelType: NavigationRailLabelType.selected,
        destinations: [
          _buildRailNavigationItem("Endpoint List"),
          _buildRailNavigationItem("Compare Endpoints"),
          _buildRailNavigationItem("Profile"),
        ],
      ),
    );
    return Scaffold(
        body: Row(
          children: [
            SizedBox(
              width: 100,
              child: _navi,),
            const VerticalDivider(thickness: 1, width: 1),
            // line splitting navbar and main content
            Expanded(
              child: IndexedStack(
                index: _selectedIndex,
                children: _navigationOptions,
              ),
            ),
          ],
        ));
  }

  Scaffold _buildBottomNavigationScaffold() {
    Widget _navBar = BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        _buildNavigationItem("Endpoint List"),
        _buildNavigationItem("Compare Endpoints"),
        _buildNavigationItem("Profile"),
      ],
      onTap: (index) =>
          setState(() {
            _selectedIndex = index;
          }),
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.pink,
    );
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _navigationOptions,
      ),
      bottomNavigationBar: _navBar,
    );
  }

  NavigationRailDestination _buildRailNavigationItem(String stringLabel) {
    return NavigationRailDestination(
        icon: const Icon(Icons.layers),
        selectedIcon: const Icon(
          Icons.layers,
          color: Colors.pink,
        ),
        label: Text(
          stringLabel,
          style: const TextStyle(color: Colors.pink),
          textAlign: TextAlign.center,
        ));
  }

  BottomNavigationBarItem _buildNavigationItem(String stringLabel) {
    return BottomNavigationBarItem(
      icon: const Icon(Icons.layers),
      label: stringLabel,
    );
  }
}
