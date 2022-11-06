import 'package:adpv_frontend/Repository/AdminRepository/admin_endpoints_repository.dart';
import 'package:adpv_frontend/Views/AdminPage/endpoints/edit_endpoint_view.dart';
import 'package:adpv_frontend/Widgets/AdminWidgets/admin_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../DataModels/enable_field.dart';
import '../../../DataModels/field_parser.dart';
import '../../../Widgets/AdminWidgets/admin_styles.dart';
import '../../../Widgets/AdminWidgets/confirmation_dialog_modal.dart';
import '../../../Widgets/AdminWidgets/two_row_list_tile.dart';

class AdminEndpointView extends StatelessWidget {
  final EndpointAdminData endpointAdminData;
  final Map<int, EnableField> enableFields;
  final Map<int, FieldParser> fieldParsers;

  AdminEndpointView(
    this.enableFields,
    this.fieldParsers,
    this.endpointAdminData, {
    Key? key,
  }) : super(key: key);

  final AdminEndpointsRepository repository = AdminEndpointsRepository();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: adminAppBar("Endpoints", endpointAdminData.label),
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: _buildFloatingActionButtons(context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildSubTitle("Endpoint data", 30),
              _buildBasicInfoList(
                endpointAdminData
                    .getEndpointBasicInfo()
                    .entries
                    .map((e) => MapEntry(e.key, e.value))
                    .toList(),
                context,
              ),
              _buildSubTitle("Measurements", 50),
              _buildBasicInfoList(_getFieldPathMap(), context),
              SizedBox.fromSize(
                size: const Size(0, 100),
              )
            ],
          ),
        ),
      );

  Row _buildFloatingActionButtons(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: FloatingActionButton(
              backgroundColor: Colors.red,
              child: const Icon(Icons.delete_outline_outlined, size: 30),
              onPressed: () {
                deleteEndpoint(context, endpointAdminData);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: FloatingActionButton(
              backgroundColor: Colors.teal,
              child: const Icon(Icons.edit, size: 30),
              onPressed: () {
                editEndpoint(
                  context,
                  enableFields,
                  fieldParsers,
                  endpointAdminData,
                );
              },
            ),
          )
        ],
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

  Column _buildBasicInfoList(List<MapEntry> pairs, BuildContext context) =>
      Column(
        children: pairs
            .map<Widget>(
              (e) => TwoRowListTile(
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
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    width: MediaQuery.of(context).size.width * 0.7,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      e.value,
                      style: defaultAdminTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      );

  List<MapEntry> _getFieldPathMap() {
    final List<MapEntry> pairList = [];
    for (EndpointAdminField field in endpointAdminData.fieldList) {
      pairList.add(
        MapEntry(field.label, fieldParsers[field.parserId]!.path),
      );
    }
    return pairList;
  }

  void deleteEndpoint(
    BuildContext context,
    EndpointAdminData endpointAdminData,
  ) {
    showAlertDialog(
      context,
      'Delete ' + endpointAdminData.label + '?',
      "You are about to delete this endpoint",
      () {
        repository.deleteEndpoint(endpointAdminData.id);
        Navigator.pop(context); // delete and navigator.pop()
      },
    );
  }

  Future<void> editEndpoint(
    BuildContext context,
    Map<int, EnableField> enableFields,
    Map<int, FieldParser> fieldParsers,
    EndpointAdminData endpointAdminData,
  ) async {
    final changed = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AdminEditEndpointView(
          enableFields,
          fieldParsers,
          endpointAdminData,
        ),
      ),
    );
    if (changed != null) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop(true);
    }
  }
}
