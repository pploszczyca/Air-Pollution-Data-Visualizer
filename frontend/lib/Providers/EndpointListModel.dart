import 'dart:math';

import 'package:adpv_frontend/EndpointList/EnpointList.dart';
import 'package:adpv_frontend/Repository/AbstractEndpointRepository.dart';
import 'package:adpv_frontend/Repository/RestClient.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import '../Models/Endpoint.dart';
import '../Models/EndpointSummary.dart';

class ExpansionPanelEndpoint{
  ExpansionPanelEndpoint({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}


class EndpointListProvider with ChangeNotifier {
  Map<String, ExpansionPanelEndpoint> endpoints = {};
  List<ExpansionPanelEndpoint> endpointsList = [];
  AbstractEndpointRepository repository = RestClient(Dio());

  EndpointListProvider(List<EndpointSummary> list){
    this.makeEndpointsList(list);
}

  void setEndpoint(EndpointSummary es) {
    endpointsList.add(ExpansionPanelEndpoint(
          headerValue: es.label,
          expandedValue: es.id.toString()
        ));
}

  void makeEndpointsList(List<EndpointSummary> endpointSummary){
    for(var element in endpointSummary){
      setEndpoint(element);
    }
  }



  void updateState(String label){
    ExpansionPanelEndpoint e = this.endpointsList.firstWhere((element) => element.headerValue == label);
    e.isExpanded = !e.isExpanded;
  }


}




