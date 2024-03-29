import 'package:adpv_frontend/Repository/EndpointRepository/endpoint_gateway.dart';
import 'package:adpv_frontend/Repository/UserRepository/user_gateway.dart';
import 'package:adpv_frontend/Widgets/common_widgets.dart';
import 'package:flutter/material.dart';

import 'Repository/AdminRepository/admin_gateway.dart';
import 'Views/AdminPage/main_admin_page.dart';
import 'Views/compare_endpoints_view.dart';
import 'Views/enpoint_list_view.dart';
import 'Views/profile_view.dart';

const String endpointList = "Endpoint List";
const String compareEndpoints = "Compare";
const String profile = "Profile";
const String admin = "Admin";

const int endpointListIcon = 0xf1ae;
const int compareEndpointsIcon = 0xf05bb;
const int profileIcon = 0xf27a;
const int adminIcon = 0xe062;

class App extends StatefulWidget {
  final EndpointGateway endpointGateway;
  final UserGateway userGateway;
  final Future<bool> isAdmin;
  final AdminGateway adminGateway = AdminGateway();

  App({
    required this.endpointGateway,
    required this.userGateway,
    required this.isAdmin,
    Key? key,
  }) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  _AppState();

  int _selectedIndex = 0;
  late final List<Widget> _navigationOptions = <Widget>[
    EndpointListView(
      gateway: widget.endpointGateway,
    ),
    CompareChartsView(
      endpointGateway: widget.endpointGateway,
    ),
    ProfileView(widget.userGateway),
  ];

  @override
  Widget build(BuildContext context) {
    final MediaQueryData queryData = MediaQuery.of(context);

    return FutureBuilder<bool>(
      future: widget.isAdmin,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none ||
            snapshot.data == null) {
          return loadingInCenter();
        } else {
          return queryData.size.width > 560
              ? _buildRailNavigationScaffold(snapshot.data!)
              : _buildBottomNavigationScaffold(snapshot.data!);
        }
      },
    );
  }

  Scaffold _buildRailNavigationScaffold(bool isAdmin) {
    final List<NavigationRailDestination> destinations = [
      _buildRailNavigationItem(endpointList, endpointListIcon),
      _buildRailNavigationItem(compareEndpoints, compareEndpointsIcon),
      _buildRailNavigationItem(profile, profileIcon),
    ];

    if (isAdmin) {
      destinations.add(_buildRailNavigationItem(admin, adminIcon));
      _navigationOptions.add(const AdminMainView());
    }

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
        destinations: destinations,
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
      ),
    );
  }

  Scaffold _buildBottomNavigationScaffold(bool isAdmin) {
    final List<BottomNavigationBarItem> destinations = [
      _buildNavigationItem(endpointList, const Icon(Icons.map_outlined)),
      _buildNavigationItem(
        compareEndpoints,
        const Icon(Icons.area_chart_outlined),
      ),
      _buildNavigationItem(profile, const Icon(Icons.person_outline)),
    ];

    if (isAdmin) {
      destinations.add(
        _buildNavigationItem(
          admin,
          const Icon(Icons.admin_panel_settings_outlined),
        ),
      );
      _navigationOptions.add(const AdminMainView());
    }

    final Widget navbar = BottomNavigationBar(
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      items: destinations,
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
    String stringLabel,
    int codePoint,
  ) =>
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
