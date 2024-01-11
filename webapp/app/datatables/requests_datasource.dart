// ignore_for_file: avoid_print
import 'package:provider/provider.dart';
import '../api/classroomsApi.dart';
import '../models/http/classrooms_response.dart';
import '../models/http/requests_response.dart';
import 'package:flutter/material.dart';

class RequestsDTS extends DataTableSource{
  
  final List<Request> solicitudes;
  final BuildContext context;

  RequestsDTS(this.context, {required this.solicitudes});

  @override
  DataRow getRow(int index) {
    // Getting all the necessary data
    final classroomProvider = Provider.of<ClassroomsApi>(context);
    final solicitud = solicitudes[index];
    List<Classroom> salones = classroomProvider.getClassroomById(solicitud.classroomId);
    Classroom salon = salones[0];

    String startTime = getTimeblockStart(solicitud.timeblock);
    String endTime = getTimeblockEnd(solicitud.timeblock);
    
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell( Text(/*solicitud.id.toString()*/"1") ),
        DataCell( Text(/*solicitud.memberName*/"Norman") ),
        DataCell( Text(/*solicitud.memberAccount*/"2018999999") ),
        DataCell( Text(/*solicitud.department*/"Departamento de Sistemas") ),
        DataCell( Text(/*salon.name*/"1006") ),
        DataCell( Text(/*solicitud.subject*/"TTII") ),
        DataCell( Text(/*"$getDay(solicitud.day)"*/"Lunes") ),
        DataCell( Text(/*"$startTime-$endTime"*/"12:00:00-13:30:00") ),
        DataCell( Text(/*"Estado: ${solicitud.approved.toString()}"*/"false") ),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.check_box_outline_blank_outlined, color: Colors.greenAccent),
                onPressed: (){
                  // TODO: Aprobar la solicitud y mandar el POST a la api
                },
                mouseCursor: SystemMouseCursors.click,
              )
            ]
          )
        )
      ]
    );
  }

  @override

  bool get isRowCountApproximate => false;

  @override

  int get rowCount => 5;//solicitudes.length;

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

  String getDay(int dayId){
    switch(dayId){
      case 1: return "Lunes";
      case 2: return "Martes";
      case 3: return "Miércoles";
      case 4: return "Jueves";
      case 5: return "Viernes";
      default: return "      ";
    }
  }
}

