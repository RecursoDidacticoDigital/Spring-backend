import 'package:admin_dashboard_new/api/ApiClient.dart';
import 'package:admin_dashboard_new/models/http/subjects_response.dart';
import 'package:flutter/material.dart';


class SubjectsProvider extends ChangeNotifier {
  List<Materias> materias = [];

  getSubjects() async{
    final resp = await ApiClient.httpGet('/subjects');
    final subjectsResp = SubjectsResponse.fromMap(resp);

    materias = [...subjectsResp.materias];

    notifyListeners();
  }
}