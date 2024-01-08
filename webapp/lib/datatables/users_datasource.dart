import 'package:admin_dashboard_new/models/http/users_response.dart';
import 'package:admin_dashboard_new/api/authApi.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersDTS extends DataTableSource {

  final List<Usuarios> usuarios;
  final BuildContext context;

  UsersDTS(this.context, {required this.usuarios});

  @override
  DataRow getRow(int index) {
    final user = Provider.of<AuthProvider>(context).user!;
    bool isAdmin;
    final usuario = usuarios[index];
    if(usuario.userRole == 'superadmin' || usuario.userRole == 'administrador'){
      isAdmin = true;
    } else {
      isAdmin = false;
    }
    
    // Return only teachers on the list
    if(user.userRole == 'jefe de departamento'){
      while(usuario.userRole == 'profesor'){
        return DataRow.byIndex(
          index: index,
          cells: [
            DataCell(Text("${usuario.userId}")),
            DataCell(Text(usuario.userName)),
            DataCell(Text(usuario.userAccount)),
            DataCell(Text(usuario.userEmail)),
            DataCell(Text(usuario.userRole)),
            DataCell(
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.edit_outlined, color: Colors.grey.withOpacity(0.5)),
                    onPressed: (){},
                    mouseCursor: SystemMouseCursors.forbidden,
                  ),
                  IconButton(
                    icon: Icon(Icons.delete_outline_outlined, color: Colors.grey.withOpacity(0.5)),
                    onPressed: (){},
                    mouseCursor: SystemMouseCursors.forbidden,
                  )
                ],
              )
            ),
          ]
        );
      }
    }

    // Return all the users except for superadmin
    if(user.userRole == 'administrador'){
      while(usuario.userRole != 'superadmin'){
        return DataRow.byIndex(
          index: index,
          cells: [
            DataCell(Text("${usuario.userId}")),
            DataCell(Text(usuario.userName)),
            DataCell(Text(usuario.userAccount)),
            DataCell(Text(usuario.userEmail)),
            DataCell(Text(usuario.userRole)),
            DataCell(
              Row(
                children: [
                  (isAdmin) 
                  ?IconButton(
                    icon: Icon(Icons.edit_outlined, color: Colors.grey.withOpacity(0.5)),
                    onPressed: (){},
                    mouseCursor: SystemMouseCursors.forbidden,
                  )
                  :IconButton(
                    icon: const Icon(Icons.edit_outlined, color: Colors.black),
                    onPressed: (){
                      print('Editando: $usuario');
                    }
                  ),
                  (isAdmin) 
                  ?IconButton(
                    icon: Icon(Icons.delete_outline_outlined, color: Colors.grey.withOpacity(0.5)),
                    onPressed: (){},
                    mouseCursor: SystemMouseCursors.forbidden,
                  )
                  :IconButton(
                    icon: Icon(Icons.delete_outline_outlined, color: Colors.red.withOpacity(0.5)),
                    onPressed: (){
                      print('Eliminando: $usuario');
                    }
                  )
                ],
              )
            ),
          ]
        );
      }
    }

    // Return all the users if user.userRole == 'superadmin'
    if(user.userRole == 'superadmin'){
      return DataRow.byIndex(
        index: index,
        cells: [
          DataCell(Text("${usuario.userId}")),
          DataCell(Text(usuario.userName)),
          DataCell(Text(usuario.userAccount)),
          DataCell(Text(usuario.userEmail)),
          DataCell(Text(usuario.userRole)),
          DataCell(
            Row(
              children: [
                (isAdmin) 
                ?IconButton(
                  icon: Icon(Icons.edit_outlined, color: Colors.grey.withOpacity(0.5)),
                  onPressed: (){},
                  mouseCursor: SystemMouseCursors.forbidden,
                )
                :IconButton(
                  icon: const Icon(Icons.edit_outlined, color: Colors.black),
                  onPressed: (){
                    print('Editando: $usuario');
                  }
                ),
                (isAdmin) 
                ?IconButton(
                  icon: Icon(Icons.delete_outline_outlined, color: Colors.grey.withOpacity(0.5)),
                  onPressed: (){},
                  mouseCursor: SystemMouseCursors.forbidden,
                )
                :IconButton(
                  icon: Icon(Icons.delete_outline_outlined, color: Colors.red.withOpacity(0.5)),
                  onPressed: (){
                    print('Eliminando: $usuario');
                  }
                )
              ],
            )
          ),
        ]
      );
    }

    // Default return
    return DataRow(
      cells: [
        const DataCell(Text("")),
        const DataCell(Text("")),
        const DataCell(Text("")),
        const DataCell(Text("")),
        const DataCell(Text("")),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit_outlined, color: Colors.grey.withOpacity(0.5)),
                onPressed: (){},
                mouseCursor: SystemMouseCursors.forbidden,
              ),
              IconButton(
                icon: Icon(Icons.delete_outline_outlined, color: Colors.grey.withOpacity(0.5)),
                onPressed: (){},
                mouseCursor: SystemMouseCursors.forbidden,
              )
            ],
          )
        ),
      ]
    );
  }

  @override
  
  bool get isRowCountApproximate => false;

  @override
  
  int get rowCount => usuarios.length; 

  @override
  
  int get selectedRowCount => 0;
}