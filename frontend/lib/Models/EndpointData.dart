import 'package:adpv_frontend/Common/Common.dart';
import 'package:adpv_frontend/Models/EnableField.dart';

class EndpointData {
  List<Map<dynamic, dynamic>> dataList;
  List<EnableField> enableFieldsList;
  List<Map<dynamic, dynamic>> technicalInfo;

  EndpointData(this.dataList, this.technicalInfo, this.enableFieldsList);

  EndpointData.onlyData(this.dataList)
      : enableFieldsList = [],
        technicalInfo = [];

  EndpointData.empty()
      : dataList = List.of([]),
        enableFieldsList = [],
        technicalInfo = [];

  List<dynamic> getCertainField(String field) {
    return dataList.map((e) => e[field]).toList();
  }

  bool isChartData(String field) {
    return enableFieldsList
            .firstWhere((element) => element.label == field)
            .isForChart() ||
        field == ignoreField;
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
