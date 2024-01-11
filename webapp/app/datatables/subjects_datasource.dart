// ignore_for_file: avoid_print

import '../models/http/subjects_response.dart';
import 'package:flutter/material.dart';

class SubjectsDTS extends DataTableSource{
  
  final List<Subject> materias;

  SubjectsDTS({required this.materias});

  @override
  DataRow getRow(int index) {
    final materia = materias[index];
    materia.group ??= "----";
    materia.laboratory ??= "NA";
    String startTime1 = getTimeblockStart(materia.timeblockId1);
    String endTime1 = getTimeblockEnd(materia.timeblockId1);
    String startTime2 = getTimeblockStart(materia.timeblockId2);
    String endTime2 = getTimeblockEnd(materia.timeblockId2);
    String startTime3 = getTimeblockStart(materia.timeblockId3);
    String endTime3 = getTimeblockEnd(materia.timeblockId3);
    String startTime4 = getTimeblockStart(materia.timeblockId4);
    String endTime4 = getTimeblockEnd(materia.timeblockId4);
    String startTime5 = getTimeblockStart(materia.timeblockId5);
    String endTime5 = getTimeblockEnd(materia.timeblockId5);
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell( Text(materia.group!) ),
        DataCell( Text(materia.name) ),
        DataCell( Text(materia.classroom) ),
        DataCell( Text(materia.laboratory!) ),
        DataCell( Text("$startTime1-$endTime1") ),
        DataCell( Text("$startTime2-$endTime2") ),
        DataCell( Text("$startTime3-$endTime3") ),
        DataCell( Text("$startTime4-$endTime4") ),
        DataCell( Text("$startTime5-$endTime5") ),
      ]
    );
  }

  @override

  bool get isRowCountApproximate => false;

  @override

  int get rowCount => materias.length;

  @override

  int get selectedRowCount => 0;

  String getTimeblockStart(int timeblockId){
    switch(timeblockId){
      case 1: return "07:00:00";
      case 2: return "08:30:00";
      case 3: return "10:30:00";
      case 4: return "12:00:00";
      case 5: return "13:30:00";
      case 6: return "15:00:00";
      case 7: return "16:30:00";
      case 8: return "18:30:00";
      case 9: return "20:00:00";
      default: return "        ";
    }
  }
  String getTimeblockEnd(int timeblockId){
    switch(timeblockId){
      case 1: return "08:30:00";
      case 2: return "10:00:00";
      case 3: return "12:00:00";
      case 4: return "13:30:00";
      case 5: return "15:00:00";
      case 6: return "16:30:00";
      case 7: return "18:00:00";
      case 8: return "20:00:00";
      case 9: return "21:30:00";
      default: return "        ";
    }
  }
}

