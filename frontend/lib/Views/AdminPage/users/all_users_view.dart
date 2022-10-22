import 'package:adpv_frontend/Models/all_users_list_provider.dart';
import 'package:adpv_frontend/Views/AdminPage/users/edit_user_roles_dialog.dart';
import 'package:adpv_frontend/Views/AdminPage/utils.dart';
import 'package:adpv_frontend/Widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Repository/AdminRepository/admin_users_repository.dart';
import '../../../Widgets/AdminWidgets/admin_app_bar.dart';
import '../../../Widgets/AdminWidgets/admin_buttons.dart';
import '../../../Widgets/AdminWidgets/confirmation_dialog_modal.dart';
import '../../../Widgets/AdminWidgets/group_card.dart';
import '../../../Widgets/SortingWidgets/sort_bar.dart';

class AllUsersView extends StatefulWidget {
  final AdminUsersRepository repository = AdminUsersRepository();

  AllUsersView({Key? key}) : super(key: key);

  @override
  State<AllUsersView> createState() => _AllUsersViewState();
}

class _AllUsersViewState extends State<AllUsersView> {
  final selections = [true, false];
  late Future<List<UserData>> users;

  @override
  void initState() {
    super.initState();
    users = widget.repository.getAllUsers();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: adminAppBar("Admin panel", "Users list"),
        body: _buildBody(),
      );

  Widget _buildBody() => FutureBuilder<List<UserData>>(
        future: users,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return loadingInCenter();
          } else {
            return ChangeNotifierProvider(
              create: (context) => AllUsersListProvider(users),
              child: Consumer<AllUsersListProvider>(
                builder: (context, provider, _) => RefreshIndicator(
                  onRefresh: () => _onPullDownRefresh(provider),
                  child: Column(
                    children: [
                      buildSortBar(
                        provider.sortingModel,
                        () => provider.notify(),
                        provider.usersList,
                        provider.getters,
                      ),
                      Expanded(
                        child: _buildList(provider),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      );

  ListView _buildList(AllUsersListProvider provider) => ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        children:
            provider.usersList.map((e) => _buildUserCard(e, provider)).toList(),
      );

  Card _buildUserCard(
    UserData userListData,
    AllUsersListProvider provider,
  ) =>
      Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ExpansionTile(
          title: SizedBox(
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    userListData.id.toString(),
                    style: const TextStyle(
                      fontFamily: 'SofiaSans',
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      userListData.email,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: const TextStyle(
                        fontFamily: 'SofiaSans',
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          collapsedBackgroundColor: Colors.white,
          tilePadding: const EdgeInsets.all(20),
          childrenPadding: const EdgeInsets.all(0),
          children: [
            buildInfoContainer(
              "Email",
              userListData.email,
              MediaQuery.of(context).size.width,
            ),
            buildInfoContainer(
              "Roles",
              userListData.roles.join(', '),
              MediaQuery.of(context).size.width,
            ),
            buildInfoContainer(
              "Groups",
              userListData.groups.map((e) => e.name).join(', '),
              MediaQuery.of(context).size.width,
            ),
            buildButtonRow(userListData, provider),
          ],
        ),
      );

  Row buildButtonRow(
    UserData userListData,
    AllUsersListProvider provider,
  ) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          deleteButtonContainer(
            () => _onDeletePressed(
              userListData,
              provider,
            ),
          ),
          editButtonContainer(
            () => _editUser(userListData, provider),
          )
        ],
      );

  void _onDeletePressed(UserData userListData, AllUsersListProvider provider) {
    showAlertDialog(
      context,
      'Delete ' + userListData.email + '?',
      "You are about to delete this user",
      () => {
        widget.repository.deleteUser(userListData.id).then((value) {
          users = widget.repository.getAllUsers();
          users.then((value) => provider.init(value));
        })
      },
    );
  }

  void _editUser(UserData userListData, AllUsersListProvider provider) {
    editUserRoleDialog(context, userListData, provider);
  }

  Future<void> _onPullDownRefresh(AllUsersListProvider provider) async {
    users = widget.repository.getAllUsers();
    await users.then((value) => provider.init(value));
  }

  Container _buildSortBar(AllUsersListProvider membersListProvider) =>
      Container(
        margin: const EdgeInsets.only(top: 20),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          children: [
            ToggleButtons(
              isSelected: _selections,
              fillColor: Colors.transparent,
              renderBorder: false,
              children: [
                _buildToggleButton(
                  "ID",
                  membersListProvider.idIcon,
                  membersListProvider.idColor,
                ),
                _buildToggleButton(
                  "EMAIL",
                  membersListProvider.emailIcon,
                  membersListProvider.emailColor,
                ),
              ],
              onPressed: (int index) {
                membersListProvider.changeSorting(index);
              },
            )
          ],
        ),
      );

  Container _buildToggleButton(String buttonName, IconData icon, Color color) =>
      Container(
        margin: const EdgeInsets.only(right: 10, left: 10),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: buttonName,
                style: TextStyle(
                  fontFamily: 'SofiaSans',
                  fontSize: 25,
                  fontWeight: FontWeight.normal,
                  color: color,
                ),
              ),
              WidgetSpan(
                child: Icon(
                  icon,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      );
}
