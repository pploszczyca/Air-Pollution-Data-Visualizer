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
  const CompareChartsView({required this.repository, Key? key})
      : super(key: key);
  final AbstractEndpointRepository repository;

  @override
  State<CompareChartsView> createState() => _CompareChartsViewState();
}

class _CompareChartsViewState extends State<CompareChartsView> {
  Widget chart = Container();

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => CompareEndpointsModel(),
      child: Scaffold(
        appBar: buildAppBar(compareEndpointsViewAppBar),
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
                    buildDropDownSelection(context, snapshot),
                    const SizedBox(height: 10),
                    Consumer<CompareEndpointsModel>(
                        builder: (context, endpointModel, child) => Wrap(
                        children: _createChips(endpointModel),
                      )),
                    const SizedBox(height: 10),
                    Consumer<CompareEndpointsModel>(
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

  Row buildDropDownSelection(
      BuildContext context, AsyncSnapshot<List<EndpointSummary>> snapshot) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Consumer<CompareEndpointsModel>(
              builder: (context, endpointModel, _) {
            endpointModel.makeEndpointSummaryMap(snapshot.data!);
            return Theme(  // 200IQ move
              data: ThemeData.from(colorScheme: ColorScheme.fromSwatch(
                backgroundColor: Colors.white,
                cardColor: Colors.pink,
                primarySwatch: Colors.pink
              )),
              child: DropDownMultiSelect(
                isDense: true,
                options: endpointModel.endpointSummaryMap.keys
                    .toList(),
                selectedValues: endpointModel.selectedEndpoints,
                onChanged: (List<String> selected) {
                  setState(
                    () {
                      endpointModel.updateEndpointSelectedList(selected);
                    },
                  );
                },
                whenEmpty: emptyField,
              ),
            );
          }),
        ),
      ],
    );

  List<Widget> _createChips(CompareEndpointsModel endpointModel) => endpointModel.commonFields.map((e) {
      endpointModel.selectedChips.putIfAbsent(e, () => false);
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
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

  Widget _createChart(CompareEndpointsModel endpointModel) {
    if (endpointModel.selectedEndpoints.isEmpty) {
      return Column();
    }
    final List<Endpoint> endpoints = endpointModel.getEndpointsForDrawing();
    final List<String> fields = endpointModel.getFieldsForDrawing();

    return Column(
      children: fields
          .map((field) => MultiDataChart(field: field, endpoints: endpoints))
          .toList(),
    );
  }
}
