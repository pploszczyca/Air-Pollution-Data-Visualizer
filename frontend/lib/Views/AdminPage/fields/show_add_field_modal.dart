import 'package:adpv_frontend/DataModels/field_data.dart';
import 'package:adpv_frontend/Repository/AdminRepository/fields_repository.dart';
import 'package:flutter/material.dart';
import '../../../Widgets/AdminWidgets/admin_buttons.dart';
import '../../../Widgets/AdminWidgets/admin_styles.dart';

MaterialStateProperty<EdgeInsetsGeometry?> buttonPadding =
    MaterialStateProperty.all(const EdgeInsets.all(20));

const underline = UnderlineInputBorder(
  borderSide: BorderSide(color: adminGreenColor, width: 2),
);
const List<FieldType> fieldTypesList = <FieldType>[
  FieldType.FOR_CHART,
  FieldType.STRING,
  FieldType.STATIC_NUMBER
];

void showAddFieldModal(
  BuildContext context,
  FieldsRepository repository,
  Function(int id, String fieldName, String unitName, FieldType fieldType)
      onProceedFunction,
  editMode,
  FieldData? initialFieldData,
) {
  showDialog(
    context: context,
    builder: (_) {
      final TextEditingController fieldNameController =
          TextEditingController(text: editMode ? initialFieldData?.name : '');
      final TextEditingController unitNameController = TextEditingController(
        text: editMode ? initialFieldData?.unit.name : '',
      );
      var currentType =
          editMode ? initialFieldData?.type : fieldTypesList.first;

      return AlertDialog(
        title: const Text('Add field'),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) => SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.31,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    controller: fieldNameController,
                    decoration: const InputDecoration(
                      // enabledBorder: underline,
                      hintText: 'Name',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    controller: unitNameController,
                    decoration: const InputDecoration(
                      hintText: 'Unit',
                      fillColor: Colors.grey,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: DropdownButton<FieldType>(
                    value: currentType,
                    isExpanded: true,
                    elevation: 16,
                    // style: const TextStyle(color: Colors.black),
                    focusColor: Colors.black,
                    underline: Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                    onChanged: (FieldType? value) {
                      setState(() {
                        currentType = value;
                      });
                    },
                    items: fieldTypesList
                        .map<DropdownMenuItem<FieldType>>(
                          (FieldType value) => DropdownMenuItem<FieldType>(
                            value: value,
                            child: Text(value.name.toLowerCase()),
                          ),
                        )
                        .toList(),
                  ),
                )
              ],
            ),
          ),
        ),
        actions: [
          cancelButton(context),
          ElevatedButton(
            onPressed: () => onProceedPressed(
              initialFieldData?.id,
              fieldNameController.text,
              unitNameController.text,
              currentType!,
              onProceedFunction,
              context,
            ),
            style: proceedButtonStyle,
            child: Text(
              editMode ? "Save changes" : "Add",
              style: proceedButtonTextStyle,
            ),
          )
        ],
      );
    },
  );
}

void onProceedPressed(
  int? id,
  String fieldName,
  String unitName,
  FieldType fieldType,
  onProceedFunction,
  context,
) {
  if (fieldName == "") {
    Navigator.pop(context);
  } else {
    onProceedFunction(id, fieldName, unitName, fieldType);
    Navigator.pop(context);
  }
}
