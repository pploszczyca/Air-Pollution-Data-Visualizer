import 'package:adpv_frontend/Models/fields_list_provider.dart';
import 'package:adpv_frontend/Views/AdminPage/fields/show_add_field_modal.dart';
import 'package:adpv_frontend/Widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../DataModels/field_data.dart';
import '../../../Repository/AdminRepository/fields_repository.dart';
import '../../../Widgets/AdminWidgets/admin_app_bar.dart';
import '../../../Widgets/AdminWidgets/admin_buttons.dart';
import '../../../Widgets/AdminWidgets/admin_styles.dart';
import '../../../Widgets/AdminWidgets/confirmation_dialog_modal.dart';
import '../../../Widgets/AdminWidgets/group_card.dart';
import '../../../Widgets/SortingWidgets/sort_bar.dart';
import '../../snackbar.dart';

class FieldsListView extends StatefulWidget {
  final FieldsRepository repository = FieldsRepository();

  FieldsListView({Key? key}) : super(key: key);

  @override
  State<FieldsListView> createState() => _FieldsListViewState();
}

class _FieldsListViewState extends State<FieldsListView> {
  late Future<List<FieldData>> fields;
  late FieldsListProvider provider;

  @override
  void initState() {
    super.initState();
    fields = widget.repository.getFieldList();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: adminAppBar("Admin panel", "Users list"),
        body: _buildBody(),
        floatingActionButton: _buildAddButton(),
      );

  Widget _buildBody() => FutureBuilder<List<FieldData>>(
        future: fields,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return loadingInCenter();
          } else {
            return ChangeNotifierProvider(
              create: (context) => provider = FieldsListProvider(fields),
              child: Consumer<FieldsListProvider>(
                builder: (context, provider, _) => RefreshIndicator(
                  onRefresh: () => _onPullDownRefresh(provider),
                  child: Column(
                    children: [
                      buildSortBar(
                        provider.sortingModel,
                        () => provider.notify(),
                        provider.fieldsList,
                        provider.getters,
                      ),
                      Expanded(
                        child: _buildList(provider),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      );

  ListView _buildList(FieldsListProvider provider) => ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        children: provider.fieldsList.map(_buildCard).toList(),
      );

  Card _buildCard(
    FieldData fieldData,
  ) =>
      Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ExpansionTile(
          title: SizedBox(
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    fieldData.id.toString(),
                    style: const TextStyle(
                      fontFamily: 'SofiaSans',
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      fieldData.name,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: const TextStyle(
                        fontFamily: 'SofiaSans',
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          collapsedBackgroundColor: Colors.white,
          tilePadding: const EdgeInsets.all(20),
          childrenPadding: const EdgeInsets.all(0),
          children: [
            buildInfoContainer(
              "Type",
              fieldData.type.name.toLowerCase(),
              MediaQuery.of(context).size.width,
            ),
            fieldData.unit.id != -1
                ? buildInfoContainer(
                    "Unit",
                    fieldData.unit.name,
                    MediaQuery.of(context).size.width,
                  )
                : Container(),
            buildDeleteEditButtonRow(
              () => _onDeletePressed(fieldData),
              () => _onEditPressed(fieldData),
            ),
          ],
        ),
      );

  FloatingActionButton _buildAddButton() => FloatingActionButton(
        onPressed: () => showAddFieldModal(
          context,
          widget.repository,
          addField,
          false,
          null,
        ),
        backgroundColor: adminGreenColor,
        child: const Icon(Icons.add),
      );

  void _onDeletePressed(FieldData fieldData) {
    showAlertDialog(
      context,
      'Delete ' + fieldData.name,
      "You are about to delete group with all of its' saved permissions.",
      () => deleteField(fieldData.id),
    );
  }

  void _onEditPressed(FieldData fieldData) {
    showAddFieldModal(
      context,
      widget.repository,
      editField,
      true,
      fieldData,
    );
  }

  void editField(
      int id, String fieldName, String unitName, FieldType fieldType) async {
    await widget.repository
        .editField(id, fieldName, unitName, fieldType)
        .then(
          (newField) => provider.editField(newField),
        )
        .catchError((error) {
      buildSnackbar('Cannot add field', context);
    });
  }

  void deleteField(int id) async {
    await widget.repository
        .deleteField(id)
        .then(
          (value) => {
            if (value)
              {
                provider.delete(id),
              }
          },
        )
        .catchError((error) {
      buildSnackbar('Cannot delete field', context);
    });
  }

  void addField(
      int? id, String fieldName, String unitName, FieldType fieldType) async {
    await widget.repository
        .addField(fieldName, unitName, fieldType)
        .then(
          (newField) => provider.addNewField(newField),
        )
        .catchError((error) {
      buildSnackbar('Cannot add field', context);
    });
  }

  Future<void> _onPullDownRefresh(FieldsListProvider provider) async {
    fields = widget.repository.getFieldList();
    await fields.then((value) => provider.init(value));
  }
}
