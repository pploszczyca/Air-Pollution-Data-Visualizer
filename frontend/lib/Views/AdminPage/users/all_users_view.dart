import 'package:adpv_frontend/Models/all_users_list_provider.dart';
import 'package:adpv_frontend/Views/AdminPage/users/edit_user_roles_dialog.dart';
import 'package:adpv_frontend/Views/AdminPage/utils.dart';
import 'package:adpv_frontend/Widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Repository/AdminRepository/users_list_repository.dart';
import '../confirmation_dialog_modal.dart';

class ArgsContainer {
  UserListData userListData;
  AllUsersListProvider provider;

  ArgsContainer(this.userListData, this.provider);
}

class AllUsersView extends StatefulWidget {
  final UsersListRepository repository = UsersListRepository();

  AllUsersView({Key? key}) : super(key: key);

  @override
  State<AllUsersView> createState() => _AllUsersViewState();
}

class _AllUsersViewState extends State<AllUsersView> {
  final _selections = [true, false];
  late Future<List<UserListData>> users;

  @override
  void initState() {
    super.initState();
    users = widget.repository.getAllUsers();
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(appBar: buildAdminAppBar("Users list"), body: _buildBody());

  Widget _buildBody() => FutureBuilder<List<UserListData>>(
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
                      _buildSortBar(provider),
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

  void _onDeletePressed(ArgsContainer args) {
    showAlertDialog(
      context,
      'Delete ' + args.userListData.email + '?',
      "You are about to delete this user",
      () => {
        widget.repository.deleteUser(args.userListData.id).then((value) {
          users = widget.repository.getAllUsers();
          users.then((value) => args.provider.init(value));
        })
      },
    );
  }

  void _editUser(ArgsContainer args) {
    editUserRoleDialog(context, args.userListData, args.provider);
  }

  Future<void> _onPullDownRefresh(AllUsersListProvider provider) async {
    users = widget.repository.getAllUsers();
    await users.then((value) => provider.init(value));
  }

  Card _buildUserCard(
    UserListData userListData,
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
            _buildInfoContainer("Email", userListData.email),
            _buildInfoContainer(
              "Roles",
              userListData.roles.join(', '),
            ),
            _buildInfoContainer(
              "Groups",
              userListData.groups.map((e) => e.name).join(', '),
            ),
            buildButtonRow(userListData, provider),
          ],
        ),
      );

  Row buildButtonRow(
    UserListData userListData,
    AllUsersListProvider provider,
  ) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildDeleteContainer(
            _onDeletePressed,
            ArgsContainer(userListData, provider),
          ),
          buildEditContainer(
            _editUser,
            ArgsContainer(userListData, provider),
          )
        ],
      );

  Container _buildInfoContainer(String title, String data) => Container(
        padding:
            const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'SofiaSans',
                  fontWeight: FontWeight.w700,
                  color: Colors.black45,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Text(
                data,
                overflow: TextOverflow.fade,
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'SofiaSans',
                  color: Colors.black45,
                ),
              ),
            )
          ],
        ),
      );

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
