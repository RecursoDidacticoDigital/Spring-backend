// ignore_for_file: avoid_print

import 'dart:io';

import '../models/http/http_response.dart';
import '../services/notifications_service.dart';
import 'ApiClient.dart';
import '../models/http/subjects_response.dart';
import 'package:flutter/material.dart';


class SubjectsApi extends ChangeNotifier {
  static int _lastId = 749;
  List<Subject> materias = [];

  Future<void> postSubjectfromRequest(String name, String classroom, String teacher, int dayid, int timeblockid) async{
    _lastId++;
    final data = {
      'id': _lastId,
      'group': "RESER",
      'name' : name,
      'classroom' : classroom,
      'laboratory' : "NA",
      'teacher' : teacher,
      'dayid1' : 1,
      'dayid2' : 2,
      'dayid3' : 3,
      'dayid4' : 4,
      'dayid5' : 5,
      'timeblockid1' : 0,
      'timeblockid2' : 0,
      'timeblockid3' : 0,
      'timeblockid4' : 0,
      'timeblockid5' : 0,
    };
    switch (dayid) {
        case 1:
            data['timeblockid1'] = timeblockid;
            break;
        case 2:
            data['timeblockid2'] = timeblockid;
            break;
        case 3:
            data['timeblockid3'] = timeblockid;
            break;
        case 4:
            data['timeblockid4'] = timeblockid;
            break;
        case 5:
            data['timeblockid5'] = timeblockid;
            break;
        default:
            data['timeblockid1'] = timeblockid;
            break;
    }
    try{
      var json = await ApiClient.post('/subjects', data);
      final response = Subject.fromMap(json);

      print("${response.name} AGREGADA CON ÉXITO");
      
      notifyListeners();
    } catch(e){
      NotificationsService.showSnackbarError('Error al intentar agregar la actividad');
      print("ERROR EN POST /subjects: $e");
    }
  }

  getSubjects() async{
    final HttpResponses resp = await ApiClient.httpGet('/subjects');
    if(resp.statusCode == 200){
      final List<dynamic> response = resp.data;
      materias = response.map((subjectJson) => Subject.fromMap(subjectJson)).toList();
      notifyListeners();
    } else {
      print("STATUS CODE: ${resp.statusCode}");
    }
    
  }

  getSubjectByString(String str) async{
    final HttpResponses resp = await ApiClient.httpGet('/subjects/findByString/$str');
    if(resp.statusCode == 200){
      final List<dynamic> response = resp.data;
      materias = response.map((subjectJson) => Subject.fromMap(subjectJson)).toList();
      notifyListeners();
    } else {
      print("STATUS CODE: ${resp.statusCode}");
    }
  }

  getSubjectById(int id) async{
    final HttpResponses resp = await ApiClient.httpGet('/subjects/findById/$id');
    if(resp.statusCode == 200){
      final List<dynamic> response = resp.data;
      materias = response.map((subjectJson) => Subject.fromMap(subjectJson)).toList();
      notifyListeners();
    } else {
      print("STATUS CODE: ${resp.statusCode}");
    }
  }

  deleteSubjectById(int id) async{
    try{
      await ApiClient.delete('/subjects/$id');
    } catch(e){
      throw('\n\nError en el DELETE/subjects: $e\n\n');
    }
  }
}