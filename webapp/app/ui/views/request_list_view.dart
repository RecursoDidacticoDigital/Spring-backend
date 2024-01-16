// ignore_for_file: avoid_print

import '../../api/classroomsApi.dart';
import '../../api/requestsApi.dart';
import '../../datatables/requests_datasource.dart';
import '../../models/http/classrooms_response.dart';
import '../../models/http/requests_response.dart';
import '../../api/authApi.dart';
import '../../providers/request_form_provider.dart';
import '../../providers/reservation_form_provider.dart';
import '../cards/white_card.dart';
import '../labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestListView extends StatefulWidget {
  const RequestListView({super.key});

  @override
  State<RequestListView> createState() => _RequestListViewState();
}

class _RequestListViewState extends State<RequestListView> {
  List<Request> solicitudes = [];
  List<Classroom> salones = [];
  bool _isLoaded1 = false;
  bool _isLoaded2 = false;
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(!_isLoaded1){
      final requestsApi = Provider.of<RequestsApi>(context, listen: false);
      requestsApi.getRequests().then((_){
        setState((){
          solicitudes = requestsApi.solicitudes;
          _isLoaded1 = true;
        });
      }).catchError((error){
        print("ERROR: $error");
      });
    }
    if(!_isLoaded2){
      final classroomProvider = Provider.of<ClassroomsApi>(context, listen: false);
      classroomProvider.getClassrooms().then((_){
        setState((){
          salones = classroomProvider.salones;
          _isLoaded2 = true;
        });
      }).catchError((error){
        print("ERROR: $error");
      });
    }
  }

  @override
  void initState() {
    super.initState();
    didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    
    return ChangeNotifierProvider(
      create: (_) => ReservationFormProvider(),
      child: Builder(
        builder: (context) {
          final authRole = Provider.of<AuthApi>(context).role!;
          final user = Provider.of<AuthApi>(context).user!;
          final reservationFormProvider = Provider.of<ReservationFormProvider>(context, listen: false);
          final requestsApi = Provider.of<RequestsApi>(context, listen: false);
          // ignore: avoid_unnecessary_containers
          return Container(
            child: ListView(
              physics: const ClampingScrollPhysics(),
              children: [
                Text('Lista Solicitudes', style: CustomLabels.h1),
                
                WhiteCard(
                  title: authRole,
                  child: Text("Hola ${user.username}")
                ),

                const SizedBox(height: 20),

                PaginatedDataTable(
                  columns: const [
                    DataColumn(label: Text("Nombre del solicitante")),
                    DataColumn(label: Text("Número de empleado")),
                    DataColumn(label: Text("Departamento")),
                    DataColumn(label: Text("Salón")),
                    DataColumn(label: Text("Actividad")),
                    DataColumn(label: Text("Día")),
                    DataColumn(label: Text("Horario")),
                    DataColumn(label: Text("Estado de la solicitud")),
                    DataColumn(label: Text("Acciones"))
                  ], 
                  source: RequestsDTS(
                    context: context,
                    salones: salones,
                    solicitudes: solicitudes,
                    requestsApi: requestsApi,
                    reservationFormProvider: reservationFormProvider
                  ),
                  header: const Text("Solicitudes de reserva"),
                ),
              ],
            ),
          );
        }
      )
    );
  }
}