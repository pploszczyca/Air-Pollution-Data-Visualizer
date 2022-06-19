import 'package:adpv_frontend/Common/Common.dart';

class EndpointData{
  List<Map<dynamic, dynamic>> dataList;

  EndpointData(this.dataList);

  EndpointData.empty(): dataList = List.of([]);

  List<dynamic> getCertainField(String field){
    return dataList.map((e) => e[field]).toList();
  }
  List<String> getAllRecentFields(){
    return dataList[0].keys.where((element) => element != ignoreField).map((e) => e.toString()).toList();
  }

  @override
  String toString() {
    return 'EndpointData{dataList: $dataList}';
  }
}