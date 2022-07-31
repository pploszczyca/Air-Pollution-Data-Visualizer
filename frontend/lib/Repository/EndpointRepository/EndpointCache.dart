import 'package:flutter/material.dart';

import '../../DataModels/Endpoint.dart';
import '../../DataModels/EndpointData.dart';
import '../../DataModels/EndpointSummary.dart';

class EndpointCache {
  final List<EndpointSummary> _endpointSummaryList = [];
  final List<Endpoint> _endpointList = [];
  bool _isEndpointSummaryLoaded = false;

  EndpointCache();

  Future<List<EndpointSummary>> getEndpointSummary() async =>
      Future.value(_endpointSummaryList);

  Future<EndpointData> getEndpointData(int id, int? limit, int? offset){
    int index = _endpointList.indexWhere((element) => element.id == id);
    return Future.value(_endpointList[index].data);
  }


  bool isEndpointInCache(int endpointId) =>
      _endpointList.indexWhere((element) => element.id == endpointId) != -1;

  bool isEndpointSummaryInCache() => _isEndpointSummaryLoaded;

  void saveEndpointSummary(List<EndpointSummary> data) {
    print("SAVING ENDPOINTSUMMARY");
    for (var element in data) {
      !_endpointSummaryList.contains(element)
          ? _endpointSummaryList.add(element)
          : null;
    }
    print(_endpointSummaryList);
    _isEndpointSummaryLoaded = true;
  }

  void saveEndpoint(int id, EndpointData data) {
    print("SAVING ENDPOINT");
    final EndpointSummary summary =
    _endpointSummaryList.singleWhere((element) => element.id == id);
    if (isEndpointInCache(id)) {
      print(_endpointList.indexWhere((element) => element.id == id));
      _endpointList[_endpointList.indexWhere((element) => element.id == id)] =
          Endpoint.fromSummary(summary, data);
    }else{
      _endpointList.add(Endpoint.fromSummary(summary, data));
    }

  }
}
