import 'package:adpv_frontend/Models/EndpointData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/EndpointViewProvider.dart';

import '../Widgets/CommonWidgets.dart';
import '../Widgets/EndpointView/EndpointInfoTable.dart';
import '../Widgets/EndpointView/TitledLineChart.dart';

class EndpointView extends StatefulWidget {
  const EndpointView({required this.endpointData, Key? key }) : super(key: key);
  final Future<EndpointData> endpointData;

  @override
  State<EndpointView> createState() => _EndpointViewState();
}

TabBar _buildTabBar(EndpointViewProvider endpointViewProvider, BuildContext context)=> TabBar(
      isScrollable: true,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      unselectedLabelStyle: const TextStyle(
          color: Colors.pink,
          fontFamily: "SofiaSans",
          fontSize: 20),
      labelColor: Colors.pink,
      unselectedLabelColor: const Color.fromARGB(255, 127, 166, 168),
      labelStyle: const TextStyle(
          color: Colors.pink,
          fontFamily: "SofiaSans",
          fontSize: 25),
      tabs: endpointViewProvider.tabs.map((data) => SizedBox(
          width:  MediaQuery.of(context).size.width* 1/endpointViewProvider.tabs.length,
          child:  Tab(text: data.typeName),
        )).toList());

SizedBox _buildBarView(EndpointViewProvider endpointViewProvider, BuildContext context, snapshot)=> SizedBox(
    height: MediaQuery.of(context).size.height*0.5,
    child: TabBarView(
        children: endpointViewProvider.tabs
            .map((dataKey) => TitledLineChart(
          chartName: dataKey.typeName,
          measureFnCallback:
              (Map<dynamic, dynamic>
          dataMap,
              _) =>
          dataMap[dataKey.typeName],
          data: snapshot.data!,
        ))
            .toList()),
  );
class _EndpointViewState extends State<EndpointView> {
  @override
  Widget build(BuildContext context) => FutureBuilder<EndpointData>(
        future: widget.endpointData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.data == null) {
            return Scaffold(
              appBar: buildAppBar(endpointViewAppBar),
              body: LoadingInCenter(),
            );
          }
          return Scaffold(
              appBar: buildAppBar(endpointViewAppBar),
              body: SingleChildScrollView(
                  child: Column(
                    children: [
                      EndpointInfoTable(data: snapshot.data!.technicalInfo),
                      ChangeNotifierProvider(
                          create: (context) => EndpointViewProvider(snapshot.data!),
                          child: Consumer<EndpointViewProvider>(
                            builder: (context, endpointViewProvider, _) => DefaultTabController(
                                  length: endpointViewProvider.tabs.length,
                                  child: Column(children: [
                                    _buildTabBar(endpointViewProvider, context),
                                    _buildBarView(endpointViewProvider, context, snapshot)
                                  ])),
                          )),
                    ],
                  )));
        });
}
