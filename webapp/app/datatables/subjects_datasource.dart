// ignore_for_file: avoid_print

import '../models/http/subjects_response.dart';
import 'package:flutter/material.dart';

class SubjectsDTS extends DataTableSource{
  
  final List<Subject> materias;
  final BuildContext context;

  SubjectsDTS(this.context, {required this.materias});

  @override
  DataRow getRow(int index) {
    //final classroomProvider = Provider.of<ClassroomProvider>(context, listen: false);
    final Subject materia = materias[index];
    String grupo = materia.group ??= "----";
    String lab = materia.laboratory ??= "NA";
    
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell( Text(grupo) ),
        DataCell( Text(materia.name) ),
        DataCell( Text(materia.classroom) ),
        DataCell( Text(lab) ),
        DataCell( Text("${getTimeblockStart(materia.timeblockid1)}-${getTimeblockEnd(materia.timeblockid1)}") ),
        DataCell( Text("${getTimeblockStart(materia.timeblockid2)}-${getTimeblockEnd(materia.timeblockid2)}") ),
        DataCell( Text("${getTimeblockStart(materia.timeblockid3)}-${getTimeblockEnd(materia.timeblockid3)}") ),
        DataCell( Text("${getTimeblockStart(materia.timeblockid4)}-${getTimeblockEnd(materia.timeblockid4)}") ),
        DataCell( Text("${getTimeblockStart(materia.timeblockid5)}-${getTimeblockEnd(materia.timeblockid5)}") ),
      ]
    );
  }

  @override

  bool get isRowCountApproximate => false;

  @override

  int get rowCount => materias.length;

  @override

  int get selectedRowCount => 0;

  String getTimeblockStart(int timeblockid){
    switch(timeblockid){
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
  String getTimeblockEnd(int timeblockid){
    switch(timeblockid){
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

