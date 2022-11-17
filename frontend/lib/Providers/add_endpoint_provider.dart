import 'package:adpv_frontend/DataModels/field_parser.dart';
import 'package:adpv_frontend/Repository/AdminRepository/admin_endpoints_repository.dart';
import 'package:flutter/cupertino.dart';

import '../DataModels/enable_field.dart';

class AddEndpointProvider extends ChangeNotifier {
  EndpointAdminData endpointAdminData;
  final Map<int, EnableField> enableFields;
  final Map<int, FieldParser> fieldParsers;
  final AdminEndpointsRepository repository = AdminEndpointsRepository();

  Map<String, TextEditingController> basicInfoControllers = {};
  Map<EnableField, TextEditingController> parserPathControllers = {};

  AddEndpointProvider(
      this.endpointAdminData,
      this.enableFields,
      this.fieldParsers,
      ) {
    makeBasicInfoControllers();
    makeFieldsInfoControllers();
  }

  void makeBasicInfoControllers() {
    if (basicInfoControllers.isEmpty) {
      endpointAdminData.getEndpointBasicInfo().entries.forEach((e) {
        basicInfoControllers[e.key] = TextEditingController(text: "");
      });
    }
  }

  void makeFieldsInfoControllers() {
    if (parserPathControllers.isEmpty) {
      for (var element in endpointAdminData.fieldList) {
        parserPathControllers[enableFields[element.fieldId]!] =
            TextEditingController(text: element.path);
      }
    }
  }

  void deleteFieldFromEndpoint(EnableField field) {
    parserPathControllers.remove(field);
    notifyListeners();
  }

  void addPathTextFieldController(EnableField field) {
    parserPathControllers.putIfAbsent(
      field,
          () => TextEditingController(text: ""),
    );
    notifyListeners();
  }

  List<EnableField> getAddMeasurementList() {
    final List<EnableField> result = List.from(enableFields.values);
    result
        .removeWhere((element) => parserPathControllers.keys.contains(element));
    return result;
  }

  Future<void> saveAddedEndpoint() async {
    final String number = basicInfoControllers['number']?.text ??
        endpointAdminData.endpointNumber.toString();
    final String label = basicInfoControllers['label']!.value.text;
    final String sensorUrl = basicInfoControllers['sensorUrl']!.value.text;
    final List<Map<String, String>> fieldAndParserKeys =
    parserPathControllers.entries
        .map(
          (e) => {
        "fieldId": e.key.id.toString(),
        "fieldParserPath": e.value.text,
      },
    )
        .toList();

    await repository
        .addEndpoint(
      number,
      label,
      sensorUrl,
      fieldAndParserKeys,
    )
        .then((value) {
      basicInfoControllers = {};
      parserPathControllers = {};
      makeBasicInfoControllers();
      makeFieldsInfoControllers();
      notifyListeners();
    });
    return;
  }
}
