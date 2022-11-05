import 'package:adpv_frontend/DataModels/field_data.dart';
import 'package:flutter/material.dart';

import '../DataModels/Utils/sorting_model.dart';
import '../Repository/AdminRepository/admin_users_repository.dart';

class FieldsListProvider with ChangeNotifier {
  List<FieldData> fieldsList = [];
  SortingModel sortingModel = SortingModel("ID", "NAME");
  List getters = [(e) => e.id, (e) => e.name];

  AdminUsersRepository repository = AdminUsersRepository();

  FieldsListProvider(Future<List<FieldData>> future) {
    future.then(init);
  }

  void init(List<FieldData> list) {
    fieldsList = list;
    notifyListeners();
  }

  void notify() {
    notifyListeners();
  }

  void delete(int id) {
    fieldsList.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
