import 'package:../../charts_flutter/flutter.dart' as charts;
import 'package:adpv_frontend/Common/Common.dart';
import 'package:adpv_frontend/Models/EndpointData.dart';
import 'package:flutter/material.dart';

class DataChart extends StatelessWidget {
  const DataChart({
    required this.endpointData,
    required this.measureFnCallback,
    Key? key
  }) : super(key: key);

  final EndpointData endpointData;
  final num? Function(Map<dynamic,dynamic>, int?) measureFnCallback;

  //TODO just for checking things about charts

  @override
  Widget build(BuildContext context) {
    final List<charts.Series<Map<dynamic,dynamic>, DateTime>> series = [
      charts.Series(
        id: "my_chart",
        data: endpointData.dataList,
        domainFn: (Map<dynamic,dynamic> endpointData, _) =>
            DateTime.parse(endpointData[ignoreField]),
        measureFn: measureFnCallback,
       // displayName: "temperature",
      )
    ];

    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width * 0.9,
        child: charts.TimeSeriesChart(series,
            primaryMeasureAxis: const charts.NumericAxisSpec(
              tickProviderSpec:
                  charts.BasicNumericTickProviderSpec(zeroBound: false),
            )));
  }
}
