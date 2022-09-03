import 'package:adpv_frontend/Repository/AdminRepository/AdminGateway.dart';
import 'package:adpv_frontend/Views/AdminPage/ConfirmationDialogModal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Models/GroupListProvider.dart';
import '../../Widgets/CommonWidgets.dart';
import 'FormModal.dart';

const floatingButtonColor = Color.fromRGBO(36, 109, 114, 0.9);

class GroupsView extends StatefulWidget {
  const GroupsView({required this.repository, Key? key}) : super(key: key);

  final AdminGateway repository;

  @override
  State<GroupsView> createState() => _GroupsViewState();
}

class _GroupsViewState extends State<GroupsView> {
  late GroupListProvider groupListProvider = GroupListProvider(widget.repository);

  _pullDownRefresh() async {
    groupListProvider.clear();
  }


  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => groupListProvider,
      child: RefreshIndicator(
          onRefresh: () => _pullDownRefresh(),
          child: Scaffold(
              appBar: _buildAppBar(),
              body: _buildBody(),
              floatingActionButton: _buildAddButton())));

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

  FutureBuilder _buildBody() => FutureBuilder(
        future: widget.repository.getGroupsSummary(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.data == null) {
            return loadingInCenter();
          } else {
            groupListProvider.makeGroupList(snapshot.data!);
            return SingleChildScrollView(
              controller: ScrollController(),
              child: Consumer<GroupListProvider>(
                  builder: (context, __, _) => SizedBox(
                        height: 3400,
                        child: _buildGroupList(
                            groupListProvider, groupListProvider.groupsList.length))),
            );
          }
        });

  ListView _buildGroupList(GroupListProvider groupListProvider, int itemCount) {
    return ListView.builder(
        controller: ScrollController(),
        itemCount: itemCount,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemBuilder: (context, i) =>
            _buildGroupCard(groupListProvider.groupsList[i]));
  }

  Card _buildGroupCard(GroupCard group) => Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ExpansionTile(
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
          onPressed: () => print('kokokokoko'),
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
        child: const Icon(Icons.delete_outline_outlined, size: 30),
        onPressed: () => _onDeletePressed(groupCard),
      ));

  FloatingActionButton _buildAddButton() => FloatingActionButton(
        onPressed: () => _onCreatePressed(),
        backgroundColor: floatingButtonColor,
        child: const Icon(Icons.add),
      );

  _onCreatePressed() {
    showCreateGroupModal(context, createGroup);
  }

  _onDeletePressed(GroupCard groupCard) {
    showAlertDialog(
        context,
        'Delete ' + groupCard.name,
        "You are about to delete group with all of its' saved permissions.",
        () => deleteGroup(groupCard.id));
  }

  deleteGroup(int id) {
    widget.repository.deleteGroup(id).then((value) => {
      if(value) groupListProvider.notify(),
        });
  }

  createGroup(String name) {
    widget.repository.createGroup(name).then((value) {
            if (value.id != -1) groupListProvider.notify();
        });
  }
}
