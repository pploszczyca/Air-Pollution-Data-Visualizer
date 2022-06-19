import 'package:charts_common/src/chart/common/behavior/legend/legend.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomLegendBuilder extends charts.LegendContentBuilder {
  @override
  Widget build(BuildContext context, LegendState legendState, Legend legend,
      {bool? showMeasures}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Wrap(
        children: legendState.legendEntries
            .map(
              (entry) => Wrap(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  child: Chip(
                    backgroundColor: fromChartColor(entry.color).withOpacity(0.6),
                    label: Text(
                      entry.label,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ),
              ]),
        ).toList(),
      ),
    );
  }

  Color fromChartColor(charts.Color? color) {
    return Color.fromARGB(color!.a, color.r, color.g, color.b);
  }
}
