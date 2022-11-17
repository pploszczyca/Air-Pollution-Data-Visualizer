import 'package:adpv_frontend/Providers/add_endpoint_provider.dart';
import 'package:adpv_frontend/Repository/AdminRepository/admin_endpoints_repository.dart';
import 'package:adpv_frontend/Widgets/AdminWidgets/admin_app_bar.dart';
import 'package:adpv_frontend/Widgets/AdminWidgets/confirmation_dialog_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../DataModels/enable_field.dart';
import '../../../DataModels/field_parser.dart';
import '../../../Widgets/AdminWidgets/admin_buttons.dart';
import '../../../Widgets/AdminWidgets/admin_styles.dart';
import '../../../Widgets/AdminWidgets/two_row_list_tile.dart';
import '../../snackbar.dart';

class AdminAddEndpointView extends StatefulWidget {
  final EndpointAdminData endpointAdminData;
  final Map<int, EnableField> enableFields;
  final Map<int, FieldParser> fieldParsers;

  const AdminAddEndpointView(
      this.enableFields,
      this.fieldParsers,
      this.endpointAdminData, {
        Key? key,
      }) : super(key: key);

  @override
  State<AdminAddEndpointView> createState() => _AdminAddEndpointViewState();
}

class _AdminAddEndpointViewState extends State<AdminAddEndpointView> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: adminAppBar("Add Endpoint", "New endpoint"),
    backgroundColor: Colors.white,
    body: ChangeNotifierProvider(
      create: (context) => AddEndpointProvider(
        widget.endpointAdminData,
        widget.enableFields,
        widget.fieldParsers,
      ),
      child: Consumer<AddEndpointProvider>(
        builder: (context, provider, _) => SingleChildScrollView(
          child: Column(
            children: [
              _buildSubTitle("Endpoint data", 30),
              _buildBasicInfoList(
                provider,
                context,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 50, bottom: 10),
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () {
                        _addMeasurement(provider, context);
                      },
                      icon: const Icon(
                        Icons.add_circle_outline,
                        color: Colors.teal,
                        size: 32,
                      ),
                    ),
                  ),
                  _buildSubTitle("Measurements", 50),
                ],
              ),
              _buildFieldInfoList(provider, context),
              SizedBox.fromSize(
                size: const Size(0, 100),
              ),
              _buildButtonContainer(context),
            ],
          ),
        ),
      ),
    ),
  );

  Container _buildSubTitle(String text, double topMargin) => Container(
    margin: EdgeInsets.only(top: topMargin, bottom: 10),
    padding: const EdgeInsets.symmetric(horizontal: 10),
    alignment: Alignment.centerLeft,
    child: Text(
      text,
      style: defaultAdminTextStyle.copyWith(
        color: Colors.black45,
        fontSize: 28,
        fontWeight: FontWeight.w500,
      ),
    ),
  );

  Column _buildBasicInfoList(
      AddEndpointProvider provider,
      BuildContext context,
      ) =>
      Column(
        children: provider.basicInfoControllers.entries
            .where((e) => e.key != "id")
            .map<Widget>((e) {
          TextInputType inputType = TextInputType.text;
          if (e.key == 'number') {
            inputType = TextInputType.number;
          }
          return TwoRowListTile(
            Flexible(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                width: MediaQuery.of(context).size.width * 0.3,
                alignment: Alignment.centerLeft,
                child: Text(
                  e.key,
                  style: defaultAdminTextStyle.copyWith(
                    fontSize: 18,
                    color: Colors.black45,
                  ),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
                child: Theme(
                  data: ThemeData.from(
                    colorScheme: ColorScheme.fromSwatch(
                      backgroundColor: Colors.white,
                      cardColor: Colors.pink,
                      primarySwatch: Colors.pink,
                      accentColor: Colors.pink,
                    ),
                  ),
                  child: TextFormField(
                    keyboardType: inputType,
                    controller: e.value,
                    cursorColor: Colors.pink,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      );

  Column _buildFieldInfoList(
      AddEndpointProvider provider,
      BuildContext context,
      ) =>
      Column(
        children: provider.parserPathControllers.entries
            .where((e) => e.key.label != "id")
            .map<Widget>(
              (e) => TwoRowListTile(
            Flexible(
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline, size: 22),
                    color: Colors.red,
                    onPressed: () {
                      provider.deleteFieldFromEndpoint(e.key);
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    width: MediaQuery.of(context).size.width * 0.3,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      e.key.label,
                      style: defaultAdminTextStyle.copyWith(
                        fontSize: 18,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
                child: Theme(
                  data: ThemeData.from(
                    colorScheme: ColorScheme.fromSwatch(
                      backgroundColor: Colors.white,
                      cardColor: Colors.pink,
                      primarySwatch: Colors.pink,
                      accentColor: Colors.pink,
                    ),
                  ),
                  child: TextFormField(
                    controller: e.value,
                    cursorColor: Colors.pink,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
            .toList(),
      );

  void _addMeasurement(AddEndpointProvider provider, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        final List<EnableField> toSelect =
        List.from(provider.getAddMeasurementList());
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: Text(
              "Choose field:",
              style: defaultAdminTextStyle.copyWith(color: Colors.teal),
            ),
            contentPadding: EdgeInsets.zero,
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                children: [
                  const Padding(padding: EdgeInsets.all(5)),
                  const Divider(
                    thickness: 2,
                    color: Colors.black12,
                  ),
                  Builder(builder: (context) {
                    if (toSelect.isEmpty) {
                      return Text(
                        "No more fields available",
                        style: defaultAdminTextStyle.copyWith(
                          fontSize: 20,
                          color: Colors.black45,
                        ),
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                        controller: ScrollController(),
                        shrinkWrap: true,
                        itemCount: toSelect.length,
                        itemBuilder: (context, i) => Column(
                          children: [
                            ListTile(
                              leading: Text(
                                toSelect[i].label,
                                style: defaultAdminTextStyle.copyWith(
                                  fontSize: 20,
                                  color: Colors.black45,
                                ),
                              ),
                              onTap: () {
                                provider
                                    .addPathTextFieldController(toSelect[i]);
                                Navigator.of(context).pop();
                              },
                            ),
                            const Divider(
                              thickness: 2,
                              color: Colors.black12,
                            ),
                          ],
                        ),
                      ),
                    );
                  },),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Container _buildButtonContainer(BuildContext context) => Container(
    margin: const EdgeInsets.symmetric(vertical: 20),
    width: MediaQuery.of(context).size.width,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        discardChangesButton(context),
        saveButton(
              () => showAlertDialog(
            context,
            "Save changes?",
            "You're about to add new endpoint",
                () => _saveEditedChanges(context),
          ),
        )
      ],
    ),
  );

  void _saveEditedChanges(BuildContext context) {
    Provider.of<AddEndpointProvider>(context, listen: false)
        .saveAddedEndpoint()
        .then((_) {
      buildSnackbar(
        "Endpoint saved",
        context,
        duration: 3,
        color: adminGreenColor,
        height: 65,
      );
      Navigator.of(context).pop(true);
      return Future.value();
    }).onError(
          (error, stackTrace) => buildSnackbar(
        "Cannot save endpoint",
        context,
        duration: 3,
        color: Colors.red,
        height: 65,
      ),
    );
  }
}
