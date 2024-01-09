// ignore_for_file: avoid_print


import 'package:provider/provider.dart';
import '../api/classroomsApi.dart';
import '../models/http/classrooms_response.dart';
import '../models/http/requests_response.dart';
import 'package:flutter/material.dart';

class RequestsDTS extends DataTableSource{
  
  final List<Solicitudes> solicitudes;
  final BuildContext context;

  RequestsDTS(this.context, {required this.solicitudes});

  @override
  DataRow getRow(int index) {
    // Getting all the necessary data
    final classroomProvider = Provider.of<ClassroomsApi>(context);
    final solicitud = solicitudes[index];
    List<Salones> salones = classroomProvider.getClassroomById(solicitud.classroomId);
    Salones salon = salones[0];

    String startTime = getTimeblockStart(solicitud.timeblock);
    String endTime = getTimeblockEnd(solicitud.timeblock);
    
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell( Text(solicitud.memberName) ),
        DataCell( Text(solicitud.memberAccount) ),
        DataCell( Text(solicitud.department) ),
        DataCell( Text(salon.name) ),
        DataCell( Text(solicitud.subject) ),
        DataCell( Text(solicitud.day.toString()) ),
        DataCell( Text("$startTime-$endTime") ),
        DataCell( Text("Estado: ${solicitud.approved.toString()}") ),
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

  int get rowCount => solicitudes.length;

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

