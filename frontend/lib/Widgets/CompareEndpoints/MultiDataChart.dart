import 'package:charts_common/src/chart/common/behavior/legend/legend.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../../Common/Consts.dart';
import '../../DataModels/Endpoint/Endpoint.dart';

class MultiDataChart extends StatefulWidget {
  const MultiDataChart({required this.field, required this.endpoints, Key? key})
      : super(key: key);
  final String field;
  final List<Endpoint> endpoints;

  @override
  State<MultiDataChart> createState() => _MultiDataChartState();
}

class _MultiDataChartState extends State<MultiDataChart> {
  @override
  Widget build(BuildContext context) => Column(children: [
        buildChartHeader(),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width * 1,
          child: buildChart(),
        ),
        buildSimpleDivider(context),
      ]);

  Container buildSimpleDivider(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        width: MediaQuery.of(context).size.width * 0.9,
      );

  charts.TimeSeriesChart buildChart() => charts.TimeSeriesChart(
        _createData(widget.endpoints),
        primaryMeasureAxis: const charts.NumericAxisSpec(
          tickProviderSpec:
              charts.BasicNumericTickProviderSpec(zeroBound: false),
        ),
        animate: false,
        behaviors: [charts.SeriesLegend.customLayout(CustomLegendBuilder())],
      );

  Center buildChartHeader() => Center(
        child: Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              widget.field.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.pink,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );

  List<charts.Series<Map<dynamic, dynamic>, DateTime>> _createData(
          List<Endpoint> list) =>
      list
          .map((e) => charts.Series<Map<dynamic, dynamic>, DateTime>(
                id: e.label,
                data: e.data.dataList,
                domainFn: (Map<dynamic, dynamic> endpointData, _) =>
                    DateTime.parse(endpointData[ignoreField]),
                measureFn: (Map<dynamic, dynamic> endpointData, _) =>
                    endpointData[widget.field],
              ))
          .toList();
}

class CustomLegendBuilder extends charts.LegendContentBuilder {
  @override
  Widget build(BuildContext context, LegendState legendState, Legend legend,
          {bool? showMeasures}) =>
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Wrap(
          children: legendState.legendEntries
              .map(
                (entry) => Wrap(children: [
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    child: Chip(
                      backgroundColor:
                          fromChartColor(entry.color).withOpacity(0.6),
                      label: Text(
                        entry.label,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ),
                ]),
              )
              .toList(),
        ),
      );

  Color fromChartColor(charts.Color? color) =>
      Color.fromARGB(color!.a, color.r, color.g, color.b);
}
