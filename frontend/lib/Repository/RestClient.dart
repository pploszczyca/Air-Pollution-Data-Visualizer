import 'dart:convert';

import 'package:adpv_frontend/Models/BackendResponse.dart';
import 'package:adpv_frontend/Models/EndpointSummary.dart';
import 'package:adpv_frontend/Repository/AbstractEndpointRepository.dart';
import 'package:adpv_frontend/Repository/URLs.dart';
import 'package:dio/dio.dart';

import '../Models/EndpointData.dart';

class RestClient implements AbstractEndpointRepository{
  final Dio client;

  RestClient(this.client);

  @override
  Future<List<EndpointSummary>> getEndpointSummary() async {
    try {
      Response response = await client.get(backendURL + getDataSummaryURL);

      if (response.statusCode == 200) {
        BackendResponse backendResponse =
            BackendResponse.fromJson(response.data);
        if (backendResponse.error == "") {
          return Future.value(backendResponse.data
              .map<EndpointSummary>((e) => EndpointSummary.fromJson(e))
              .toList());
        }
        //print(backendResponse.error);
      }
    } catch (error) {
      //print(error);
    }

    return Future.value([]);
  }

  @override
  Future<EndpointData> getEndpointData(int id) async{
    try {
      Response response = await client.get(backendURL + getEndpointDataURL, queryParameters: {
        'sensorId': id
      });

      if (response.statusCode == 200) {
        BackendResponse backendResponse = BackendResponse.fromJson(response.data);
        if (backendResponse.error == "") {
         return Future.value(EndpointData(backendResponse.data.map<Map<dynamic, dynamic>>((e) => Map.from(e)).toList()));
        }
        //print(backendResponse.error);
      }
    } catch (error) {
      print(error);
    }

    return Future.value(EndpointData.empty());
  }

}
