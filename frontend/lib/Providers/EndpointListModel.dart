import 'dart:math';

import 'package:adpv_frontend/EndpointList/EnpointList.dart';
import 'package:adpv_frontend/Models/EndpointData.dart';
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
    required this.recentData,
    required this.label,
    required this.id,
    required this.fields,
  });

  Map<String, dynamic> recentData;
  String label;
  int id;
  List<String> fields;

  void setRecentData(EndpointData data) {
    fields = data.getAllRecentFields();
    print(fields);

  }
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
          label: es.label,
          id: es.id,
          recentData: {},
      fields: []
        ));
        }

  void makeEndpointsList(List<EndpointSummary> endpointSummary){
    for(var element in endpointSummary){
      setEndpoint(element);
    }
  }



}




