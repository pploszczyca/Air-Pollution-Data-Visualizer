import 'package:flutter/material.dart';

class AdminView extends StatefulWidget {
  const AdminView({Key? key}) : super(key: key);

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  @override
  Widget build(BuildContext context) =>
      Scaffold(appBar: _buildAppBar(), body: const SingleChildScrollView(
        child: _buildGroupList(),
      ));

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
                  )))));

  ListView _buildGroupList() => ListView.builder(
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) => ListTile(
          leading: const Icon(Icons.list),
          trailing: const Text(
            "GFG",
            style: TextStyle(color: Colors.green, fontSize: 15),
          ),
          title: Text("Group number $index")));
}
