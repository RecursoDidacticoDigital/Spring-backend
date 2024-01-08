import 'package:admin_dashboard_new/api/EscomapMainApi.dart';
import 'package:admin_dashboard_new/models/http/requests_response.dart';
import 'package:flutter/material.dart';


class RequestsProvider extends ChangeNotifier {
  List<Solicitudes> solicitudes = [];

  getRequests() async{
    final resp = await EscomapApi.httpGet('/requests');
    final requestsResp = RequestsResponse.fromMap(resp);

    solicitudes = [...requestsResp.solicitudes];

    notifyListeners();
  }
}