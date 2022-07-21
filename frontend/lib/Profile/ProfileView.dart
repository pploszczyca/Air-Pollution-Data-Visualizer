import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  // charts.Series<Map<dynamic, dynamic>, DateTime> _createData(
  //     EndpointData data,
  //     num? Function(Map<dynamic, dynamic>, int?) measureFn) {
  //   return charts.Series(
  //             id: "Something",
  //             data: data.dataList,
  //             displayName: "Test",
  //             domainFn: (Map<dynamic, dynamic> endpointData, _) => DateTime.parse(endpointData["timestamp"]),
  //             measureFn: measureFn,
  //           );
  // }

  @override
  Widget build(BuildContext context) => Container();


    // var repository = RestClient(Dio());
    // return FutureBuilder<EndpointData>(
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.none ||
    //         snapshot.data == null) {
    //       return LoadingInCenter();
    //     }
    //     return SizedBox(
    //       width: MediaQuery.of(context).size.width * 1 ,
    //       height:  MediaQuery.of(context).size.height *0.3,
    //       child: charts.TimeSeriesChart(
    //         [_createData(
    //           snapshot.data!,
    //                 (Map<dynamic, dynamic> endpointData, _) => endpointData["temperature"]
    //         )],
    //         animate: false,
    //         defaultRenderer: charts.LineRendererConfig(),
    //         dateTimeFactory: const charts.LocalDateTimeFactory(),
    //         behaviors: [
    //           charts.SeriesLegend(),
    //           charts.ChartTitle("titleName",
    //               behaviorPosition: charts.BehaviorPosition.top,
    //               titleOutsideJustification:
    //                   charts.OutsideJustification.middleDrawArea),
    //           charts.ChartTitle("smth",
    //               behaviorPosition: charts.BehaviorPosition.start,
    //               titleOutsideJustification:
    //                   charts.OutsideJustification.middleDrawArea)
    //         ],
    //       ),
    //     );
    //   },
    //   future: repository.getEndpointData(3),
    // );



}
