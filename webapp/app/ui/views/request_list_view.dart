import '../../datatables/users_datasource.dart';
import '../../models/http/users_response.dart';
import '../../api/authApi.dart';
import '../../api/usersApi.dart';
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
    final List<Usuarios> usuarios = Provider.of<UsersApi>(context).usuarios;
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
              DataColumn(label: Text("ID del usuario")),
              DataColumn(label: Text("Nombre")),
              DataColumn(label: Text("Número de cuenta")),
              DataColumn(label: Text("Correo")),
              DataColumn(label: Text("Rol")),
              DataColumn(label: Text("Acciones")),
            ], 
            source: UsersDTS(usuarios: usuarios, context),
            header: const Text("Solicitudes de reserva"),
          ),
        ],
      ),
    );
  }
}