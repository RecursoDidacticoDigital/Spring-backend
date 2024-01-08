import 'package:admin_dashboard_new/datatables/users_datasource.dart';
import 'package:admin_dashboard_new/models/http/users_response.dart';
import 'package:admin_dashboard_new/providers/auth_provider.dart';
import 'package:admin_dashboard_new/providers/users_provider.dart';
import 'package:admin_dashboard_new/ui/buttons/custom_icon_button.dart';
import 'package:admin_dashboard_new/ui/cards/white_card.dart';
import 'package:admin_dashboard_new/ui/labels/custom_labels.dart';
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

    final user = Provider.of<AuthProvider>(context).user!;
    final List<Usuarios> usuarios = Provider.of<UsersProvider>(context).usuarios;
    // ignore: avoid_unnecessary_containers
    return Container(
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Lista Solicitudes', style: CustomLabels.h1),
          
          WhiteCard(
            title: user.userRole,
            child: Text("Hola ${user.userName}")
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