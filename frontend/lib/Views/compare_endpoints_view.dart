import 'dart:async';

import 'package:adpv_frontend/Repository/EndpointRepository/endpoint_gateway.dart';
import 'package:adpv_frontend/Repository/UserRepository/user_gateway.dart';
import 'package:adpv_frontend/Widgets/CompareEndpoints/multi_data_chart.dart';
import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';
import 'package:provider/provider.dart';

import '../DataModels/endpoint.dart';
import '../DataModels/endpoint_data.dart';
import '../DataModels/endpoint_summary.dart';
import '../Models/compare_endpoints_provider.dart';
import '../Widgets/common_widgets.dart';

class CompareChartsView extends StatefulWidget {
  const CompareChartsView({required this.endpointGateway, Key? key})
      : super(key: key);
  final EndpointGateway endpointGateway;

  @override
  State<CompareChartsView> createState() => _CompareChartsViewState();
}

class _CompareChartsViewState extends State<CompareChartsView> {
  Widget chart = Container();
  late CompareEndpointsModel model =
      CompareEndpointsModel(widget.endpointGateway, onError);

  // ignore: always_declare_return_types
  _pullDownRefresh() async {
    widget.endpointGateway.clearEndpointDataCache();
    model.clear();
  }

  FutureOr<EndpointData> onError<E extends Object>(
      E error, StackTrace stackTrace,) {
    // UserGateway().resetMemoryToken().then(
    //       (value) =>
    //           Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false),
    //     );
    return Future.error(error.toString());
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => model,
        child: RefreshIndicator(
          onRefresh: () => _pullDownRefresh(),
          child: Scaffold(
            appBar: buildAppBar(compareEndpointsViewAppBar),
            body: FutureBuilder<List<EndpointSummary>>(
              future: widget.endpointGateway.getEndpointSummary(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.none ||
                    snapshot.data == null) {
                  return loadingInCenter();
                } else {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        buildDropDownSelection(context, snapshot),
                        const SizedBox(height: 10),
                        Consumer<CompareEndpointsModel>(
                          builder: (context, endpointModel, child) => Wrap(
                            children: _createChips(endpointModel),
                          ),
                        ),
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
        ),
      );

  Row buildDropDownSelection(
    BuildContext context,
    AsyncSnapshot<List<EndpointSummary>> snapshot,
  ) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Consumer<CompareEndpointsModel>(
              builder: (context, endpointModel, _) {
                endpointModel.makeEndpointSummaryMap(snapshot.data!);
                return Theme(
                  // 200IQ move
                  data: ThemeData.from(
                    colorScheme: ColorScheme.fromSwatch(
                      backgroundColor: Colors.white,
                      cardColor: Colors.pink,
                      primarySwatch: Colors.pink,
                    ),
                  ),
                  child: DropDownMultiSelect(
                    isDense: true,
                    options: endpointModel.endpointSummaryMap.keys.toList(),
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
              },
            ),
          ),
        ],
      );

  List<Widget> _createChips(CompareEndpointsModel endpointModel) =>
      endpointModel.commonFields.map((endpointName) {
        endpointModel.selectedChips.putIfAbsent(endpointName, () => false);
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: InputChip(
            label: Text(endpointName),
            selected: endpointModel.selectedChips[endpointName]!,
            onSelected: (bool value) {
              setState(() {
                endpointModel.selectChips(endpointName, value);
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
