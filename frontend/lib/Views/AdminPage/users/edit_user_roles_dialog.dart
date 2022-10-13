import 'package:adpv_frontend/Models/all_users_list_provider.dart';
import 'package:adpv_frontend/Repository/AdminRepository/users_list_repository.dart';
import 'package:adpv_frontend/Views/AdminPage/confirmation_dialog_modal.dart';
import 'package:flutter/material.dart';

import '../groups/group_endpoint_view.dart';
import '../utils.dart';

const List<String> roles = ["USER", "ADMIN"];

void editUserRoleDialog(
  BuildContext context,
  UserData userListData,
  AllUsersListProvider provider,
) {
  showDialog(
    context: context,
    builder: (context) {
      final List<String> toSelect = List.from(userListData.roles);
      return StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(
            "Choose user roles:",
            style: defaultAdminTextStyle,
          ),
          contentPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildRolesListTiles(toSelect, setState),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: _buildButtons(context, userListData, provider, toSelect),
              )
            ],
          ),
        ),
      );
    },
  );
}

Column _buildRolesListTiles(List<String> toSelect, StateSetter setState) =>
    Column(
      mainAxisSize: MainAxisSize.min,
      children: roles
          .map(
            (element) => ListTile(
              title: Text(
                element,
                style: defaultAdminTextStyle,
              ),
              leading: Checkbox(
                shape: roundedRectangleBorder,
                activeColor: Colors.teal,
                value: toSelect.contains(element),
                onChanged: (bool? value) {
                  setState(() {
                    if (value ?? true) {
                      toSelect.add(element);
                    } else {
                      toSelect.remove(element);
                    }
                  });
                },
              ),
            ),
          )
          .toList(),
    );

Row _buildButtons(
  BuildContext context,
  UserData userListData,
  AllUsersListProvider provider,
  List<String> toSelect,
) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildCancelButton(context),
        _buildSaveButton(context, userListData, provider, toSelect)
      ],
    );

TextButton _buildCancelButton(BuildContext context) => TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: const BorderSide(color: Colors.red),
          ),
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text(
        "Cancel",
        style: defaultAdminTextStyle.copyWith(color: Colors.red, fontSize: 16),
      ),
    );

TextButton _buildSaveButton(
  BuildContext context,
  UserData userListData,
  AllUsersListProvider provider,
  List<String> toSelect,
) =>
    TextButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.resolveWith((states) => adminGreenColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
      onPressed: () {
        showAlertDialog(
          context,
          "Change ${userListData.email} roles?",
          "After save, previous roles will be lost",
          () {
            provider.save(userListData, toSelect).then((value) async {
              provider.init(
                await provider.repository.getAllUsers(),
              );
            });
            Navigator.of(context).pop();
          },
        );
      },
      child: Text(
        "Save",
        style: defaultAdminTextStyle.copyWith(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
