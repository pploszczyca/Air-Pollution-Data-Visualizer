import 'dart:async';

import 'package:adpv_frontend/DataModels/group_summary.dart';
import 'package:adpv_frontend/Repository/AdminRepository/admin_gateway.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Models/group_list_provider.dart';
import '../../Repository/UserRepository/user_gateway.dart';
import '../../Widgets/common_widgets.dart';

class GroupsView extends StatefulWidget {
  GroupsView({Key? key}) : super(key: key);

  final AdminGateway gateway = AdminGateway();

  @override
  State<GroupsView> createState() => _GroupsViewState();
}

class _GroupsViewState extends State<GroupsView> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      );

  FutureOr<List<GroupSummary>> onError<E extends Object>(
      E error, StackTrace stackTrace,) {
   UserGateway().resetMemoryToken().then(
         (value) =>
             Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false),
       );
    return Future.error(error.toString());
  }

  PreferredSize _buildAppBar() => PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: AppBar(
          centerTitle: true,
          toolbarHeight: 120,
          title: Container(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: const Text("Administrator panel"),
          ),
          backgroundColor: Colors.white,
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontFamily: 'Ubuntu Condensed',
            fontSize: 40,
            fontWeight: FontWeight.w500,
          ),
          titleSpacing: 20,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(20),
            child: Container(
              padding: const EdgeInsets.only(bottom: 10, top: 5),
              child: const Text(
                "User groups",
                style: TextStyle(fontSize: 25),
              ),
            ),
          ),
        ),
      );

  Widget _buildBody() => RefreshIndicator(
        onRefresh: () => widget.gateway.getGroupsSummary().onError(onError),
        child: FutureBuilder<List<GroupSummary>>(
          future: widget.gateway.getGroupsSummary().onError(onError),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.none ||
                snapshot.data == null) {
              return loadingInCenter();
            }
            return ChangeNotifierProvider(
              create: (context) =>
                  GroupListProvider(snapshot.data!, widget.gateway),
              child: Consumer<GroupListProvider>(
                builder: (context, groupListProvider, _) =>
                    _buildGroupList(groupListProvider, snapshot.data!.length),
              ),
            );
          },
        ),
      );

  ListView _buildGroupList(
    GroupListProvider groupListProvider,
    int itemCount,
  ) =>
      ListView.builder(
        shrinkWrap: true,
        itemCount: itemCount,
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
          onExpansionChanged: (value) {
            setState(() {
              group.titleColor = value ? Colors.pink : Colors.black;
            });
          },
          title: Text(
            group.name,
            style: TextStyle(
              fontFamily: 'SofiaSans',
              fontSize: 25,
              color: group.titleColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          tilePadding: const EdgeInsets.all(20),
          iconColor: group.titleColor,
          childrenPadding: const EdgeInsets.all(0),
          children: [
            _buildButtonContainer('Members', group, group.membersButtonColor),
            _buildButtonContainer(
              'Endpoints and permissions',
              group,
              group.endpointsButtonColor,
            ),
          ],
        ),
      );

  Container _buildButtonContainer(
    String text,
    GroupCard groupCard,
    Color color,
  ) =>
      Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: TextButton(
          onPressed: () {},
          onHover: (value) {
            final color = value ? Colors.pink : Colors.black;
            _onHoverButton(groupCard, text, color);
          },
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
                      fontSize: 20,
                      color: color,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.arrow_right_alt,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      );

  void _onHoverButton(GroupCard groupCard, String text, Color color) {
    setState(() {
      if (text == 'Members') {
        groupCard.membersButtonColor = color;
      } else {
        groupCard.endpointsButtonColor = color;
      }
    });
  }
}
