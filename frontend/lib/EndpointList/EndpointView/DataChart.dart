import 'package:adpv_frontend/Models/EndpointData.dart';
import 'package:../../charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class DataChart extends StatelessWidget {
  const DataChart({
    Key? key,
    required this.endpointDataList,
    required this.measureFnCallback,
  }) : super(key: key);

  final List<EndpointData> endpointDataList;
  final num? Function(EndpointData, int?) measureFnCallback;

  @override
  Widget build(BuildContext context) {
    List<charts.Series<EndpointData, int>> series = [
      charts.Series(
        id: "my_chart",
        data: endpointDataList,
        domainFn: (EndpointData endpointData, _) => endpointData.date.day,
        measureFn: measureFnCallback,
        displayName: "temperature",
      )
    ];

    const axisSetting = charts.NumericAxisSpec(
      tickProviderSpec:
      charts.BasicNumericTickProviderSpec(zeroBound: false),
    );

    return SizedBox(
      height: 200,
      width: 600,
      child: charts.LineChart(
        series,
        animate: true,
        primaryMeasureAxis: axisSetting,
        domainAxis: axisSetting,
      ),
    );
  }
}
