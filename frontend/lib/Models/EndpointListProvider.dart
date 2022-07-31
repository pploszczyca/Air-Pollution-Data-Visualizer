import 'package:adpv_frontend/Repository/EndpointRepository/EndpointGateway.dart';
import 'package:flutter/material.dart';

import '../DataModels/EndpointData.dart';
import '../DataModels/EndpointSummary.dart';

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
    recentData.removeWhere((key, value) => key == 'timestamp');
  }
}

class EndpointListProvider with ChangeNotifier {
  List<ExpansionPanelEndpoint> endpointsList = [];
  EndpointGateway endpointGateway;

  EndpointListProvider(List<EndpointSummary> list, this.endpointGateway) {
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
