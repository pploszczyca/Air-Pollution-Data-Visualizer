import 'package:adpv_frontend/Common/Common.dart';
import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../Models/Endpoint.dart';


class MultiDataChart extends StatefulWidget {
  const MultiDataChart({Key? key, required this.field, required this.endpoints})
      : super(key: key);
  final String field;
  final List<Endpoint> endpoints;

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
              //TODO make this MotherFu.. responsive
              charts.SeriesLegend(desiredMaxColumns: 2),
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
          DateTime.parse(endpointData[ignoreField]),
      measureFn: (Map<dynamic,dynamic> endpointData, _) =>
         endpointData[widget.field],
    )).toList();
  }
}
