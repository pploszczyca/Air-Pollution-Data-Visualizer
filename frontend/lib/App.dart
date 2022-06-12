import 'package:adpv_frontend/Repository/AbstractEndpointRepository.dart';
import 'package:adpv_frontend/Repository/MockRepository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'CompareEndpoints/CompareEndpointsView.dart';
import 'EndpointList/EndpointNavigator.dart';
import 'Profile/ProfileView.dart';
import 'Providers/CompareEndpointsModel.dart';

const String endpointList = "Endpoint List";
const String compareEnpoints = "Compare";
const String profile = "Profile";

const int endpointListIcon = 0xf1ae;
const int compareEndpointsIcon = 0xf05bb;
const int profileIcon = 0xf27a;

class App extends StatefulWidget {
  EndpointRepository endpointRepository;
  AbstractEndpointRepository repository;

  App({Key? key, required this.endpointRepository, required this.repository}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  _AppState();

  int _selectedIndex = 0;
  late final List<Widget> _navigationOptions = <Widget>[
    EndpointNavigator(repository: widget.repository),
     CompareChartsView(
        repository: widget.repository,
      ),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);

    return queryData.size.width > 560
        ? _buildRailNavigationScaffold()
        : _buildBottomNavigationScaffold();
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
          _buildRailNavigationItem(endpointList, endpointListIcon),
          _buildRailNavigationItem(compareEnpoints,  compareEndpointsIcon),
          _buildRailNavigationItem(profile,  profileIcon),
        ],
      ),
    );
    return Scaffold(
        body: Row(
      children: [
        SizedBox(
          width: 100,
          child: Column(
            children: [
              _navi,
            ],
          ),
        ),
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
        _buildNavigationItem(endpointList, const Icon(Icons.map_outlined)),
        _buildNavigationItem(compareEnpoints, const  Icon(Icons.area_chart_outlined)),
        _buildNavigationItem(profile, const Icon(Icons.person_outline)),
      ],
      onTap: (index) => setState(() {
        _selectedIndex = index;
        if (index == 0) {}
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

  NavigationRailDestination _buildRailNavigationItem(String stringLabel, int codePoint) { //because of not const icons needed flag  --no-tree-shake-icons
    return NavigationRailDestination(
      icon: Icon(IconData(codePoint, fontFamily: 'MaterialIcons'), size: 30,),
      selectedIcon:
      Icon(
        IconData(codePoint, fontFamily: 'MaterialIcons'),
        color: Colors.pink,
        size: 35,
      ),
      label: Text(
        stringLabel,
        style: const TextStyle(color: Colors.pink),
        textAlign: TextAlign.center,
      ),
    );
  }

  BottomNavigationBarItem _buildNavigationItem(String stringLabel, Icon icon) {
    return BottomNavigationBarItem(
      icon: icon,
      label: stringLabel,
    );
  }
}
