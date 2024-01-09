import 'ApiClient.dart';
import '../models/http/subjects_response.dart';
import 'package:flutter/material.dart';


class SubjectsApi extends ChangeNotifier {
  List<Materias> materias = [];

  getSubjects() async{
    final resp = await ApiClient.httpGet('/subjects');
    final subjectsResp = SubjectsResponse.fromMap(resp);

    materias = [...subjectsResp.materias];

    notifyListeners();
  }
}