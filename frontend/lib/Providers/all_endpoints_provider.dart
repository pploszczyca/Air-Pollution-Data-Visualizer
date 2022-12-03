import 'package:adpv_frontend/DataModels/enable_field.dart';
import 'package:adpv_frontend/Repository/AdminRepository/admin_endpoints_repository.dart';
import 'package:flutter/material.dart';

import '../DataModels/Utils/sorting_model.dart';
import '../DataModels/field_parser.dart';

class AllEndpointsProvider with ChangeNotifier {
  SortingModel sortingModel = SortingModel("NR", "LABEL");
  List<EndpointAdminData> endpointsList = [];
  Map<int, FieldParser> fieldParsers = {};
  Map<int, EnableField> enableFields = {};

  List getters = [(e) => e.endpointNumber, (e) => e.label];

  AdminEndpointsRepository repository = AdminEndpointsRepository();

  AllEndpointsProvider(Future<EndpointComplexData> future) {
    future.then(init);
  }

  void init(EndpointComplexData data) {
    endpointsList = data.endpoints;
    fieldParsers = data.fieldParsers;
    enableFields = data.enableFields;
    notifyListeners();
  }

  void notify() {
    notifyListeners();
  }
}
