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
import '../Providers/compare_endpoints_provider.dart';
import '../Widgets/AdminWidgets/admin_styles.dart';
import '../Widgets/AdminWidgets/confirmation_dialog_modal.dart';
import '../Widgets/common_widgets.dart';

class CompareChartsView extends StatefulWidget {
  const CompareChartsView({required this.endpointGateway, Key? key})
      : super(key: key);
  final EndpointGateway endpointGateway;

  @override
  State<CompareChartsView> createState() => _CompareChartsViewState();
}

class _CompareChartsViewState extends State<CompareChartsView> {
  TextEditingController measurementsController =
      TextEditingController(text: "25");
  Widget chart = Container();
  late CompareEndpointsProvider model =
      CompareEndpointsProvider(widget.endpointGateway, measurementsController);
  late Future<List<EndpointSummary>> endpointSummary =
      widget.endpointGateway.getEndpointSummary(needUpdate: true).then((value) {
    model.makeEndpointSummaryMap(value);
    return value;
  });

  // ignore: always_declare_return_types
  _pullDownRefresh() async {
    endpointSummary = widget.endpointGateway
        .getEndpointSummary(needUpdate: true)
        .then((value) {
      widget.endpointGateway.clearEndpointDataCache();
      model.clear();
      model.makeEndpointSummaryMap(value);
      setState(() {});
      return value;
    });
  }

  FutureOr<EndpointData> onError<E extends Object>(
    E error,
    StackTrace stackTrace,
  ) {
    UserGateway().resetMemoryToken().then(
          (value) =>
              Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false),
        );
    return Future.error(error.toString());
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => model,
        child: RefreshIndicator(
          onRefresh: () => _pullDownRefresh(),
          child: Scaffold(
            appBar: buildFancyAppBar(compareEndpointsViewAppBar),
            body: Container(
              height: MediaQuery.of(context).size.height,
              decoration: buildBackgroundBoxDecoration(),
              child: FutureBuilder<List<EndpointSummary>>(
                future: endpointSummary,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.none ||
                      snapshot.data == null) {
                    return loadingInCenter();
                  } else {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 25,
                          ),
                          buildDropDownSelection(context, snapshot),
                          TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter measures amount',
                            ),
                            controller: measurementsController,
                            onFieldSubmitted: (String? text) {
                              model.updateMeasurementsAmount();
                            },
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 10),
                          Consumer<CompareEndpointsProvider>(
                            builder: (context, endpointModel, child) => Wrap(
                              children: _createChips(endpointModel),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Consumer<CompareEndpointsProvider>(
                            builder: (context, endpointModel, child) =>
                                _createChart(endpointModel),
                          ),
                          Center(
                            child: Flexible(
                              child: TextButton(
                                onPressed: () => showAlertDialog(
                                  context,
                                  "Reload resources?",
                                  "You're about to reload page content. This action may affect endpoints visibility.",
                                  () async => await _pullDownRefresh(),
                                ),
                                child: Text(
                                  "Pull down or tap to refresh available endpoints",
                                  textAlign: TextAlign.center,
                                  style: defaultAdminTextStyle.copyWith(
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    );
                  }
                },
              ),
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
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            width: MediaQuery.of(context).size.width * 0.8,
            child: Consumer<CompareEndpointsProvider>(
              builder: (context, endpointModel, _) => Theme(
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
              ),
            ),
          ),
        ],
      );

  List<Widget> _createChips(CompareEndpointsProvider endpointModel) =>
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

  Widget _createChart(CompareEndpointsProvider endpointModel) {
    if (endpointModel.selectedEndpoints.isEmpty) {
      return Column();
    }
    final List<Endpoint> endpoints = endpointModel.getEndpointsForDrawing();
    final List<String> fields = endpointModel.getFieldsForDrawing();

    if (endpoints.where((element) => element.data.isEmpty()).isEmpty &&
        endpoints.isNotEmpty) {
      return Column(
        children: fields
            .map((field) => MultiDataChart(field: field, endpoints: endpoints))
            .toList(),
      );
    }
    return Column();
  }
}
