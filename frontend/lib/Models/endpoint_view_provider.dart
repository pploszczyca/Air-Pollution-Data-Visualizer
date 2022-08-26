import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../DataModels/endpoint_data.dart';

class DataTypeTab {
  DataTypeTab({required this.typeName});

  String typeName;
}

class EndpointViewProvider with ChangeNotifier {
  List<DataTypeTab> tabs = [];

  EndpointViewProvider(EndpointData data) {
    for (var dataType in data.getAllRecentFields()) {
      setDataTypeTab(dataType);
    }
  }

  String getChartUnitName(String name, EndpointData endpointData) =>
      endpointData.enableFieldsList
          .firstWhere((element) => element.label == name)
          .unit
          .name;

  void setDataTypeTab(dynamic name) {
    tabs.add(DataTypeTab(typeName: name.toString()));
  }
}
