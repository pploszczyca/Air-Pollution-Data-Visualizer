import 'dart:math';

import 'package:adpv_frontend/Repository/AbstractEndpointRepository.dart';
import 'package:adpv_frontend/Repository/RestEndpointRepository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';


import '../Common/Consts.dart';
import '../DataModels/Endpoint.dart';
import '../DataModels/EndpointSummary.dart';

class CompareEndpointsModel extends ChangeNotifier {
  Map<String, EndpointSummary> endpointSummaryMap = {};
  Map<String, Endpoint> endpointsMap = {};
  Map<String, bool> selectedChips = {};
  List<String> commonFields = [];
  List<String> selectedEndpoints = [];
  AbstractEndpointRepository repository = RestEnpointRepository(Dio());

  CompareEndpointsModel();

  void selectChips( String label,  bool value) {
    selectedChips[label] = value;
    notifyListeners();
  }

  void updateCommonFields() {
    if (selectedEndpoints.isNotEmpty && endpointsMap.isNotEmpty) {
      final Map<String, int> counter = {};
      final List fields =
          endpointsMap[selectedEndpoints[0]]!.data.dataList[0].keys.toList();
      for (String s in fields) {
        for (Endpoint e in endpointsMap.values) {
          if (e.hasField(s)) {
            counter[s] = counter[s] == null ? 1 : counter[s]! + 1;
          }
        }
      }
      final maxValue = counter.values.reduce(max);
      final List<String> newCommonFields = [];
      counter.forEach(( key,  value) {
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
    selectedEndpoints = selected;
    for (var endpointLabel in selectedEndpoints) {
      if (!endpointsMap.containsKey(endpointLabel)) {
        final EndpointSummary es = endpointSummaryMap[endpointLabel]!;
        repository.getEndpointData(es.id, null, null).then((value) {
          endpointsMap[es.label] = Endpoint.fromSummary(es, value);
          updateCommonFields();
        });
      }
    }
  }

  void addToEndpointList(Endpoint endpoint) {
    endpointsMap[endpoint.label] = endpoint;
    updateCommonFields();
  }

  void makeEndpointSummaryMap(List<EndpointSummary> list) {
    for (var element in list) {
      endpointSummaryMap[element.label] = element;
    }
  }

  List<Endpoint> getEndpointsForDrawing() {
    final List<Endpoint> result = [];
    for (String selected in selectedEndpoints) {
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
