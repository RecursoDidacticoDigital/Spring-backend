// ignore_for_file: avoid_print, unnecessary_string_interpolations

import 'package:provider/provider.dart';

import '../api/classroomsApi.dart';
import '../api/requestsApi.dart';
import '../api/subjectsApi.dart';
import '../models/http/classrooms_response.dart';
import '../models/http/requests_response.dart';
import 'package:flutter/material.dart';
import '../providers/reservation_form_provider.dart';

class RequestsDTS extends DataTableSource{
  final List<Request> solicitudes;
  final List<Classroom> salones;
  final BuildContext context;
  final ReservationFormProvider reservationFormProvider;
  final RequestsApi requestsApi;

  RequestsDTS({
    required this.context,
    required this.salones,
    required this.solicitudes,
    required this.requestsApi,
    required this.reservationFormProvider
  });

  @override
  DataRow getRow(int index) {
    try{
      if(index < 0 || index >= solicitudes.length){
      // Manejar índice fuera de rango
      return DataRow.byIndex(index: index, cells: _emptyCells(9));
      }
      
    } catch(e){
      print("\n\nError generando celdas: $e\n\n");
    }

    // Getting all the necessary data

    final solicitud = solicitudes[index];
    String startTime = getTimeblockStart(solicitud.timeblock);
    String endTime = getTimeblockEnd(solicitud.timeblock);
    final classroomProvider = Provider.of<ClassroomsApi>(context, listen: false);
    bool isApproved = false;

    if(solicitud.approved == 1){
      // No mostrar solicitudes aprovadas
      return DataRow.byIndex(index: index, cells: _emptyCells(9));
    }
    print("Solicitud: ${solicitud.approved}");
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell( Text(solicitud.memberName) ),
        DataCell( Text(solicitud.memberAccount) ),
        DataCell( Text(solicitud.department) ),
        DataCell( Text(solicitud.classroom) ),
        DataCell( Text(solicitud.subject) ),
        DataCell( Text("${getDay(solicitud.day)}") ),
        DataCell( Text("$startTime-$endTime") ),
        DataCell( Text(setState(getState(solicitud.approved))) ),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.check_box_outline_blank_outlined, 
                  
                  color: Colors.lightBlue.shade900
                ),
                onPressed: (){
                  final subjectProvider = Provider.of<SubjectsApi>(context, listen: false);

                  try {
                    subjectProvider.postSubjectfromRequest(
                      reservationFormProvider.name = solicitud.subject,
                      reservationFormProvider.classroom = solicitud.classroom,
                      reservationFormProvider.teacher = solicitud.memberName,
                      reservationFormProvider.dayId = solicitud.day,
                      reservationFormProvider.timeblockId = solicitud.timeblock
                    );
                    solicitud.approved = 1;
                  } catch (e) {
                    throw("Error al intentar  agregar la actividad: $e");
                  }
                },
                mouseCursor: SystemMouseCursors.click,
              )
            ]
          )
        )
      ]
    );
  }

  List<DataCell> _emptyCells(int count){
    return List.generate(count, (_) => const DataCell(Text('')));
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

  int getState(int? state){
    if(state == null){
      return 0;
    }
    return state;
  }

  String setState(int state){
    switch(state){
      case 1: return "Aceptada";
      case 0: return "No aceptada";
      default: return "No aceptada";
    }
  }
}

