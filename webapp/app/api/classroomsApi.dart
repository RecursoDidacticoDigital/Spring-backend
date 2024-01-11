import 'ApiClient.dart';
import '../models/http/classrooms_response.dart';
import 'package:flutter/material.dart';


class ClassroomsApi extends ChangeNotifier {
  List<Classroom> salones = [];

  getClassrooms() async{
    final List<dynamic> resp = await ApiClient.httpGet('/classrooms');

    salones = resp.map((classroomJson) => Classroom.fromMap(classroomJson)).toList();

    notifyListeners();
  }

  getClassroomByName(String name) async{
    final List<dynamic> resp = await ApiClient.httpGet('/classrooms/findByName/$name');
    
    salones = resp.map((classroomJson) => Classroom.fromMap(classroomJson)).toList();

    notifyListeners();
  }

  getClassroomById(int id) async{
    final List<dynamic> resp = await ApiClient.httpGet('/classrooms/findById/$id');
    
    salones = resp.map((classroomJson) => Classroom.fromMap(classroomJson)).toList();

    notifyListeners();
  }
}