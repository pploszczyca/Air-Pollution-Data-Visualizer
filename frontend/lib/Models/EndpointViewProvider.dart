import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../DataModels/EndpointData.dart';

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

  void setDataTypeTab(dynamic name) {
    tabs.add(DataTypeTab(typeName: name.toString()));
  }
}
