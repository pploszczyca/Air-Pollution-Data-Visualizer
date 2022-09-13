// ignore implementation_imports
import 'package:adpv_frontend/Widgets/common_widgets.dart';

// ignore: implementation_imports
import 'package:charts_common/src/chart/common/behavior/legend/legend.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../../Common/consts.dart';
import '../../DataModels/endpoint.dart';

class MultiDataChart extends StatefulWidget {
  const MultiDataChart({required this.field, required this.endpoints, Key? key})
      : super(key: key);
  final String field;
  final List<Endpoint> endpoints;

  @override
  State<MultiDataChart> createState() => _MultiDataChartState();
}

class _MultiDataChartState extends State<MultiDataChart> {
  String getUnit(String field) => widget.endpoints[0].data.enableFieldsList
      .firstWhere((enableField) => enableField.label == field)
      .unit
      .name;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Column(
              children: [
                buildChartHeader(),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: buildChart(),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
        ],
      );

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
              widget.field.toUpperCase() + spacer + getUnit(widget.field),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.pink,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );

  List<charts.Series<Map<dynamic, dynamic>, DateTime>> _createData(
    List<Endpoint> list,
  ) =>
      list
          .map(
            (e) => charts.Series<Map<dynamic, dynamic>, DateTime>(
              id: e.label,
              data: e.data.dataList,
              domainFn: (Map<dynamic, dynamic> endpointData, _) =>
                  DateTime.parse(endpointData[ignoreField]),
              measureFn: (Map<dynamic, dynamic> endpointData, _) =>
                  endpointData[widget.field],
            ),
          )
          .toList();
}

class CustomLegendBuilder extends charts.LegendContentBuilder {
  @override
  Widget build(
    BuildContext context,
    LegendState legendState,
    Legend legend, {
    bool? showMeasures,
  }) =>
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Wrap(
          alignment: WrapAlignment.start,
          children: legendState.legendEntries
              .map(
                (entry) => Wrap(
                  children: [
                    Chip(
                      backgroundColor:
                          fromChartColor(entry.color).withOpacity(0.6),
                      label: Text(
                        entry.label,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: "SofiaSans",
                        ),
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      );

  Color fromChartColor(charts.Color? color) =>
      Color.fromARGB(color!.a, color.r, color.g, color.b);
}
