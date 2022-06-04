import 'package:adpv_frontend/CompareEndpoints/TwoChartsDateTime.dart';
import 'package:adpv_frontend/Repository/RestClient.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../Common/Common.dart';
import '../EndpointList/EndpointView/DataChart.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  charts.Series<Map<dynamic, dynamic>, DateTime> _createData(
      List<Map<dynamic, dynamic>> list,
      num? Function(Map<dynamic, dynamic>, int?) measureFn) {
    return charts.Series(
              id: "Something",
              data: list,
              displayName: "Test",
              domainFn: (Map<dynamic, dynamic> endpointData, _) => DateTime.parse(endpointData["timestamp"]),
              measureFn: measureFn,
            );
  }

  @override
  Widget build(BuildContext context) {
    var repository = RestClient(Dio());

    const axisSetting = charts.NumericAxisSpec(
      tickProviderSpec:
      charts.BasicNumericTickProviderSpec(zeroBound: false),
    );

    return FutureBuilder<List<Map<dynamic, dynamic>>>(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none ||
            snapshot.data == null) {
          return LoadingInCenter();
        }
        print("#############" + snapshot.data![0].toString());

        return SizedBox(
          width: MediaQuery.of(context).size.width * 1 ,
          height:  MediaQuery.of(context).size.height *0.3,
          child: charts.TimeSeriesChart(
            [_createData(
              snapshot.data!,
                    (Map<dynamic, dynamic> endpointData, _) => endpointData["temperature"]
            )],
            animate: false,
            defaultRenderer: charts.LineRendererConfig(),
            dateTimeFactory: const charts.LocalDateTimeFactory(),
            behaviors: [
              charts.SeriesLegend(),
              charts.ChartTitle("titleName",
                  behaviorPosition: charts.BehaviorPosition.top,
                  titleOutsideJustification:
                      charts.OutsideJustification.middleDrawArea),
              charts.ChartTitle("smth",
                  behaviorPosition: charts.BehaviorPosition.start,
                  titleOutsideJustification:
                      charts.OutsideJustification.middleDrawArea)
            ],
          ),
        );

        return DataChart(
          measureFnCallback: (Map<dynamic, dynamic> endpointData, _) =>
              endpointData["temperature"] as double,
          endpointDataList: snapshot.data!,
        );
      },
      future: repository.getEndpointData(3),
    );
    // return Column(children: <Widget>[
    //   AppBar(
    //     title: const Text("Your profile"),
    //   ),
    //   const Text("Some profile info here"),
    // ]);
  }
}
