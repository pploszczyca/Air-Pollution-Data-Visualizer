import 'package:adpv_frontend/Common/Common.dart';
import 'package:adpv_frontend/Models/EndpointData.dart';
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
              appBar: AppBar(title: const Text(endpointViewAppBar)),
              body: LoadingInCenter(),
            );
          }
          return Scaffold(
            appBar: AppBar(title: const Text(endpointViewAppBar)),
            body: SingleChildScrollView(
                  child: Column(
                      children: snapshot.data!.dataList[0].keys
                          .where((element) => element != ignoreField)
                          .map((dataKey) => TitledLineChart(
                                chartName: dataKey,
                                measureFnCallback:
                                    (Map<dynamic, dynamic> dataMap, _) =>
                                        dataMap[dataKey],
                                data: snapshot.data!,
                              ))
                          .toList()
                      ),
                ),
          );
        },
        future: widget.endpointData);
  }
}
