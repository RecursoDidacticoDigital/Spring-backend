import 'ApiClient.dart';
import '../models/http/requests_response.dart';
import 'package:flutter/material.dart';


class RequestsApi extends ChangeNotifier {
  List<Request> solicitudes = [];

  getRequests() async{
    final List<dynamic> resp = await ApiClient.httpGet('/requests');
    
    solicitudes = resp.map((requestJson) => Request.fromMap(requestJson)).toList();

    notifyListeners();
  }
}