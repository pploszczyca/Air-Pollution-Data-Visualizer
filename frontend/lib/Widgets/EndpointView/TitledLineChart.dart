import 'package:../../charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';

import '../../Common/Consts.dart';
import '../../DataModels/EndpointData.dart';

class DataChart extends StatelessWidget {
  const DataChart(
      {required this.endpointData, required this.measureFnCallback, Key? key})
      : super(key: key);

  final EndpointData endpointData;
  final num? Function(Map<dynamic, dynamic>, int?) measureFnCallback;

  @override
  Widget build(BuildContext context) {
    final List<charts.Series<Map<dynamic, dynamic>, DateTime>> series = [
      charts.Series(
        id: "my_chart",
        data: endpointData.dataList,
        domainFn: (Map<dynamic, dynamic> endpointData, _) =>
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

class TitledLineChart extends StatelessWidget {
  const TitledLineChart(
      {required this.chartName,
      required this.measureFnCallback,
      required this.data,
      Key? key})
      : super(key: key);

  final String chartName;
  final num? Function(Map<dynamic, dynamic>, int?) measureFnCallback;

  final EndpointData data;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                chartName,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          DataChart(
            endpointData: data,
            measureFnCallback: measureFnCallback,
          ),
        ],
      );
}
