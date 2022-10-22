import 'package:adpv_frontend/Repository/AdminRepository/admin_endpoints_repository.dart';
import 'package:flutter/material.dart';

import '../DataModels/Utils/sorting_model.dart';

class AllEndpointsProvider with ChangeNotifier {
  SortingModel sortingModel = SortingModel("NR", "LABEL");
  List<EndpointAdminData> endpointsList = [];
  List getters = [(e) => e.endpointNumber, (e) => e.label];

  AdminEndpointsRepository repository = AdminEndpointsRepository();

  AllEndpointsProvider(Future<List<EndpointAdminData>> future) {
    future.then(init);
  }

  void init(List<EndpointAdminData> list) {
    endpointsList = list;
    notifyListeners();
  }

  void notify() {
    notifyListeners();
  }
}
