import 'package:adpv_frontend/CompareEndpoints/TwoChartsDateTime.dart';
import 'package:adpv_frontend/Repository/EndpointRepository.dart';
import 'package:flutter/material.dart';

import '../Common/Common.dart';
import '../Models/ChartData.dart';

class CompareChartsView extends StatefulWidget {
  const CompareChartsView({Key? key, required this.endpointRepository})
      : super(key: key);
  final EndpointRepository endpointRepository;

  @override
  State<CompareChartsView> createState() => _CompareChartsViewState();
}

class _CompareChartsViewState extends State<CompareChartsView> {
  String? _firstEndpoint;
  String? _secondEndpoint;
  Map<ChartData, bool> isChipsSelected = {};
  List<ChartData> chartDataSelected = [];
  Widget chart = Container();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Compare charts"),
      ),
      body: FutureBuilder<List<String>>(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.data == null) {
            return LoadingInCenter();
          } else {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    DropdownButton(
                      hint: const Text("SelectEndpoint"),
                      value: _firstEndpoint,
                      items: buildDropDownMenuItems(snapshot).toList(),
                      underline: Container(
                        height: 2,
                        color: Colors.blue,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _firstEndpoint = value as String?;
                        });
                      },
                    ),
                    DropdownButton(
                      hint: const Text("SelectEndpoint"),
                      value: _secondEndpoint,
                      items: buildDropDownMenuItems(snapshot).toList(),
                      underline: Container(
                        height: 2,
                        color: Colors.red,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _secondEndpoint = value as String?;
                        });
                      },
                    ),
                  ],
                ),
                Center(
                    child: Container(
                  margin: const EdgeInsets.only(left: 24, right: 24),
                  child: _makeInputChips(
                      widget.endpointRepository.getAvailableFields()),
                )),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                      onPressed: () {
                        var firstEndpointData = widget.endpointRepository
                            .getEndpoint(_firstEndpoint!);
                        var secondEndpointData = widget.endpointRepository
                            .getEndpoint(_secondEndpoint!);
                        var endpoints = [firstEndpointData, secondEndpointData];

                        chart = Column(
                          children: chartDataSelected
                              .map((chartData) => TwoChartsDateTime(
                                  endpoints: endpoints,
                                  measureFnCallback:
                                      chartData.measureFnCallback,
                                  chartTitle: chartData.name,
                                  yLabel: chartData.unit))
                              .toList(),
                        );
                      },
                      child: const Text("Generate charts")),
                ),
                 chart

              ],
            );
          }
        },
        future: widget.endpointRepository.getEndpointSummary(),
      ),
    );
  }

  Widget _makeInputChips(Future<List<ChartData>> chartDataFuture) {
    return FutureBuilder<List<ChartData>>(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.data == null) {
            return LoadingInCenter();
          } else {
            return Row(
                children: snapshot.data!
                    .map(mapChartDataToInputChip)
                    .toList());
          }
        },
        future: chartDataFuture);
  }

  InputChip mapChartDataToInputChip(ChartData chartData) {
    isChipsSelected.putIfAbsent(chartData, () => false);

    return InputChip(
      label: Text(chartData.name),
      selected: isChipsSelected[chartData]!,
      onSelected: (bool value) {
        setState(() {
          isChipsSelected[chartData] = value;
          if (value) {
            chartDataSelected.add(chartData);
          } else {
            chartDataSelected.remove(chartData);
          }
        });
      },
    );
  }

  Iterable<DropdownMenuItem<String>> buildDropDownMenuItems(
      AsyncSnapshot<List<String>> snapshot) {
    return snapshot.data!.map((item) => DropdownMenuItem<String>(
          child: Text(item),
          value: item,
        ));
  }
}
