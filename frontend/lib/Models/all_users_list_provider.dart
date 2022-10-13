import 'package:flutter/material.dart';

import '../Repository/AdminRepository/users_list_repository.dart';

//ignore_for_file:  constant_identifier_names
const ID_SORTING_BUTTON_INDEX = 0;
const EMAIL_SORTING_BUTTON_INDEX = 1;

enum SortingField { id, email }

enum SortingOrder { asc, desc }

class Sorting {
  SortingField field = SortingField.id;
  SortingOrder order = SortingOrder.asc;
}

const ARROW_UP = Icons.keyboard_arrow_up_rounded;
const ARROW_DOWN = Icons.keyboard_arrow_down_rounded;

class AllUsersListProvider with ChangeNotifier {
  List<UserData> usersList = [];
  Color emailColor = Colors.black;
  Color idColor = Colors.pink;
  IconData emailIcon = ARROW_DOWN;
  IconData idIcon = ARROW_UP;

  UsersDataRepository repository = UsersDataRepository();

  AllUsersListProvider(Future<List<UserData>> future) {
    future.then(init);
  }

  Sorting currentSorting = Sorting();

  void init(List<UserData> list) {
    usersList = list;
    notifyListeners();
  }

  void _sortByIDAsc() {
    usersList.sort((a, b) => a.id.compareTo(b.id));
  }

  void _sortByIDDesc() {
    usersList.sort((b, a) => a.id.compareTo(b.id));
  }

  void _sortByEmailAsc() {
    usersList.sort((a, b) => a.email.compareTo(b.email));
  }

  void _sortByEmailDesc() {
    usersList.sort((b, a) => a.email.compareTo(b.email));
  }

  SortingOrder _reverseSortingOrder() =>
      currentSorting.order == SortingOrder.asc
          ? SortingOrder.desc
          : SortingOrder.asc;

  void changeSorting(int index) {
    if (index == ID_SORTING_BUTTON_INDEX) {
      _setSortingById();
    } else if (index == EMAIL_SORTING_BUTTON_INDEX) {
      _setSortingByEmail();
    }
    notifyListeners();
  }

  void _setSortingById() {
    if (currentSorting.field == SortingField.id) {
      currentSorting.order = _reverseSortingOrder();
      idIcon = (idIcon == ARROW_UP) ? ARROW_DOWN : ARROW_UP;
    } else {
      currentSorting.field = SortingField.id;
      currentSorting.order = SortingOrder.asc;
      idColor = Colors.pink;
      emailColor = Colors.black;
    }
    currentSorting.order == SortingOrder.asc ? _sortByIDAsc() : _sortByIDDesc();
  }

  void _setSortingByEmail() {
    if (currentSorting.field == SortingField.email) {
      currentSorting.order = _reverseSortingOrder();
      emailIcon = (emailIcon == ARROW_UP) ? ARROW_DOWN : ARROW_UP;
    } else {
      currentSorting.field = SortingField.email;
      currentSorting.order = SortingOrder.asc;
      emailColor = Colors.pink;
      idColor = Colors.black;
    }
    currentSorting.order == SortingOrder.asc
        ? _sortByEmailAsc()
        : _sortByEmailDesc();
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
