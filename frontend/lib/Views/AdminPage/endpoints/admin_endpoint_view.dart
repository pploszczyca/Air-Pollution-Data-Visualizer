import 'package:adpv_frontend/Repository/AdminRepository/admin_endpoints_repository.dart';
import 'package:adpv_frontend/Widgets/AdminWidgets/admin_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../DataModels/enable_field.dart';
import '../../../DataModels/field_parser.dart';
import '../../../Widgets/AdminWidgets/admin_styles.dart';

class AdminEndpointView extends StatelessWidget {
  final EndpointAdminData endpointAdminData;
  final Map<int, EnableField> enableFields;
  final Map<int, FieldParser> fieldParsers;

  const AdminEndpointView(
    this.enableFields,
    this.fieldParsers,
    this.endpointAdminData, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: adminAppBar("Endpoints", endpointAdminData.label),
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: FloatingActionButton(
                backgroundColor: Colors.red,
                child: const Icon(Icons.delete_outline_outlined, size: 30),
                onPressed: () {
                  //todo: delete endpoint
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: FloatingActionButton(
                backgroundColor: Colors.teal,
                child: const Icon(Icons.edit, size: 30),
                onPressed: () {
                  //todo: edit endpoint
                },
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              buildSubTitle("Endpoint data", 30),
              _buildBasicInfoList(
                endpointAdminData
                    .getEndpointBasicInfo()
                    .entries
                    .map((e) => MapEntry(e.key, e.value))
                    .toList(),
                context,
              ),
              buildSubTitle("Measurements", 50),
              _buildBasicInfoList(getFieldPathMap(), context),
              SizedBox.fromSize(
                size: const Size(0, 100),
              )
            ],
          ),
        ),
      );

  Container buildSubTitle(String text, double topMargin) => Container(
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
              (e) => TwoRowListTile(e.key, e.value),
            )
            .toList(),
      );

  List<MapEntry> getFieldPathMap() {
    final List<MapEntry> pairList = [];
    for (EndpointAdminField field in endpointAdminData.fieldList) {
      pairList.add(
        MapEntry(field.label, fieldParsers[field.parserId]!.path),
      );
    }
    return pairList;
  }
}

class TwoRowListTile extends StatelessWidget {
  final String leading;
  final String trailing;

  const TwoRowListTile(
    this.leading,
    this.trailing, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 60,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    width: MediaQuery.of(context).size.width * 0.3,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      leading,
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
                      trailing,
                      style: defaultAdminTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              thickness: 2,
              color: Colors.black12,
            ),
          ],
        ),
      );
}
