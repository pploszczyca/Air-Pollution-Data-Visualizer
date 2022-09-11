import 'package:adpv_frontend/Repository/UserRepository/user_gateway.dart';
import 'package:adpv_frontend/Views/Logging/login_view.dart';
import 'package:adpv_frontend/Widgets/common_widgets.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  final UserGateway userGateway;

  const ProfileView(this.userGateway, {Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

String bullet = "\u2022 ";

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color.fromARGB(255, 127, 166, 168),
        appBar: buildFancyAppBar("Your Profile"),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          alignment: Alignment.topCenter,
          decoration: buildBackgroundBoxDecoration(),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  _buildAvatarContainer(),
                  _buildRoleContainer(),
                  _buildLogoutButton(context)
                ],
              ),
            ),
          ),
        ),
      );

  Container _buildAvatarContainer() => Container(
        margin: const EdgeInsets.symmetric(vertical: 12.5),
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildRoundAvatar(),
            Center(
              child: Text(
                widget.userGateway.user.email,
                style: const TextStyle(
                  fontStyle: FontStyle.normal,
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ],
        ),
      );

  Container _buildRoundAvatar() => Container(
        margin: const EdgeInsets.symmetric(vertical: 12.5),
        height: 100,
        width: 100,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.pink,
            border: Border.all(
              color: Colors.pink,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(90)),
          ),
          child: Center(
            child: Text(
              widget.userGateway.user.email[0].toUpperCase(),
              style: const TextStyle(
                fontStyle: FontStyle.normal,
                color: Colors.white,
                fontSize: 56,
              ),
            ),
          ),
        ),
      );

  Container _buildRoleContainer() => Container(
        margin: const EdgeInsets.symmetric(vertical: 12.5),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Your roles",
              style: TextStyle(
                fontFamily: 'SofiaSans',
                color: Colors.pink,
                fontSize: 32,
              ),
            ),
            const Divider(
              height: 20,
              thickness: 2,
              indent: 0,
              endIndent: 0,
              color: Colors.grey,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _listRoles(),
            ),
          ],
        ),
      );

  Container _buildLogoutButton(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(vertical: 12.5),
        width: MediaQuery.of(context).size.width * 0.5,
        child: TextButton.icon(
          label: const Text(
            "LOG OUT",
            style: TextStyle(
              fontFamily: 'SofiaSans',
              fontSize: 26,
            ),
          ),
          icon: const Icon(
            Icons.logout,
            size: 32,
          ),
          style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) =>
                  states.contains(MaterialState.hovered)
                      ? Colors.pink
                      : Colors.white,
            ),
            foregroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) =>
                  states.contains(MaterialState.hovered)
                      ? Colors.white
                      : Colors.pink,
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
          onPressed: () {
            widget.userGateway.resetMemoryToken();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    LoginView(userGateway: widget.userGateway),
              ),
            );
          },
        ),
      );

  List<Widget> _listRoles() => widget.userGateway.user.userRoles
      .map(
        (role) => Text(
          bullet + " " + role.toString().trim().split('.').last,
          style: const TextStyle(
            fontFamily: 'SofiaSans',
            color: Color.fromARGB(255, 100, 100, 100),
            fontSize: 24,
          ),
        ),
      )
      .toList();
}
