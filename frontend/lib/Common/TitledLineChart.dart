import 'package:flutter/cupertino.dart';


import '../Models/EndpointData.dart';
import 'DataChart.dart';

class TitledLineChart extends StatelessWidget {
  const TitledLineChart({Key? key, required this.chartName, required this.measureFnCallback,
  required this.data}) : super(key: key);

  final String chartName;
  final num? Function(Map<dynamic,dynamic>, int?) measureFnCallback ;
  final EndpointData data;


  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            chartName,
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
      DataChart(
        endpointData: data,
        measureFnCallback: measureFnCallback,
      ),
    ],);
  }
}
