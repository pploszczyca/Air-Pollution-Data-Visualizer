import 'dart:async';

import 'package:adpv_frontend/Views/AdminPage/groups/confirmation_dialog_modal.dart';
import 'package:adpv_frontend/Views/AdminPage/members/members_view.dart';
import 'package:adpv_frontend/Views/AdminPage/utils.dart';
import 'package:adpv_frontend/Views/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../DataModels/group_summary.dart';
import '../../../Models/group_list_provider.dart';
import '../../../Repository/AdminRepository/admin_gateway.dart';
import '../../../Repository/UserRepository/user_gateway.dart';
import '../../../Widgets/common_widgets.dart';
import 'form_modal.dart';

//ignore: constant_identifier_names
const EMPTY_GROUP_ID = -1;
const adminGreenColor = Color.fromRGBO(36, 109, 114, 0.9);

class GroupsView extends StatefulWidget {
  GroupsView({Key? key}) : super(key: key);

  final AdminGateway gateway = AdminGateway();

  @override
  State<GroupsView> createState() => _GroupsViewState();
}

class _GroupsViewState extends State<GroupsView> {
  late GroupListProvider groupListProvider = GroupListProvider();

  FutureOr<List<GroupSummary>> onError<E extends Object>(
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
        create: (context) => groupListProvider,
        child: RefreshIndicator(
          onRefresh: () => widget.gateway.getGroupsSummary().onError(onError),
          child: Scaffold(
            appBar: buildAdminAppBar('User groups'),
            body: _buildBody(),
            floatingActionButton: _buildAddButton(),
          ),
        ),
      );

  FutureBuilder _buildBody() => FutureBuilder(
        future: widget.gateway.getGroupsSummary(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.data == null) {
            return loadingInCenter();
          } else {
            groupListProvider.makeGroupList(snapshot.data);
            return SingleChildScrollView(
              controller: ScrollController(),
              child: Consumer<GroupListProvider>(
                builder: (context, __, _) => Column(
                  children: [
                    _buildGroupList(groupListProvider.groupsList.length)
                  ],
                ),
              ),
            );
          }
        },
      );

  ListView _buildGroupList(int itemCount) => ListView.builder(
        controller: ScrollController(),
        itemCount: itemCount,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemBuilder: (context, i) =>
            _buildGroupCard(groupListProvider.groupsList[i]),
      );

  Card _buildGroupCard(GroupCard group) => Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ExpansionTile(
          title: Text(
            group.name,
            style: TextStyle(
              fontFamily: 'SofiaSans',
              fontSize: 25,
              color: Colors.black,
              fontWeight: group.titleFontWeight,
            ),
          ),
          tilePadding: const EdgeInsets.all(20),
          childrenPadding: const EdgeInsets.all(0),
          children: [
            _buildButtonContainer(
              'Members',
              group,
              group.membersButtonColor,
              _navigateToMembers,
            ),
            _buildButtonContainer(
              'Endpoints and permissions',
              group,
              group.endpointsButtonColor,
              _navigateToEndpoints,
            ),
            _buildDeleteContainer(group)
          ],
        ),
      );

  Container _buildButtonContainer(
    String text,
    GroupCard groupCard,
    Color color,
    Function(GroupCard groupCard) onPressedFunction,
  ) =>
      Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: TextButton(
          onPressed: () => {onPressedFunction(groupCard)},
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

  Container _buildDeleteContainer(GroupCard groupCard) => Container(
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
          onPressed: () => _onDeletePressed(groupCard),
        ),
      );

  FloatingActionButton _buildAddButton() => FloatingActionButton(
        onPressed: () => _onCreatePressed(groupListProvider),
        backgroundColor: adminGreenColor,
        child: const Icon(Icons.add),
      );

  void _onCreatePressed(groupListProvider) {
    showCreateGroupModal(context, createGroup);
  }

  void _onDeletePressed(GroupCard groupCard) {
    showAlertDialog(
      context,
      'Delete ' + groupCard.name,
      "You are about to delete group with all of its' saved permissions.",
      () => deleteGroup(groupCard.id),
    );
  }

  void deleteGroup(int id) async {
    await widget.gateway
        .deleteGroup(id)
        .then(
          (value) => {
            if (value)
              {
                groupListProvider.delete(id),
              }
          },
        )
        .catchError((error) {
      buildSnackbar('Cannot delete group', context);
    });
  }

  void createGroup(String name) async {
    await widget.gateway.createGroup(name).then((value) {
      if (value.id != EMPTY_GROUP_ID) {
        groupListProvider.addNewGroup(GroupSummary(value.id, name));
      } else {
        buildSnackbar(
          'Cannot create group, probably a group with this name already exists',
          context,
        );
      }
    }).catchError((error) {
      buildSnackbar(
        'Cannot create group, probably a group with this name already exists',
        context,
      );
    });
  }

  void _navigateToMembers(GroupCard groupCard) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MembersView(
          groupId: groupCard.id,
          groupName: groupCard.name,
        ),
      ),
    );
  }

  void _navigateToEndpoints(GroupCard groupCard) {}
}
