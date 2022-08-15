import 'package:adpv_frontend/DataModels/GroupSummary.dart';
import 'package:adpv_frontend/Repository/AdminRepository/AdminGateway.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Models/GroupListProvider.dart';
import '../../Widgets/CommonWidgets.dart';

class GroupsView extends StatefulWidget {
  const GroupsView({required this.repository, Key? key}) : super(key: key);

  final AdminGateway repository;

  @override
  State<GroupsView> createState() => _GroupsViewState();
}

class _GroupsViewState extends State<GroupsView> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      );

  PreferredSize _buildAppBar() => PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: AppBar(
          centerTitle: true,
          toolbarHeight: 120,
          title: Container(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: const Text("Administrator panel")),
          backgroundColor: Colors.white,
          titleTextStyle: const TextStyle(
              color: Colors.black,
              fontFamily: 'Ubuntu Condensed',
              fontSize: 40,
              fontWeight: FontWeight.w500),
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

  FutureBuilder _buildBody() => FutureBuilder<List<GroupSummary>>(
      future: widget.repository.getGroupsSummary(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none ||
            snapshot.data == null) {
          return loadingInCenter();
        }
        return ChangeNotifierProvider(
          create: (context) =>
              GroupListProvider(snapshot.data!, widget.repository),
          child: Consumer<GroupListProvider>(
            builder: (context, groupListProvider, _) =>
                _buildGroupList(groupListProvider, snapshot.data!.length),
          ),
        );
      });

  ListView _buildGroupList(
          GroupListProvider groupListProvider, int itemCount) =>
      ListView.builder(
          itemCount: itemCount,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemBuilder: (context, i) =>
              _buildGroupCard(groupListProvider.groupsList[i]));

  Card _buildGroupCard(GroupCard group) => Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ExpansionTile(
          onExpansionChanged: (value) {
            if (value) {
              setState(() {
                group.titleColor = Colors.pink;
              });
            } else {
              setState(() {
                group.titleColor = Colors.black;
              });
            }
          },
          title: Text(
            group.name,
            style: TextStyle(
                fontFamily: 'SofiaSans',
                fontSize: 25,
                color: group.titleColor,
                fontWeight: FontWeight.w500),
          ),
          tilePadding: const EdgeInsets.all(20),
          iconColor: group.titleColor,
          childrenPadding: const EdgeInsets.all(0),
          children: [
            _buildButtonContainer('Members', group, group.membersButtonColor),
            _buildButtonContainer(
                'Endpoints and permissions', group, group.endpointsButtonColor),
          ],
        ),
      );

  Container _buildButtonContainer(
          String text, GroupCard groupCard, Color color) =>
      Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: TextButton(
          onPressed: () {},
          onHover: (value) {
            if (value) {
              _onHoverButton(groupCard, text, Colors.pink);
            } else {
              _onHoverButton(groupCard, text, Colors.black);
            }
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
                        fontFamily: 'SofiaSans', fontSize: 20, color: color),
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
