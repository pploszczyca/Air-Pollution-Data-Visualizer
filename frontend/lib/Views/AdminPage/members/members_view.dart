import 'dart:async';

import 'package:adpv_frontend/DataModels/User/user.dart';
import 'package:adpv_frontend/DataModels/group_data.dart';
import 'package:adpv_frontend/DataModels/member_summary.dart';
import 'package:adpv_frontend/Models/members_list_provider.dart';
import 'package:adpv_frontend/Views/AdminPage/groups/confirmation_dialog_modal.dart';
import 'package:adpv_frontend/Views/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Repository/AdminRepository/admin_gateway.dart';
import '../../../Repository/UserRepository/user_gateway.dart';
import '../../../Widgets/common_widgets.dart';
import '../groups/groups_view.dart';
import '../utils.dart';

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

  FutureOr<GroupData> onError<E extends Object>(
    E error,
    StackTrace stackTrace,
  ) {
    UserGateway().resetMemoryToken().then(
          (value) =>
              Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false),
        );
    return Future.error(error.toString());
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => membersListProvider,
        child: RefreshIndicator(
          onRefresh: () =>
              widget.gateway.getGroupData(widget.groupId).onError(onError),
          child: Scaffold(
            appBar: buildAdminAppBar('Members of ' + widget.groupName),
            body: _buildBody(),
            floatingActionButton: _buildAddButton(),
          ),
        ),
      );

  FutureBuilder _buildBody() => FutureBuilder(
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
                builder: (context, __, _) => Column(
                  children: [
                    _buildSortBar(membersListProvider),
                    _buildMembersList(membersListProvider.membersList.length)
                  ],
                ),
              ),
            );
          }
        },
      );

  Container _buildSortBar(MembersListProvider membersListProvider) => Container(
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

  ListView _buildMembersList(int itemCount) => ListView.builder(
        controller: ScrollController(),
        itemCount: itemCount,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemBuilder: (context, i) =>
            _buildGroupCard(membersListProvider.membersList[i]),
      );

  Card _buildGroupCard(MemberInfo member) => Card(
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
          ),
          collapsedBackgroundColor: Colors.white,
          tilePadding: const EdgeInsets.all(20),
          childrenPadding: const EdgeInsets.all(0),
          children: [
            _buildInfoContainer("Email", member.email),
            _buildInfoContainer(
              "Roles",
              member.userRoles.map((e) => e.toShortString()).join(', '),
            ),
            _buildInfoContainer("Other groups", member.otherGroups.join(', ')),
            buildDeleteContainer(_onDeletePressed, member),
          ],
        ),
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

  FloatingActionButton _buildAddButton() => FloatingActionButton(
        onPressed: () => {},
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
          (value) => {
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
}