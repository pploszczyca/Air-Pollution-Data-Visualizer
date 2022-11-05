import 'package:adpv_frontend/Views/AdminPage/endpoints/admin_all_endpoints_view.dart';
import 'package:adpv_frontend/Views/AdminPage/fields/fields_list_view.dart';
import 'package:adpv_frontend/Views/AdminPage/groups/groups_view.dart';
import 'package:adpv_frontend/Views/AdminPage/users/all_users_view.dart';
import 'package:flutter/material.dart';

import '../../Widgets/AdminWidgets/admin_app_bar.dart';
import '../../Widgets/AdminWidgets/admin_styles.dart';

class AdminMainView extends StatelessWidget {
  const AdminMainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(context),
      );

  PreferredSize _buildAppBar() => adminAppBar("Administrator panel", "");

  Column _buildBody(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildButtonContainer(
            context,
            'Groups',
            Icons.groups,
            _onGroupsPressed,
          ),
          _buildButtonContainer(
            context,
            'Endpoints',
            Icons.map_outlined,
            _onEndpointsPressed,
          ),
          _buildButtonContainer(
            context,
            'Users',
            Icons.manage_accounts,
            _onUsersPressed,
          ),
          _buildButtonContainer(
            context,
            'Fields',
            Icons.straighten,
            _onFieldsPressed,
          ),
        ],
      );

  Card _buildButtonContainer(
    BuildContext context,
    String text,
    IconData icon,
    Function(BuildContext context) onPressedFunction,
  ) =>
      Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdminAllEndpointsView(),
      ),
    );
  }

  void _onUsersPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AllUsersView()),
    );
  }

  void _onFieldsPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FieldsListView()),
    );
  }
}
