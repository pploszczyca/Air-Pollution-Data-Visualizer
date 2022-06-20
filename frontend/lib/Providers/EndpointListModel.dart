import 'package:adpv_frontend/Models/EndpointData.dart';
import 'package:adpv_frontend/Repository/AbstractEndpointRepository.dart';
import 'package:adpv_frontend/Repository/RestClient.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Models/EndpointSummary.dart';

class ExpansionPanelEndpoint {
  ExpansionPanelEndpoint({
    required this.recentData,
    required this.label,
    required this.id,
    required this.fields,
    required this.buttonColor,
  });

  Map<String, dynamic> recentData;
  String label;
  int id;
  List<String> fields;
  Color buttonColor;

  void setRecentData(EndpointData data) {
    fields = data.getAllRecentFields();
    recentData =
        data.dataList[0].map((key, value) => MapEntry(key.toString(), value));
    if (recentData != null) {
      recentData.removeWhere((key, value) => key.toString() == 'timestamp');
    }
  }
}

class EndpointListProvider with ChangeNotifier {
  List<ExpansionPanelEndpoint> endpointsList = [];
  AbstractEndpointRepository repository = RestClient(Dio());

  EndpointListProvider(List<EndpointSummary> list) {
    makeEndpointsList(list);
  }

  void setEndpoint(EndpointSummary es) {
    endpointsList.add(ExpansionPanelEndpoint(
        label: es.label,
        id: es.id,
        recentData: {},
        fields: [],
        buttonColor: Colors.pink));
  }

  void makeEndpointsList(List<EndpointSummary> endpointSummary) {
    for (var element in endpointSummary) {
      setEndpoint(element);
    }
  }
}