import '../models/http/http_response.dart';
import '../services/notifications_service.dart';
import 'ApiClient.dart';
import '../models/http/requests_response.dart';
import 'package:flutter/material.dart';


class RequestsApi extends ChangeNotifier {
  List<Request> solicitudes = [];

  getRequests() async{
    final HttpResponses resp = await ApiClient.httpGet('/requests');
    
    if (resp.statusCode == 200) {
      final List<dynamic> response = resp.data;
      solicitudes = response.map((requestJson) => Request.fromMap(requestJson)).toList();
      notifyListeners();
    } else {
      print("STATUS CODE: ${resp.statusCode}");
    }
    
    try {
      
    } catch (e) {
      throw('\n\nError en el GET/requests\n\n');
    }

    notifyListeners();
  }

  postRequests(String username, String useraccount, String department, String classroom, int dayid, int timeblockid, String subject, int approved) async{
    final data = {
      'name': username,
      'email': useraccount,
      'password': department,
      'account': classroom,
      'dayid': dayid,
      'timeblockid': timeblockid,
      'subject': subject,
      'approved': approved
    };

    try{
      var json = await ApiClient.post('/requests', data);
      final formResponse = Request.fromMap(json);

      NotificationsService.showSnackbarError("Solicitud enviada con éxito");

      notifyListeners();
    } catch(e){
      throw('\n\nError en el POST/requests: $e\n\n');
    }
  }

  deleteRequestById(int id) async{
    try {
      await ApiClient.delete('/requests/$id');
    } catch (e) {
      throw('\n\nError en el DELETE/requests: $e\n\n');
    }
  }
}