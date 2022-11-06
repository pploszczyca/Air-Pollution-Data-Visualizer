import 'dart:async';

import 'package:adpv_frontend/Views/AdminPage/groups/group_endpoint_view.dart';
import 'package:adpv_frontend/Views/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../DataModels/group_summary.dart';
import '../../../Providers/group_list_provider.dart';
import '../../../Repository/AdminRepository/admin_gateway.dart';
import '../../../Repository/UserRepository/user_gateway.dart';
import '../../../Widgets/AdminWidgets/admin_app_bar.dart';
import '../../../Widgets/AdminWidgets/admin_buttons.dart';
import '../../../Widgets/AdminWidgets/admin_styles.dart';
import '../../../Widgets/AdminWidgets/confirmation_dialog_modal.dart';
import '../../../Widgets/AdminWidgets/group_card.dart';
import '../../../Widgets/common_widgets.dart';
import 'create_group_modal.dart';
import 'members_view.dart';

//ignore: constant_identifier_names
const EMPTY_GROUP_ID = -1;

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
            appBar: adminAppBar("Administrator panel", "User groups"),
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
                    _buildGroupList(groupListProvider.groupsList.length),
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
        itemBuilder: (context, i) => groupCard(
            Text(
              groupListProvider.groupsList[i].name,
              style: const TextStyle(
                fontFamily: 'SofiaSans',
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            [
              _buildButtonContainer(
                'Members',
                groupListProvider.groupsList[i],
                _navigateToMembers,
              ),
              _buildButtonContainer(
                'Endpoints and permissions',
                groupListProvider.groupsList[i],
                _onEndpointsAndPermissionsPressed,
              ),
              deleteButtonContainer(
                () => _onDeletePressed(
                  groupListProvider.groupsList[i],
                ),
              )
            ]),
      );

  Container _buildButtonContainer(
    String text,
    GroupCard groupCard,
    Function(BuildContext context, GroupCard groupCard) onPressedFunction,
  ) =>
      Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: TextButton(
          onPressed: () => onPressedFunction(context, groupCard),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontFamily: 'Sofiaconst Sans',
                      fontSize: 23,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.black,
                  size: 25,
                ),
              ),
            ],
          ),
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
      buildSnackbar('Cannot delete group', context, duration: 5);
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
          duration: 5,
        );
      }
    }).catchError((error) {
      buildSnackbar(
        'Cannot create group, probably a group with this name already exists',
        context,
        duration: 5,
      );
    });
  }

  void _navigateToMembers(BuildContext context, GroupCard groupCard) {
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

  void _onEndpointsAndPermissionsPressed(
    BuildContext context,
    GroupCard groupCard,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GroupEndpointView(groupCard.id, groupCard.name),
      ),
    );
  }
}
