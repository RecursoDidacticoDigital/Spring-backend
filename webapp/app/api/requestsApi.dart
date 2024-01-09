import 'ApiClient.dart';
import '../models/http/requests_response.dart';
import 'package:flutter/material.dart';


class RequestsApi extends ChangeNotifier {
  List<Solicitudes> solicitudes = [];

  getRequests() async{
    final resp = await ApiClient.httpGet('/requests');
    final requestsResp = RequestsResponse.fromMap(resp);

    solicitudes = [...requestsResp.solicitudes];

    notifyListeners();
  }
}