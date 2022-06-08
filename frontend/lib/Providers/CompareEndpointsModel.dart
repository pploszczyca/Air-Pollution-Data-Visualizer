import 'package:adpv_frontend/Repository/AbstractEndpointRepository.dart';
import 'package:adpv_frontend/Repository/RestClient.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../Models/Endpoint.dart';
import '../Models/EndpointSummary.dart';

class EndpointModel extends ChangeNotifier {
  Map<String, EndpointSummary> endpointSummaryMap = {};
  Map<String, Endpoint> endpointsMap = {};
  Map<String, bool> selectedChips = {};
  List<String> commonFields = [];
  List<String> selectedEndpoints = [];
  AbstractEndpointRepository repository = RestClient(Dio());

  EndpointModel();

  void selectChips(String label, bool value) {
    selectedChips[label] = value;
    if (value) {
      selectedChips[label] = true;
    } else {
      selectedChips[label] = false;
    }
    notifyListeners();
  }

  void updateCommonFields() {
    if (selectedEndpoints.length > 0){
      Map<String, int> counter = {};
      List fields = endpointsMap[selectedEndpoints[0]]!.data.dataList[0].keys.toList();
      for(String s in fields){
        for(Endpoint e in endpointsMap.values){
          if(e.hasField(s)) {
            counter[s] = counter[s] == null ? 1 : counter[s]! + 1;
          }
        }
      }
      var max =0;
      counter.forEach((key, value) {
        if(value>max){
          max= value;
        }
      });
      List<String> newCommonFields = [];
      counter.forEach((key, value) {
        if(value == max){
          newCommonFields.add(key);
        }
      });
      newCommonFields.remove("timestamp");
      commonFields = newCommonFields;
    }
    else{
      commonFields = [];
    }
    notifyListeners();
  }

  void updateEndpointSelectedList(List<String> selected){
    selectedEndpoints = selected;
    for (var endpointLabel in selectedEndpoints) {
      if(!endpointsMap.containsKey(endpointLabel)){
        EndpointSummary es = endpointSummaryMap[endpointLabel]!;
        repository.getEndpointData(es.id).then((value){
          endpointsMap[es.label] = Endpoint.fromSummary(es, value);
        });
      }
    }
    updateCommonFields();
  }

  void addToEndpointList(Endpoint endpoint) {
    endpointsMap[endpoint.label]=endpoint;
    updateCommonFields();
  }

  void makeEndpointSummaryMap(List<EndpointSummary> list) {
    list.forEach((element) {
      endpointSummaryMap[element.label] = element;
    });
    //notifyListeners();
  }

  List<Endpoint> getEndpointsForDrawing(){
    List<Endpoint> result = [];
    for(String selected in selectedEndpoints){
      if(endpointsMap[selected] != null){
        result.add(endpointsMap[selected]!);
      }
    }
    return result;
  }

  List<String> getFieldsForDrawing(){
    List<String> result = [];
    for(String field in selectedChips.keys){
      if(selectedChips[field] == true){
        result.add(field);
      }
    }
    return result;
  }
}
