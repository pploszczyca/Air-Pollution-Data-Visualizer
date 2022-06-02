import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../Common/Common.dart';
import '../Models/Endpoint.dart';
import '../Models/EndpointData.dart';

class TwoChartsDateTime extends StatefulWidget {
  final List<Future<Endpoint>> endpoints;

  const TwoChartsDateTime({Key? key, required this.endpoints})
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

  List<charts.Series<EndpointData, DateTime>> _createData(List<Endpoint> list) {
    List<charts.Series<EndpointData, DateTime>> data = [];
    for (Endpoint e in list) {
      data.add(charts.Series(
        id: e.endpointName,
        data: e.dataList,
        domainFn: (EndpointData endpointData, _) => endpointData.date,
        measureFn: (EndpointData endpointData, _) => endpointData.temperature,
      ));
    }
    return data;
  }

  charts.TimeSeriesChart _createCharts(
      List<charts.Series<EndpointData, DateTime>> seriesList) {
    return charts.TimeSeriesChart(seriesList,
        animate: true,
        defaultRenderer: charts.LineRendererConfig(),
        dateTimeFactory: const charts.LocalDateTimeFactory());
  }
}
