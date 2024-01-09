import 'ApiClient.dart';
import '../models/http/classrooms_response.dart';
import 'package:flutter/material.dart';


class ClassroomsApi extends ChangeNotifier {
  List<Salones> salones = [];
  Salon? salon;

  getClassrooms() async{
    final resp = await ApiClient.httpGet('/classrooms');
    final classroomsResp = ClassroomsResponses.fromMap(resp);

    salones = [...classroomsResp.salones];

    notifyListeners();
  }

  getClassroomByName(String name) async{
    final resp = await ApiClient.httpGet('/classrooms/$name');
    final classroomResp = ClassroomsResponses.fromMap(resp);

    salones = classroomResp.salones;

    notifyListeners();
  }

  getClassroomById(int id) async{
    final resp = await ApiClient.httpGet('/classrooms/$id');
    final classroomResp = ClassroomsResponses.fromMap(resp);

    salones = classroomResp.salones;

    notifyListeners();
  }
}