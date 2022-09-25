import 'package:adpv_frontend/DataModels/User/user.dart';
import 'package:adpv_frontend/DataModels/member_summary.dart';
import 'package:adpv_frontend/Views/AdminPage/utils.dart';
import 'package:adpv_frontend/Views/snackbar.dart';
import 'package:flutter/material.dart';

import '../../../Repository/AdminRepository/admin_gateway.dart';
import '../../../Widgets/common_widgets.dart';

MaterialStateProperty<EdgeInsetsGeometry?> buttonPadding =
MaterialStateProperty.all(const EdgeInsets.all(20));

void showAddUserModal(BuildContext context, AdminGateway gateway, int groupId) {
  showDialog(
    context: context,
    builder: (_) =>
        AlertDialog(
          title: const Text('Create new group'),
          content:
          // Container(child:Text('lolo'))
          FutureBuilder<List<UserSummary>>(
            future: gateway.getMembersNotInGroup(groupId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.none ||
                  snapshot.data == null) {
                return loadingInCenter();
              } else {
                return Container(child: AutocompleteUser(users: snapshot.data!),);
              }
            },
          ),
        ),
  );
}

List<UserSummary> castToUsersList(List<UserSummary> users) {
  return users;
}

class AutocompleteUser extends StatelessWidget {
  AutocompleteUser({
    required this.users,
    Key? key,
  }) : super(key: key);

  final List<UserSummary> users;

  static String _displayStringForOption(UserSummary option) => option.email;

  @override
  Widget build(BuildContext context) =>
      Autocomplete<UserSummary>(
        displayStringForOption: _displayStringForOption,
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text == '') {
            return const Iterable<UserSummary>.empty();
          }
          return users.where((UserSummary user) =>
              user
                  .toString()
                  .contains(textEditingValue.text.toLowerCase()));
        },
        onSelected: (UserSummary selection) {
          debugPrint('You just selected ${_displayStringForOption(selection)}');
        },
      );
}