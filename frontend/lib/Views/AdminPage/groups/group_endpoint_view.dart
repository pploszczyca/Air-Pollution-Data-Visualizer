import 'package:adpv_frontend/DataModels/group_endpoints.dart';
import 'package:adpv_frontend/Repository/AdminRepository/admin_gateway.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Common/consts.dart';
import '../../../Providers/group_endpoint_provider.dart';
import '../../../Widgets/AdminWidgets/admin_app_bar.dart';
import '../../../Widgets/AdminWidgets/admin_buttons.dart';
import '../../../Widgets/AdminWidgets/admin_styles.dart';
import '../../../Widgets/AdminWidgets/confirmation_dialog_modal.dart';
import '../../snackbar.dart';

class GroupEndpointView extends StatefulWidget {
  final int groupEndpointId;
  final AdminGateway gateway = AdminGateway();
  final String groupName;

  GroupEndpointView(this.groupEndpointId, this.groupName, {Key? key})
      : super(key: key);

  @override
  State<GroupEndpointView> createState() => _GroupEndpointViewState();
}

final roundedRectangleBorder = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(5),
  side: const BorderSide(color: Colors.black),
);

class _GroupEndpointViewState extends State<GroupEndpointView> {
  late final Future<GroupEndpointsData> future;

  @override
  void initState() {
    future = widget.gateway.getEndpointsForGroup(widget.groupEndpointId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: adminAppBar(
          "Administrator panel",
          widget.groupName + " - endpoints",
        ),
        body: ChangeNotifierProvider<GroupEndpointProvider>(
          create: (context) => GroupEndpointProvider(future),
          child: Consumer<GroupEndpointProvider>(
            builder: (context, provider, _) => Column(
              children: [
                Expanded(
                  child: ListView(
                    children: _buildEndpointTiles(provider),
                  ),
                ),
                buildButtonContainer(context),
              ],
            ),
          ),
        ),
      );

  Container buildButtonContainer(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            discardChangesButton(context),
            saveButton(
              () => buildSaveAlertDialog(context),
            )
          ],
        ),
      );

  void buildSaveAlertDialog(BuildContext context) => showAlertDialog(
        context,
        'Confirm saving group settings',
        "You are about to edit group permissions",
        () {
          Provider.of<GroupEndpointProvider>(context, listen: false)
              .save()
              .then(
                (_) => buildSnackbar(
                  "Group endpoints edited",
                  context,
                  duration: 3,
                  color: adminGreenColor,
                  height: 65,
                ),
              )
              .onError(
                (error, stackTrace) => buildSnackbar(
                  "Group endpoints edition failed",
                  context,
                  duration: 10,
                  height: 65,
                ),
              );
        },
      );

  List<Widget> _buildEndpointTiles(
    GroupEndpointProvider provider,
  ) =>
      provider.groupEndpointsData.endpoints.values
          .map(
            (endpoint) => Container(
              decoration: const BoxDecoration(
                border: Border.symmetric(
                  horizontal: BorderSide(color: Colors.black, width: 0.5),
                ),
              ),
              child: ExpansionTile(
                collapsedBackgroundColor: Colors.white,
                backgroundColor: Colors.white12,
                maintainState: true,
                title: Row(
                  children: [
                    Checkbox(
                      shape: roundedRectangleBorder,
                      activeColor: Colors.teal,
                      value: endpoint.isBelongingToGroup,
                      onChanged: (bool? value) {
                        provider.updateEndpointState(value, endpoint.id);
                      },
                    ),
                    Flexible(
                      child: Text(
                        endpoint.label,
                        style: defaultAdminTextStyle,
                      ),
                    ),
                  ],
                ),
                children: endpoint.fields.entries
                    .where(
                  (element) => ![ignoreField, ignoreLabel, ignoreId]
                      .contains(element.value.label),
                )
                    .map((field) {
                  final Field value = field.value;
                  final String tileText = value.unitName != null
                      ? value.label + " / " + value.unitName.toString()
                      : value.label;
                  return Theme(
                    data: ThemeData(
                      checkboxTheme:
                          CheckboxThemeData(shape: roundedRectangleBorder),
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(left: 30),
                      decoration: const BoxDecoration(
                        border: Border.symmetric(
                          horizontal:
                              BorderSide(color: Colors.grey, width: 0.5),
                        ),
                      ),
                      child: makeCheckboxListTile(
                        tileText,
                        value,
                        provider,
                        endpoint,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          )
          .toList();

  CheckboxListTile makeCheckboxListTile(
    String tileText,
    Field field,
    GroupEndpointProvider provider,
    EndpointForGroup endpoint,
  ) =>
      CheckboxListTile(
        activeColor: Colors.teal,
        controlAffinity: ListTileControlAffinity.leading,
        title: Flexible(
          child: Text(
            tileText,
            style: defaultAdminTextStyle,
          ),
        ),
        value: field.isBelongingToGroup,
        onChanged: (bool? value) => provider.updateFieldState(
          value,
          endpoint.id,
          field.id,
        ),
      );
}
