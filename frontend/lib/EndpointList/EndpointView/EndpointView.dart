import 'package:adpv_frontend/Common/Common.dart';
import 'package:adpv_frontend/EndpointList/EndpointView/EndpointInfoTable.dart';
import 'package:adpv_frontend/Models/EndpointData.dart';
import 'package:adpv_frontend/Providers/EndpointViewProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Common/TitledLineChart.dart';

class EndpointView extends StatefulWidget {
  const EndpointView({Key? key, required this.endpointData}) : super(key: key);
  final Future<EndpointData> endpointData;

  @override
  State<EndpointView> createState() => _EndpointViewState();
}

TabBar _buildTabBar(EndpointViewProvider endpointViewProvider){
  return TabBar(
      padding: const EdgeInsets.only(
          top: 10.0, bottom: 10.0),
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
      tabs: endpointViewProvider.tabs.map((data) {
        return Tab(text: data.typeName);

      }).toList());
}
class _EndpointViewState extends State<EndpointView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<EndpointData>(
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
                            builder: (context, endpointViewProvider, _) {
                              return DefaultTabController(
                                  length: endpointViewProvider.tabs.length,
                                  child: Column(children: [
                                    _buildTabBar(endpointViewProvider),
                                    SizedBox(
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
                                    )
                                  ]));
                            },
                          )),
                    ],
                  )));
        });
  }
}
