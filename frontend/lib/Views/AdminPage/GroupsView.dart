import 'package:adpv_frontend/DataModels/GroupSummary.dart';
import 'package:adpv_frontend/Repository/AdminRepository/AdminGateway.dart';
import 'package:adpv_frontend/Views/AdminPage/confirmationDialogModal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Models/GroupListProvider.dart';
import '../../Widgets/CommonWidgets.dart';

const floatingButtonColor = Color.fromRGBO(36, 109, 114, 0.9);

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
    floatingActionButton: _buildAddButton()
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
                group.titleFontweight = FontWeight.w800;
              });
            } else {
              setState(() {
                group.titleFontweight = FontWeight.normal;
              });
            }
          },
          title: Text(
            group.name,
            style: TextStyle(
                fontFamily: 'SofiaSans',
                fontSize: 25,
                color: Colors.black,
                fontWeight: group.titleFontweight),
          ),
          tilePadding: const EdgeInsets.all(20),
          childrenPadding: const EdgeInsets.all(0),
          children: [
            _buildButtonContainer('Members', group, group.membersButtonColor),
            _buildButtonContainer(
                'Endpoints and permissions', group, group.endpointsButtonColor),
            _buildDeleteContainer(group)
          ],
        ),
      );

  Container _buildButtonContainer(
          String text, GroupCard groupCard, Color color) =>
      Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: TextButton(
          onPressed: () {print('kokokokoko');},
          onHover: (value) {
            if (value) {
              _onHoverButton(groupCard, text, floatingButtonColor);
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
                        fontFamily: 'SofiaSans', fontSize: 23, color: color),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.arrow_forward_ios_rounded ,
                  color: color,
                  size: 25,
                ),
              ),
            ],
          ),
        ),
      );

  Container _buildDeleteContainer(GroupCard groupCard) =>
      Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: OutlinedButton(
          style: ButtonStyle(
            side: MaterialStateProperty.all(
                const BorderSide(width: 1.5, color: Colors.red)),
            padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
            foregroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) =>
                states.contains(MaterialState.hovered)
                    ? Colors.white
                    : Colors.red),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) =>
                states.contains(MaterialState.hovered)
                    ? Colors.red
                    : Colors.white),
            alignment: Alignment.centerLeft,
          ),
          onPressed: (){},
          // onPressed: _onDeletePressed(groupCard),
          child: const Icon(Icons.delete_outline_outlined, size: 30)
        ));


  FloatingActionButton _buildAddButton() => FloatingActionButton(
    onPressed: (){ print('llllllllllllllllllllllllllll');},
    backgroundColor: floatingButtonColor,
    child: const Icon(Icons.add),
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

  _onDeletePressed(GroupCard groupCard){
    print(' dcdscdscsdcds');
    // showAlertDialog(context);
    // this.widget.repository.deleteGroup(groupCard.id);
  }
}
