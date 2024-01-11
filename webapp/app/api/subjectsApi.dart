import 'ApiClient.dart';
import '../models/http/subjects_response.dart';
import 'package:flutter/material.dart';


class SubjectsApi extends ChangeNotifier {
  List<Subject> materias = [];

  getSubjects() async{
    final List<dynamic> resp = await ApiClient.httpGet('/subjects');

    materias = resp.map((subjectJson) => Subject.fromMap(subjectJson)).toList();

    notifyListeners();
  }
}