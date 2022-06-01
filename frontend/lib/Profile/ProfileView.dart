import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      AppBar(title: Text("Your profile"),),
      Container(
        child: Text("Some profile info here"),
      ),
    ]);
  }
}
