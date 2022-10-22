import 'dart:async';

import 'package:adpv_frontend/DataModels/User/user.dart';
import 'package:adpv_frontend/DataModels/group_data.dart';
import 'package:adpv_frontend/DataModels/member_info.dart';
import 'package:adpv_frontend/Models/members_list_provider.dart';
import 'package:adpv_frontend/Views/AdminPage/confirmation_dialog_modal.dart';
import 'package:adpv_frontend/Views/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../DataModels/user_summary.dart';
import '../../../Repository/AdminRepository/admin_gateway.dart';
import '../../../Repository/UserRepository/user_gateway.dart';
import '../../../Widgets/AdminWidgets/group_card.dart';
import '../../../Widgets/common_widgets.dart';
import '../utils.dart';
import 'add_user_modal.dart';

class MembersView extends StatefulWidget {
  MembersView({
    required this.groupId,
    required this.groupName,
    Key? key,
  }) : super(key: key);
  final int groupId;
  final String groupName;

  final _selections = [true, false];

  final AdminGateway gateway = AdminGateway();

  @override
  State<MembersView> createState() => _MembersViewState();
}

class _MembersViewState extends State<MembersView> {
  late MembersListProvider membersListProvider =
  MembersListProvider(widget.groupId);

  FutureOr<GroupData> onError<E extends Object>(E error,
      StackTrace stackTrace,) {
    UserGateway().resetMemoryToken().then(
          (value) =>
          Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false),
    );
    return Future.error(error.toString());
  }

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider(
        create: (context) => membersListProvider,
        child: RefreshIndicator(
          onRefresh: () =>
              widget.gateway.getGroupData(widget.groupId).onError(onError),
          child: Scaffold(
            appBar:
            adminAppBar("Administrator", 'Members of ' + widget.groupName),
            body: _buildBody(),
            floatingActionButton: _buildAddButton(),
          ),
        ),
      );

  FutureBuilder _buildBody() =>
      FutureBuilder(
        future: widget.gateway.getGroupData(widget.groupId).onError(onError),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.data == null) {
            return loadingInCenter();
          } else {
            membersListProvider.makeMemberList(snapshot.data!);
            return SingleChildScrollView(
              controller: ScrollController(),
              child: Consumer<MembersListProvider>(
                builder: (context, __, _) =>
                    Column(
                      children: [
                        _buildSortBar(membersListProvider),
                        _buildMembersList(
                            membersListProvider.membersList.length,)
                      ],
                    ),
              ),
            );
          }
        },
      );

  Container _buildSortBar(MembersListProvider membersListProvider) =>
      Container(
        margin: const EdgeInsets.only(top: 20),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          children: [
            ToggleButtons(
              isSelected: widget._selections,
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

  ListView _buildMembersList(int itemCount) =>
      ListView.builder(
        controller: ScrollController(),
        itemCount: itemCount,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemBuilder: (context, i) =>
            _buildGroupCard(membersListProvider.membersList[i]),
      );

  Card _buildGroupCard(MemberInfo member) =>
    groupCard(buildCardTitle(member), buildCardChildren(member));


  Widget buildCardTitle(MemberInfo member) =>
      SizedBox(
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                member.id.toString(),
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
                  member.email,
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
      );

  List<Widget> buildCardChildren(MemberInfo member) => [
    buildInfoContainer("Email", member.email, context),
    buildInfoContainer(
      "Roles",
      member.userRoles.map((e) => e.toShortString()).join(', '), context,
    ),
    buildInfoContainer("Other groups", member.otherGroups.join(', '), context),
    buildDeleteContainer(_onDeletePressed, member),
  ];


  FloatingActionButton _buildAddButton() =>
      FloatingActionButton(
        onPressed: () =>
            showAddUserModal(
                context, widget.gateway, widget.groupId, addMember,),
        backgroundColor: adminGreenColor,
        child: const Icon(Icons.add),
      );

  void _onDeletePressed(MemberInfo member) {
    showAlertDialog(
      context,
      'Delete ' + member.email + ' from ' + widget.groupName,
      "You are about to delete this user from the group",
          () => deleteUser(member.id),
    );
  }

  void deleteUser(int id) async {
    await widget.gateway
        .deleteMember(id, widget.groupId)
        .then(
          (value) =>
      {
        if (value)
          {
            membersListProvider.delete(id),
          }
      },
    )
        .catchError((error) {
      buildSnackbar('Cannot delete user', context);
    });
  }

  void addMember(String email) async {
    await getUserFromEmail(email)
        .then((user) => user.id)
        .then(
          (id) =>
          widget.gateway
              .addMember(id, widget.groupId)
              .then(
                (addMemberResponse) =>
            {
              if (addMemberResponse)
                {
                  widget.gateway.getGroupData(widget.groupId).then(
                        (value) => membersListProvider.makeMemberList(value),)
                }
            },
          )
              .catchError((error) {
            buildSnackbar('Cannot add user', context);
          }),
    )
        .catchError((error) {
      buildSnackbar('Cannot find user with email ' + email, context);
    });
  }

  Future<UserSummary> getUserFromEmail(email) async =>
      widget.gateway
          .getMembersNotInGroup(widget.groupId)
          .then((users) => users.firstWhere((user) => user.email == email));
}
