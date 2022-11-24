import 'package:adpv_frontend/Repository/EndpointRepository/endpoint_gateway.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../DataModels/endpoint_data.dart';

class DataTypeTab {
  DataTypeTab({required this.typeName});

  String typeName;
}

class EndpointViewProvider with ChangeNotifier {
  List<DataTypeTab> tabs = [];
  EndpointGateway endpointGateway;
  late int alreadyLoaded;
  late EndpointData endpointData;
  bool loadedAll = false;

  int loadingLimit = 25;

  EndpointViewProvider(EndpointData data, this.endpointGateway) {
    initProvider(data);
  }

  void initProvider(EndpointData data) {
    tabs = [];
    for (var dataType in data.getAllRecentFields()) {
      setDataTypeTab(dataType);
    }
    endpointData = data;
    alreadyLoaded = data.dataList.length;
    if (alreadyLoaded < loadingLimit) {
      loadedAll = true;
    }
  }

  void setDataTypeTab(dynamic name) {
    tabs.add(DataTypeTab(typeName: name.toString()));
  }

  Future<EndpointData> clearAndUpdate(int id) =>
      endpointGateway.getEndpointData(id, loadingLimit, 0, true).then((data) {
        initProvider(data);
        notifyListeners();
        return data;
      });

  void loadMore(int endpointId) {
    if (!loadedAll) {
      endpointGateway
          .getEndpointData(endpointId, loadingLimit, alreadyLoaded, true)
          .then((
        value,
      ) {
        alreadyLoaded += loadingLimit;
        if (value.dataList.isNotEmpty) {
          endpointData.addAll(value);
          notifyListeners();
        } else {
          loadedAll = true;
        }
      });
    }
  }

  String getChartUnitName(String name, EndpointData endpointData) =>
      endpointData.enableFieldsList
          .firstWhere((element) => element.label == name)
          .unit
          .name;

  ListTile makeListElement(String typeName, int index) {
    final DateTime dateTime =
        DateTime.parse(endpointData.dataList[index]["timestamp"]);
    final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
    final DateFormat timeFormatter = DateFormat('HH:mm:ss');
    const fontFamily = "Sofia Sans";
    return ListTile(
      dense: true,
      title: Text(
        timeFormatter.format(dateTime),
        style: const TextStyle(fontFamily: fontFamily, fontSize: 16),
      ),
      subtitle: Text(
        dateFormatter.format(dateTime),
        style: const TextStyle(fontFamily: fontFamily, fontSize: 12),
      ),
      trailing: Text(
        endpointData.dataList[index][typeName].toStringAsFixed(2) +
            " " +
            getChartUnitName(typeName, endpointData),
        style: const TextStyle(
          fontFamily: fontFamily,
          fontSize: 18,
          color: Colors.pink,
        ),
      ),
    );
  }
}
