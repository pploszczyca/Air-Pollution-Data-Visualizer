import 'package:adpv_frontend/Views/AdminPage/groups/groups_view.dart';
import 'package:adpv_frontend/Views/AdminPage/users/all_users_view.dart';
import 'package:adpv_frontend/Views/AdminPage/utils.dart';
import 'package:flutter/material.dart';

class AdminMainView extends StatelessWidget {
  const AdminMainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(context),
      );

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
        ),
      );

  Column _buildBody(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildButtonContainer(
            context,
            'Groups',
            Icons.group,
            _onGroupsPressed,
          ),
          _buildButtonContainer(
            context,
            'Endpoints',
            Icons.map_outlined,
            _onEndpointsPressed,
          ),
          _buildButtonContainer(
              context, 'Users', Icons.people_alt_outlined, _onUsersPressed),
        ],
      );

  Card _buildButtonContainer(
    BuildContext context,
    String text,
    IconData icon,
    Function(BuildContext context) onPressedFunction,
  ) =>
      Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.height * 0.4,
          child: OutlinedButton.icon(
            label: Text(
              text,
              style:
                  const TextStyle(fontSize: 36, fontFamily: 'Ubuntu Condensed'),
            ),
            style: ButtonStyle(
              side: MaterialStateProperty.all(
                const BorderSide(width: 2, color: adminGreenColor),
              ),
              padding: MaterialStateProperty.all(
                const EdgeInsets.all(20),
              ),
              foregroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) =>
                    states.contains(MaterialState.hovered)
                        ? Colors.white
                        : adminGreenColor,
              ),
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) =>
                    states.contains(MaterialState.hovered)
                        ? adminGreenColor
                        : Colors.white,
              ),
              alignment: Alignment.center,
            ),
            onPressed: () => onPressedFunction(context),
            icon: Icon(
              icon,
              size: 36,
            ),
          ),
        ),
      );

  void _onGroupsPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GroupsView(),
      ),
    );
  }

  void _onEndpointsPressed(BuildContext context) {
    //todo przeniesienie do widoku endpointow
  }

  void _onUsersPressed(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AllUsersView()));
  }
}
