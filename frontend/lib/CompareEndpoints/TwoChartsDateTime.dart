import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../Common/Common.dart';
import '../Models/Endpoint.dart';
import '../Models/EndpointData.dart';

class TwoChartsDateTime extends StatefulWidget {
  final List<Future<Endpoint>> endpoints;
  final num? Function(EndpointData, int?) measureFnCallback ;
  final String yLabel;
  final String chartTitle;

  const TwoChartsDateTime({Key? key, required this.endpoints, required this.measureFnCallback, required this.chartTitle, required this.yLabel})
      : super(key: key);

  @override
  State<TwoChartsDateTime> createState() => _TwoChartsDateTimeState();
}

class _TwoChartsDateTimeState extends State<TwoChartsDateTime> {
  @override
  Widget build(BuildContext context) {
    print("TwoChartsDateTime build");
    return FutureBuilder<List<Endpoint>>(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none ||
            snapshot.data == null) {
          print("TwoChartsDateTime waiting for future");
          return LoadingInCenter();
        } else {
          var series = _createData(snapshot.data!);
          var chart = _createCharts(series);
          print("TwoChartsDateTime created chart");

          MediaQueryData mediaQueryData = MediaQuery.of(context);

          return Column(
            children: [
              Text("Temperature"),
              SizedBox(
                height: 200,
                width: 600,
                child: chart,
              ),
            ],
          );
        }
      },
      future: Future.wait(widget.endpoints),
    );
  }

  List<charts.Series<EndpointData, DateTime>> _createData(List<Endpoint> list,
      num? Function(EndpointData, int?) measureFn) {
    return list
        .map((e) => charts.Series(
              id: e.endpointName,
              data: e.dataList,
              displayName: e.endpointName,
              domainFn: (EndpointData endpointData, _) => endpointData.date,
              measureFn: measureFn,
            ))
        .toList();
  }

  charts.TimeSeriesChart _createCharts(
      List<charts.Series<EndpointData, DateTime>> seriesList,
      String titleName,
      String yLabel) {
    return charts.TimeSeriesChart(
      seriesList,
      animate: false,
      defaultRenderer: charts.LineRendererConfig(),
      dateTimeFactory: const charts.LocalDateTimeFactory(),
      behaviors: [
        charts.SeriesLegend(),
        charts.ChartTitle(titleName,
            behaviorPosition: charts.BehaviorPosition.top,
            titleOutsideJustification:
                charts.OutsideJustification.middleDrawArea),
        charts.ChartTitle(yLabel,
            behaviorPosition: charts.BehaviorPosition.start,
            titleOutsideJustification:
            charts.OutsideJustification.middleDrawArea)
      ],
    );
  }
}
