import 'package:adpv_frontend/Drawing/MultiDataChart.dart';
import 'package:adpv_frontend/Models/EndpointSummary.dart';
import 'package:adpv_frontend/Repository/AbstractEndpointRepository.dart';
import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';
import 'package:provider/provider.dart';

import '../Common/Common.dart';
import '../Models/Endpoint.dart';
import '../Providers/CompareEndpointsModel.dart';

class CompareChartsView extends StatefulWidget {
  const CompareChartsView({Key? key, required this.repository})
      : super(key: key);
  final AbstractEndpointRepository repository;

  @override
  State<CompareChartsView> createState() => _CompareChartsViewState();
}

class _CompareChartsViewState extends State<CompareChartsView> {
  //Map<String, bool> selectedChips = {};
  Widget chart = Container();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EndpointModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Compare charts"),
        ),
        body: FutureBuilder<List<EndpointSummary>>(
          future: widget.repository.getEndpointSummary(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.none ||
                snapshot.data == null) {
              return LoadingInCenter();
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Consumer<EndpointModel>(
                              builder: (context, endpointModel, _) {
                            endpointModel
                                .makeEndpointSummaryMap(snapshot.data!);
                            return DropDownMultiSelect(
                              options: endpointModel.endpointSummaryMap.keys
                                  .map((e) => e.toString())
                                  .toList(),
                              selectedValues: endpointModel.selectedEndpoints,
                              onChanged: (List<String> selected) {
                                setState(
                                  () {
                                    endpointModel
                                        .updateEndpointSelectedList(selected);
                                  },
                                );
                              },
                              whenEmpty: emptyField,
                            );
                          }),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Consumer<EndpointModel>(
                        builder: (context, endpointModel, child) {
                      return Wrap(
                        children: _createChips(endpointModel),
                      );
                    }),
                    const SizedBox(height: 10),
                    Consumer<EndpointModel>(
                      builder: (context, endpointModel, child) {
                        chart = _createChart(endpointModel);
                        return chart;
                      },
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  List<Widget> _createChips(EndpointModel endpointModel) {
    return endpointModel.commonFields.map((e) {
      endpointModel.selectedChips.putIfAbsent(e, () => false);
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: InputChip(
          label: Text(e),
          selected: endpointModel.selectedChips[e]!,
          onSelected: (bool value) {
            setState(() {
              endpointModel.selectChips(e, value);
            });
          },
        ),
      );
    }).toList();
  }

  Widget _createChart(EndpointModel endpointModel) {
    if (endpointModel.selectedEndpoints.isEmpty) {
      return Column();
    }
    List<Endpoint> endpoints = endpointModel.getEndpointsForDrawing();
    List<String> fields = endpointModel.getFieldsForDrawing();
    List<Widget> charts = [];

    for (String field in fields) {
      charts.add(MultiDataChart(field: field, endpoints: endpoints));
    }

    return Column(
      children: charts,
    );
  }
}
