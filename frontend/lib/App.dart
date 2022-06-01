import 'package:adpv_frontend/CompareChartsView.dart';
import 'package:adpv_frontend/EndpointList/EnpointList.dart';
import 'package:adpv_frontend/ProfileView.dart';
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
            EndpointList(endpointRepository: widget.endpointRepository),
            CompareChartsView(),
            ProfileView(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: [
            _buildNavigationItem(),
            _buildNavigationItem(),
            _buildNavigationItem(),
          ],
          onTap: (index) => setState(() {
            _selectedIndex = index;
          }),
        ));
  }

  BottomNavigationBarItem _buildNavigationItem() {
    return const BottomNavigationBarItem(
      icon: Icon(Icons.layers, color: Colors.grey),
      label: "Label",
    );
  }
}
