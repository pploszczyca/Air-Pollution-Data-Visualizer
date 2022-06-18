import 'package:adpv_frontend/Models/EndpointData.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DataTypeTab {
  DataTypeTab({
    required this.typeName
});

  String typeName;

}

class EndpointViewProvider with ChangeNotifier{
  List<DataTypeTab> tabs = [];

  EndpointViewProvider(EndpointData data){
    for(var dataType in data.getAllRecentFields()){
      setDataTypeTab(dataType);
    }
  }

  void setDataTypeTab(dynamic name){
    tabs.add(DataTypeTab(typeName: name.toString()));
  }
}