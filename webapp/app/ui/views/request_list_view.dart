import '../../api/requestsApi.dart';
import '../../api/subjectsApi.dart';
import '../../datatables/requests_datasource.dart';
import '../../models/http/requests_response.dart';
import '../../api/authApi.dart';
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

  // Si se quiere limitar el número de filas por página.
  //int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  Widget build(BuildContext context) {

    final authRole = Provider.of<AuthApi>(context).role!;
    final user = Provider.of<AuthApi>(context).user!;
    final List<Request> solicitudes = Provider.of<RequestsApi>(context).solicitudes;
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
              DataColumn(label: Text("ID de solicitud")),
              DataColumn(label: Text("Nombre del solicitante")),
              DataColumn(label: Text("Número de empleado")),
              DataColumn(label: Text("Departamento")),
              DataColumn(label: Text("Salón")),
              DataColumn(label: Text("Actividad")),
              DataColumn(label: Text("Día")),
              DataColumn(label: Text("Horario")),
              DataColumn(label: Text("Estado de la solicitud"))
            ], 
            source: RequestsDTS(solicitudes: solicitudes, context),
            header: const Text("Solicitudes de reserva"),
          ),
        ],
      ),
    );
  }
}