import 'dart:math';

import 'package:adpv_frontend/Repository/EndpointRepository/endpoint_gateway.dart';
import 'package:flutter/cupertino.dart';

import '../Common/consts.dart';
import '../DataModels/endpoint.dart';
import '../DataModels/endpoint_data.dart';
import '../DataModels/endpoint_summary.dart';

class CompareEndpointsProvider extends ChangeNotifier {
  Map<String, EndpointSummary> endpointSummaryMap = {};
  Map<String, Endpoint> endpointsMap = {};
  Map<String, bool> selectedChips = {};
  List<String> commonFields = [];
  List<String> selectedEndpoints = [];
  EndpointGateway endpointGateway;
  TextEditingController measureController;

  CompareEndpointsProvider(this.endpointGateway, this.measureController);

  void clear() {
    endpointSummaryMap = {};
    endpointsMap = {};
    selectedChips = {};
    commonFields = [];
    selectedEndpoints = [];
  }

  void selectChips(String label, bool value) {
    selectedChips[label] = value;
    notifyListeners();
  }

  void updateCommonFields() {
    if (endpointsMap.isNotEmpty && selectedEndpoints.isNotEmpty) {
      final Map<String, int> counter = {};
      final List fields =
          endpointsMap[selectedEndpoints[0]]!.data.dataList[0].keys.toList();

      final List<Endpoint> selected = endpointsMap.entries
          .where((element) => selectedEndpoints.contains(element.key))
          .map((e) => e.value)
          .toList();
      for (String s in fields) {
        for (Endpoint e in selected) {
          if (e.hasField(s)) {
            counter[s] = counter[s] == null ? 1 : counter[s]! + 1;
          }
        }
      }
      final maxValue = counter.values.reduce(max);
      final List<String> newCommonFields = [];
      counter.forEach((key, value) {
        if (value == maxValue) {
          newCommonFields.add(key);
        }
      });
      newCommonFields.remove(ignoreField);
      commonFields = newCommonFields;
    } else {
      commonFields = [];
    }
    notifyListeners();
  }

  void updateEndpointSelectedList(List<String> selected) {
    final int measurements = normalizeMeasurementsAmount();
    selectedEndpoints = selected;
    for (var endpointLabel in selectedEndpoints) {
      final EndpointSummary es = endpointSummaryMap[endpointLabel]!;
      endpointGateway
          .getEndpointData(es.id, measurements, null, false)
          .then((value) {
        value.dataList = value.dataList.sublist(0, measurements);
        endpointsMap[es.label] = Endpoint.fromSummary(es, value);
        updateCommonFields();
      });
    }
  }

  void updateMeasurementsAmount() async {
    final int measurements = normalizeMeasurementsAmount();
    for (var endpointLabel in selectedEndpoints) {
      final EndpointSummary es = endpointSummaryMap[endpointLabel]!;
      final EndpointData value = await endpointGateway
          .getEndpointData(es.id, measurements, null, false);
      value.dataList = value.dataList.sublist(0, measurements);
      endpointsMap[es.label] = Endpoint.fromSummary(es, value);
      updateCommonFields();
    }
  }

  int normalizeMeasurementsAmount() {
    int measurements = int.parse(measureController.text);
     if(measurements < 5){
      measurements = 5;
      measureController.text = measurements.toString();
    }
    if(measurements > 100){
      measurements = 100;
      measureController.text = measurements.toString();
    }
    notifyListeners();
    return measurements;
  }

  void addToEndpointList(Endpoint endpoint) {
    endpointsMap[endpoint.label] = endpoint;
    updateCommonFields();
  }

  void makeEndpointSummaryMap(List<EndpointSummary> list) {
    for (var element in list) {
      endpointSummaryMap[element.label] = element;
    }
    notifyListeners();
  }

  List<Endpoint> getEndpointsForDrawing() {
    final List<Endpoint> result = [];
    for (String selected in selectedEndpoints) {
      if(endpointsMap[selected] == null || endpointsMap[selected]!.data.isEmpty()){
        return List.empty();
      }
      if (endpointsMap[selected] != null) {
        result.add(endpointsMap[selected]!);
      }
    }
    return result;
  }

  List<String> getFieldsForDrawing() => selectedChips.keys
      .where((field) => selectedChips[field]! == true)
      .toList();
}
