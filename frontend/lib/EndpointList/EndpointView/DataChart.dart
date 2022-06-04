import 'package:adpv_frontend/Models/EndpointData.dart';
import 'package:../../charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class DataChart extends StatelessWidget {
  const DataChart({
    Key? key,
    required this.endpointDataList,
    required this.measureFnCallback,
  }) : super(key: key);

  final List<Map<dynamic, dynamic>> endpointDataList;
  final num? Function(Map<dynamic, dynamic>, int?) measureFnCallback;

  @override
  Widget build(BuildContext context) {
    List<charts.Series<EndpointData, int>> series = [
      charts.Series(
        id: "my_chart",
        data: endpointDataList,
        domainFn: (Map<dynamic, dynamic> endpointData, _) =>
            DateTime.parse(endpointData['timestamp']),
        measureFn: measureFnCallback,
        displayName: "temperature",
      )
    ];

    const axisSetting = charts.NumericAxisSpec(
      tickProviderSpec: charts.BasicNumericTickProviderSpec(zeroBound: false),
    );

    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width * 0.9,
        child: charts.TimeSeriesChart(series,
            primaryMeasureAxis: charts.NumericAxisSpec(
              tickProviderSpec:
                  charts.BasicNumericTickProviderSpec(zeroBound: false),
            )));
  }
}
