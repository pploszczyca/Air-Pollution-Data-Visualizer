import 'package:adpv_frontend/Common/Common.dart';
import 'package:adpv_frontend/Models/EndpointData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Common/TitledLineChart.dart';

class EndpointView extends StatefulWidget {
  const EndpointView({Key? key, required this.endpointData}) : super(key: key);
  final Future<EndpointData> endpointData;

  @override
  State<EndpointView> createState() => _EndpointViewState();
}

class _EndpointViewState extends State<EndpointView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<EndpointData>(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.data == null) {
            return Scaffold(
              appBar: AppBar(title: const Text("Endpoint Details")),
              body: LoadingInCenter(),
            );
          }
          return Scaffold(
            appBar: AppBar(title: Text("")),
            body: SingleChildScrollView(
                  child: Column(
                      children: snapshot.data!.dataList[0].keys
                          .where((element) => element != "timestamp")
                          .map((dataKey) => TitledLineChart(
                                chartName: dataKey,
                                measureFnCallback:
                                    (Map<dynamic, dynamic> dataMap, _) =>
                                        dataMap[dataKey],
                                data: snapshot.data!,
                              ))
                          .toList()
                      // TitledLinedChart(
                      //     chartName: "Temperature",
                      //     measureFnCallback: (EndpointData endpointData, _) => endpointData.temperature,
                      //     dataList: snapshot.data!.dataList),
                      // const SizedBox(height: 25),
                      // TitledLinedChart(
                      //     chartName: "Pressure",
                      //     measureFnCallback: (EndpointData endpointData, _) => endpointData.pressure,
                      //     dataList: snapshot.data!.dataList),
                      // const SizedBox(height: 25),
                      // TitledLinedChart(
                      //     chartName: "Humidity",
                      //     measureFnCallback: (EndpointData endpointData, _) => endpointData.humidity,
                      //     dataList: snapshot.data!.dataList),

                      ),
                ),
          );
        },
        future: widget.endpointData);
  }
}
