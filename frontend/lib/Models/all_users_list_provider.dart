import 'package:flutter/material.dart';

import '../DataModels/Utils/sorting_model.dart';
import '../Repository/AdminRepository/admin_users_repository.dart';

class AllUsersListProvider with ChangeNotifier {
  List<UserData> usersList = [];
  SortingModel sortingModel = SortingModel("ID", "EMAIL");
  List getters = [(e) => e.id, (e) => e.email];

  AdminUsersRepository repository = AdminUsersRepository();

  AllUsersListProvider(Future<List<UserData>> future) {
    future.then(init);
  }

  void init(List<UserData> list) {
    usersList = list;
    notifyListeners();
  }

  void notify() {
    notifyListeners();
  }

  Future<bool> save(UserData userListData, List<String> selected) async {
    final Set<String> oldRoles = usersList
        .where((element) => element.id == userListData.id)
        .first
        .roles
        .toSet();

    final Set<String> newRoles = selected.toSet();

    final rolesToRemove = oldRoles.difference(newRoles);
    final rolesToAdd = newRoles.difference(oldRoles.toSet());

    return repository.saveRoles(rolesToRemove, rolesToAdd, userListData.id);
  }
}
