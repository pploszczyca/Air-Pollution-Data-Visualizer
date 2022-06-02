import 'package:adpv_frontend/Common/Common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../Models/Endpoint.dart';

import '../../Models/EndpointData.dart';
import 'TitledLineChart.dart';

class EndpointView extends StatefulWidget {
  const EndpointView({Key? key, required this.endpoint}) : super(key: key);
  final Future<Endpoint> endpoint;

  @override
  State<EndpointView> createState() => _EndpointViewState();
}

class _EndpointViewState extends State<EndpointView> {
  @override
  Widget build(BuildContext context) {

     return FutureBuilder<Endpoint>(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.none ||
                snapshot.data == null) {
              return Scaffold(
                appBar: AppBar(title: const Text("Endpoint Details")),
                body: LoadingInCenter(),
              );
            }
            return Scaffold(
              appBar: AppBar(title: Text(snapshot.data!.endpointName)),
              body:  Column(
                children: [

                  TitledLinedChart(
                      chartName: "Temperature",
                      measureFnCallback: (EndpointData endpointData, _) => endpointData.temperature,
                      dataList: snapshot.data!.dataList),
                  const SizedBox(height: 25),
                  TitledLinedChart(
                      chartName: "Pressure",
                      measureFnCallback: (EndpointData endpointData, _) => endpointData.pressure,
                      dataList: snapshot.data!.dataList),
                  const SizedBox(height: 25),
                  TitledLinedChart(
                      chartName: "Humidity",
                      measureFnCallback: (EndpointData endpointData, _) => endpointData.humidity,
                      dataList: snapshot.data!.dataList)
                ],
              ),
            );
          },
          future: widget.endpoint);
  }
}
