import 'EndpointData.dart';

class ChartData {
  late num? Function(EndpointData, int?) measureFnCallback;
  late String name;
  late String unit;

  ChartData(this.measureFnCallback, this.name, this.unit);
}