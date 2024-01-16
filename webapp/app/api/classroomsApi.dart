import '../models/http/http_response.dart';
import 'ApiClient.dart';
import '../models/http/classrooms_response.dart';
import 'package:flutter/material.dart';


class ClassroomsApi extends ChangeNotifier {
  List<Classroom> salones = [];

  getClassrooms() async{
    final HttpResponses resp = await ApiClient.httpGet('/classrooms');

    if(resp.statusCode == 200){
      final List<dynamic> response = resp.data;
      salones = response.map((classroomJson) => Classroom.fromMap(classroomJson)).toList();
      notifyListeners();
    }
    else{
      print("STATUS CODE: ${resp.statusCode}");
    }
  }

  getClassroomByName(String name) async{
    final HttpResponses resp = await ApiClient.httpGet('/classrooms/findByName/$name');
    
    if(resp.statusCode == 200){
      final List<dynamic> response = resp.data;
      salones = response.map((classroomJson) => Classroom.fromMap(classroomJson)).toList();
      notifyListeners();
    }
    else{
      print("STATUS CODE: ${resp.statusCode}");
    }
  }

  getClassroomById(int id) async{
    final HttpResponses resp = await ApiClient.httpGet('/classrooms/findById/$id');
    if(resp.statusCode == 200){
      final List<dynamic> response = resp.data;
      salones = response.map((classroomJson) => Classroom.fromMap(classroomJson)).toList();
      notifyListeners();
    }
    else{
      print("STATUS CODE: ${resp.statusCode}");
    }
  }
}