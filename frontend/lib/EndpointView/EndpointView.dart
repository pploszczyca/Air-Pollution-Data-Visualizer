import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../Models/Endpoint.dart';
import '../Models/EndpointData.dart';
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
    return Scaffold(
      appBar: AppBar(title: const Text("Endpoint Details")),
      body: FutureBuilder<Endpoint>(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.none ||
                snapshot.data == null) {
              return Center(
                child: LoadingAnimationWidget.halfTriangleDot(
                  size: 90,
                  color: Colors.pink,
                ),
              );
            }
            return SingleChildScrollView(
              child: Column(
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
          future: widget.endpoint),
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

@override
    Widget build(BuildContext context) {
        final List<SalesData> chartData = [
            SalesData(2010, 35),
            SalesData(2011, 28),
            SalesData(2012, 34),
            SalesData(2013, 32),
            SalesData(2014, 40)
        ];

        return Scaffold(
            body: Center(
                child: Container(
                    child: SfCartesianChart(
                        primaryXAxis: DateTimeAxis(),
                        series: <ChartSeries>[
                            // Renders line chart
                            LineSeries<SalesData, DateTime>(
                                dataSource: chartData,
                                xValueMapper: (SalesData sales, _) => sales.year,
                                yValueMapper: (SalesData sales, _) => sales.sales
                            )
                        ]
                    )
                )
            )
        );
    }

    class SalesData {
        SalesData(this.year, this.sales);
        final DateTime year;
        final double sales;
    }
 */
