class EndpointData{
  List<Map<dynamic, dynamic>> dataList;

  EndpointData(this.dataList);

  EndpointData.empty(): dataList = List.of([]);

  List<dynamic> getCertainField(String field){
    return dataList.map((e) => e[field]).toList();
  }

  @override
  String toString() {
    return 'EndpointData{dataList: $dataList}';
  }
}