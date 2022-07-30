import 'package:adpv_frontend/DataModels/EndpointSummary.dart';
import 'package:adpv_frontend/Widgets/CommonWidgets.dart';
import 'package:flutter/material.dart';

import 'Repository/EndpointRepository/RestEndpointRepository.dart';
import 'Routing/EndpointNavigator.dart';
import 'Views/CompareEndpointsView.dart';
import 'Views/ProfileView.dart';

const String endpointList = "Endpoint List";
const String compareEndpoints = "Compare";
const String profile = "Profile";

const int endpointListIcon = 0xf1ae;
const int compareEndpointsIcon = 0xf05bb;
const int profileIcon = 0xf27a;

class App extends StatefulWidget {
  final RestEndpointRepository repository;

  const App({required this.repository, Key? key}) : super(key: key);

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
    final MediaQueryData queryData = MediaQuery.of(context);

    return FutureBuilder<List<EndpointSummary>>(
        future: widget.repository.getEndpointSummary(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.data == null) {
            return loadingInCenter();
          } else {
            return queryData.size.width > 560
                ? _buildRailNavigationScaffold()
                : _buildBottomNavigationScaffold();
          }
        });
  }

  Scaffold _buildRailNavigationScaffold() {
    final Widget navi = Expanded(
      flex: 1,
      child: NavigationRail(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        labelType: NavigationRailLabelType.selected,
        destinations: [
          _buildRailNavigationItem(endpointList, endpointListIcon),
          _buildRailNavigationItem(compareEndpoints, compareEndpointsIcon),
          _buildRailNavigationItem(profile, profileIcon),
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
              navi,
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
    final Widget navbar = BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        _buildNavigationItem(endpointList, const Icon(Icons.map_outlined)),
        _buildNavigationItem(
            compareEndpoints, const Icon(Icons.area_chart_outlined)),
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
      bottomNavigationBar: navbar,
    );
  }

  NavigationRailDestination _buildRailNavigationItem(
          String stringLabel, int codePoint) =>
      NavigationRailDestination(
        icon: Icon(
          IconData(codePoint, fontFamily: 'MaterialIcons'),
          size: 30,
        ),
        selectedIcon: Icon(
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

  BottomNavigationBarItem _buildNavigationItem(String stringLabel, Icon icon) =>
      BottomNavigationBarItem(
        icon: icon,
        label: stringLabel,
      );
}
