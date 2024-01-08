import 'package:admin_dashboard_new/api/EscomapApi.dart';
import 'package:admin_dashboard_new/models/http/classrooms_response.dart';
import 'package:flutter/material.dart';


class ClassroomsProvider extends ChangeNotifier {
  List<Salones> salones = [];
  Salon? salon;

  getClassrooms() async{
    final resp = await EscomapApi.httpGet('/classrooms');
    final classroomsResp = ClassroomsResponses.fromMap(resp);

    salones = [...classroomsResp.salones];

    notifyListeners();
  }

  getClassroom(String name) async{
    final resp = await EscomapApi.getClassroomByName(name);
    final classroomResp = ClassroomsResponses.fromMap(resp);

    salones = classroomResp.salones;

    notifyListeners();
  }
}