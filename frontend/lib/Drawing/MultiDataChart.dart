import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../Models/Endpoint.dart';


class MultiDataChart extends StatefulWidget {
  MultiDataChart({Key? key, required this.field, required this.endpoints})
      : super(key: key);
  String field;
  List<Endpoint> endpoints;

  @override
  State<MultiDataChart> createState() => _MultiDataChartState();
}

class _MultiDataChartState extends State<MultiDataChart> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.field,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width * 0.9,
          child: charts.TimeSeriesChart(
              _createData(widget.endpoints),
              primaryMeasureAxis: const charts.NumericAxisSpec(
                tickProviderSpec:
                charts.BasicNumericTickProviderSpec(zeroBound: false),
              ),
            animate: true,
            behaviors: [
              //charts.SeriesLegend(),
            ],
          )),
   ] );
  }

  List<charts.Series<Map<dynamic,dynamic>, DateTime>> _createData(
      List<Endpoint> list
      ){
    return list.map((e) => charts.Series<Map<dynamic,dynamic>, DateTime>(
      id: e.label,
      data: e.data.dataList,
      domainFn: (Map<dynamic,dynamic> endpointData, _) =>
          DateTime.parse(endpointData['timestamp']),
      measureFn: (Map<dynamic,dynamic> endpointData, _) =>
         endpointData[widget.field],
      displayName: e.label,
    )).toList();
  }
  
}
