import 'package:flutter/material.dart';

import '../../../DataModels/user_summary.dart';
import '../../../Repository/AdminRepository/admin_gateway.dart';
import '../../../Widgets/AdminWidgets/admin_buttons.dart';
import '../../../Widgets/AdminWidgets/admin_styles.dart';
import '../../../Widgets/common_widgets.dart';

MaterialStateProperty<EdgeInsetsGeometry?> buttonPadding =
    MaterialStateProperty.all(const EdgeInsets.all(20));

void showAddUserModal(
  BuildContext context,
  AdminGateway gateway,
  int groupId,
  Function(String email) onProceedFunction,
) {
  showDialog(
    context: context,
    builder: (_) {
      final FocusNode focusNode = FocusNode();
      final GlobalKey autocompleteKey = GlobalKey();
      final TextEditingController emailController = TextEditingController();
      return AlertDialog(
        title: const Text('Add member'),
        content: FutureBuilder<List<UserSummary>>(
          future: gateway.getMembersNotInGroup(groupId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.none ||
                snapshot.data == null) {
              return loadingInCenter();
            } else {
              return SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Scaffold(
                  appBar: AppBar(
                    shadowColor: Colors.transparent,
                    elevation: 0,
                    backgroundColor: Colors.white,
                    automaticallyImplyLeading: false,
                    title: TextFormField(
                      controller: emailController,
                      focusNode: focusNode,
                      decoration: const InputDecoration(
                        hintText: "User's email",
                      ),
                      onFieldSubmitted: (String value) {
                        RawAutocomplete.onFieldSubmitted<String>(
                          autocompleteKey,
                        );
                      },
                    ),
                  ),
                  body: RawAutocomplete<String>(
                    key: autocompleteKey,
                    textEditingController: emailController,
                    focusNode: focusNode,
                    optionsBuilder: (TextEditingValue textEditingValue) =>
                        castToEmails(snapshot.data!).where(
                      (userEmail) => userEmail
                          .toLowerCase()
                          .contains(textEditingValue.text.toLowerCase()),
                    ),
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
                              final String option = options.elementAt(index);
                              return GestureDetector(
                                onTap: () {
                                  onSelected(option);
                                },
                                child: ListTile(
                                  title: Text(
                                    option,
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
                  ),
                ),
              );
            }
          },
        ),
        actions: [
          cancelButton(context),
          //todo refactor
          ElevatedButton(
            onPressed: () => onProceedPressed(
              emailController.text,
              onProceedFunction,
              context,
            ),
            style: proceedButtonStyle,
            child: Text("Add", style: proceedButtonTextStyle),
          )
        ],
      );
    },
  );
}

List<String> castToEmails(List<UserSummary> options) =>
    options.map((e) => e.email).toList();

void onProceedPressed(String email, onProceedFunction, context) {
  if (email == "") {
    Navigator.pop(context);
  } else {
    onProceedFunction(email);
    Navigator.pop(context);
  }
}
