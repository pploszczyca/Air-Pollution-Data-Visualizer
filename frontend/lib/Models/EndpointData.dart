import 'package:adpv_frontend/Common/Common.dart';
import 'package:adpv_frontend/Models/EnableField.dart';

class EndpointData {
  List<Map<dynamic, dynamic>> dataList;
  List<EnableField> enableFieldsList;

  EndpointData(this.dataList, this.enableFieldsList);

  EndpointData.onlyData(this.dataList) : enableFieldsList = [];

  EndpointData.empty()
      : dataList = List.of([]),
        enableFieldsList = [];

  List<dynamic> getCertainField(String field) {
    return dataList.map((e) => e[field]).toList();
  }

  List<String> getAllRecentFields() {
    return dataList[0]
        .keys
        .where((element) => element != ignoreField)
        .map((e) => e.toString())
        .toList();
  }

  @override
  String toString() {
    return 'EndpointData{dataList: $dataList}';
  }
}
