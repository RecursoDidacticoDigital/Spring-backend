import 'package:admin_dashboard_new/datatables/users_datasource.dart';
import 'package:admin_dashboard_new/models/http/users_response.dart';
import 'package:admin_dashboard_new/api/authApi.dart';
import 'package:admin_dashboard_new/api/usersApi.dart';
import 'package:admin_dashboard_new/ui/cards/white_card.dart';
import 'package:admin_dashboard_new/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserListView extends StatefulWidget {
  const UserListView({super.key});

  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {

  //int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    
    //Cuando se encuentra dentro de la funcion build(), listen suele estar en true,
    //pero en la función init no necesita estar en true.
    Provider.of<UsersProvider>(context, listen: false).getUsers();

  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AuthProvider>(context).user!;
    final List<Usuarios> usuarios = Provider.of<UsersProvider>(context).usuarios;
    // ignore: avoid_unnecessary_containers
    return Container(
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Lista de usuarios', style: CustomLabels.h1),
          
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
            source: UsersDTS( usuarios: usuarios, context),
            header: const Text("Todos los usuarios"),
          ),
        ],
      ),
    );
  }
}