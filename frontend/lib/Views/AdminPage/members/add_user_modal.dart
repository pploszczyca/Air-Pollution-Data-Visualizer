import 'package:adpv_frontend/DataModels/member_summary.dart';
import 'package:adpv_frontend/Views/AdminPage/utils.dart';
import 'package:flutter/material.dart';

import '../../../Repository/AdminRepository/admin_gateway.dart';
import '../../../Widgets/common_widgets.dart';

MaterialStateProperty<EdgeInsetsGeometry?> buttonPadding =
    MaterialStateProperty.all(const EdgeInsets.all(20));

void showAddUserModal(
  BuildContext context,
  AdminGateway gateway,
  int groupId,
  Function(int id) onProceedFunction,
) {
  showDialog(
    context: context,
    builder: (_) {
      int selected = -1;
      return AlertDialog(
        title: const Text('Add member'),
        content: StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) =>
                  FutureBuilder<List<UserSummary>>(
            future: gateway.getMembersNotInGroup(groupId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.none ||
                  snapshot.data == null) {
                return loadingInCenter();
              } else {
                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Autocomplete<UserSummary>(
                    displayStringForOption: _displayStringForOption,
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return snapshot.data!;
                      }
                      return snapshot.data!.where(
                        (UserSummary user) => user.email
                            .toLowerCase()
                            .contains(textEditingValue.text.toLowerCase()),
                      );
                    },
                    optionsViewBuilder: (context, onSelected, options) => Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        elevation: 4,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: ListView.separated(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(8),
                            itemCount: options.length,
                            separatorBuilder: (context, i) => const Divider(),
                            itemBuilder: (BuildContext context, int index) {
                              final UserSummary option =
                                  options.elementAt(index);
                              return GestureDetector(
                                onTap: () {
                                  onSelected(option);
                                },
                                child: ListTile(
                                  title: Text(
                                    option.email,
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    onSelected: (UserSummary selection) {
                      setState(() {
                        selected = selection.id;
                      });
                    },
                  ),
                );
              }
            },
          ),
        ),
        actions: [
          cancelButton(context),
          //todo refactor
          ElevatedButton(
            onPressed: () =>
                onProceedPressed(selected, onProceedFunction, context),
            style: proceedButtonStyle,
            child: Text("Add", style: proceedButtonTextStyle),
          )
        ],
      );
    },
  );
}

String _displayStringForOption(UserSummary option) => option.email;

void onProceedPressed(int selected, onProceedFunction, context) {
  if (selected == -1) {
    Navigator.pop(context);
  } else {
    onProceedFunction(selected);
    Navigator.pop(context);
  }
}
