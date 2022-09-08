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
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromRGBO(21, 184, 194, 1),
                Color.fromRGBO(14, 14, 82, 0.9)
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  buildSpacer(25, 0),
                  buildAvatarContainer(),
                  buildSpacer(25, 0),
                  buildRoleContainer(),
                  buildSpacer(25, 0),
                  buildLogoutButton(context)
                ],
              ),
            ),
          ),
        ),
      );

  SizedBox buildLogoutButton(BuildContext context) => SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: OutlinedButton(
          style: ButtonStyle(
            side: MaterialStateProperty.all(
              const BorderSide(width: 2, color: Colors.pink),
            ),
            padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) =>
                  states.contains(MaterialState.hovered)
                      ? Colors.pink
                      : Colors.white,
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
                      LoginView(userGateway: widget.userGateway)),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "LOG OUT",
                style: TextStyle(
                  fontFamily: 'SofiaSans',
                  fontSize: 26,
                  color: Colors.pink,
                ),
              ),
              buildSpacer(0, 25),
              const Icon(
                Icons.logout,
                size: 32,
                color: Colors.pink,
              ),
            ],
          ),
        ),
      );

  Container buildRoleContainer() => Container(
        height: MediaQuery.of(context).size.height *
            0.09 *
            widget.userGateway.user.userRoles.length,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Your roles:",
              style: TextStyle(
                fontFamily: 'SofiaSans',
                color: Colors.pink,
                fontSize: 32,
              ),
            ),
            Center(
              child: Column(
                children: listRoles(),
              ),
            )
          ],
        ),
      );

  Container buildAvatarContainer() => Container(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildRoundAvatar(),
              buildSpacer(10, 10),
              Center(
                child: Text(
                  widget.userGateway.user.email,
                  style: const TextStyle(
                    fontStyle: FontStyle.normal,
                    color: Color.fromARGB(255, 100, 100, 100),
                    fontSize: 24,
                  ),
                ),
              ),
            ]),
      );

  SizedBox buildSpacer(double height, double width) => SizedBox(
        width: width,
        height: height,
      );

  SizedBox buildRoundAvatar() => SizedBox(
        height: 100,
        width: 100,
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: Colors.pink,
              border: Border.all(
                color: Colors.pink,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(90))),
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

  List<Widget> listRoles() => widget.userGateway.user.userRoles
      .map(
        (e) => Center(
          child: Text(
            bullet + " " + e.toString().split('.').last,
            style: const TextStyle(
              fontFamily: 'SofiaSans',
              color: Color.fromARGB(255, 100, 100, 100),
              fontSize: 24,
            ),
          ),
        ),
      )
      .toList();
}
