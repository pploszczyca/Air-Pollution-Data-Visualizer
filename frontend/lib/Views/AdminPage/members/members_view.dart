import 'dart:async';

import 'package:adpv_frontend/DataModels/group_data.dart';
import 'package:adpv_frontend/DataModels/member_summary.dart';
import 'package:adpv_frontend/Models/members_list_provider.dart';
import 'package:adpv_frontend/Views/AdminPage/groups/confirmation_dialog_modal.dart';
import 'package:adpv_frontend/Views/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../DataModels/group_summary.dart';
import '../../../Models/group_list_provider.dart';
import '../../../Repository/AdminRepository/admin_gateway.dart';
import '../../../Repository/UserRepository/user_gateway.dart';
import '../../../Widgets/common_widgets.dart';
import '../groups/groups_view.dart';


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
            appBar: buildAppBar('Members of ' + widget.groupName),
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
        child: Row(children: [
          ToggleButtons(
            selectedColor: Colors.red,
            isSelected: widget._selections,
            fillColor: Colors.transparent,
            renderBorder: false,
            children: [
              Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: const Text(
                    "ID",
                    style: TextStyle(
                      fontFamily: 'SofiaSans',
                      fontSize: 25,
                      fontWeight: FontWeight.normal,
                    ),
                  )),
              Container(
                margin: const EdgeInsets.only(
                  left: 20, right:20
                ),
                child: const Text(
                  "EMAIL",
                  style: TextStyle(
                    fontFamily: 'SofiaSans',
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              )
            ],
            onPressed: (int index) {
              setState(() {
                for (int i = 0; i < widget._selections.length; i++) {
                  widget._selections[i] = i == index;
                }
                if(widget._selections[0]){
                  membersListProvider.sortByID();
                }else if(widget._selections[1]){
                  membersListProvider.sortByEmail();
                  print(membersListProvider.membersList);
                }
              });
            },
          )
        ]),
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
          title: Row(
            children: [
              Container(
                padding: EdgeInsets.only(right: 30),
                child: Text(
                  member.memberSummary.id.toString(),
                  style: const TextStyle(
                    fontFamily: 'SofiaSans',
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Text(
                member.memberSummary.email,
                style: const TextStyle(
                  fontFamily: 'SofiaSans',
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          trailing: Text(""),
          collapsedBackgroundColor: Colors.white,
          tilePadding: const EdgeInsets.all(20),
          childrenPadding: const EdgeInsets.all(0),
          children: [
            _buildDeleteContainer(member.memberSummary),
            _buildInfoContainer("Roles", member.userRoles),
            // _buildInfoContainer("Other groups", member.otherGroups)
          ],
        ),
      );

  FutureBuilder _buildInfoContainer(String title, data) => FutureBuilder(
      future: widget.gateway.getGroupData(widget.groupId).onError(onError),
  builder: (context, snapshot) {
  if (snapshot.connectionState == ConnectionState.none ||
  snapshot.data == null) {
  return loadingInCenter();
  }   //     Container(
  //   child: Row(
  //     children: [
  //       Container(child: Text(title),),
  //       Container()
  //     ],
  //   )
  // )

  Container _buildButtonContainer(
    String text,
    GroupCard groupCard,
    Color color,
  ) =>
      Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: TextButton(
          onPressed: () => {},
          child: Row(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    text,
                    style: TextStyle(
                      fontFamily: 'SofiaSans',
                      fontSize: 23,
                      color: color,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: color,
                  size: 25,
                ),
              ),
            ],
          ),
        ),
      );

  Container _buildDeleteContainer(MemberSummary memberSummary) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: OutlinedButton(
          style: ButtonStyle(
            side: MaterialStateProperty.all(
              const BorderSide(width: 1.5, color: Colors.red),
            ),
            padding: MaterialStateProperty.all(
              const EdgeInsets.all(20),
            ),
            foregroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) =>
                  states.contains(MaterialState.hovered)
                      ? Colors.white
                      : Colors.red,
            ),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) =>
                  states.contains(MaterialState.hovered)
                      ? Colors.red
                      : Colors.white,
            ),
            alignment: Alignment.centerLeft,
          ),
          child: const Icon(Icons.delete_outline_outlined, size: 30),
          onPressed: () => _onDeletePressed(memberSummary),
        ),
      );

  FloatingActionButton _buildAddButton() => FloatingActionButton(
        onPressed: () => {},
        backgroundColor: adminGreenColor,
        child: const Icon(Icons.add),
      );

  void _onDeletePressed(MemberSummary memberSummary) {
    showAlertDialog(
      context,
      'Delete ' + memberSummary.email + 'from ' + widget.groupName,
      "You are about to delete this user from the group",
      () => deleteUser(memberSummary.id),
    );
  }

  void deleteUser(int id) async {
    await widget.gateway
        .deleteGroup(id)
        .then(
          (value) => {
            if (value)
              {
                membersListProvider.delete(id),
              }
          },
        )
        .catchError((error) {
      buildSnackbar('Cannot delete group', context);
    });
  }
}
