import '../models/http/users_response.dart';
import '../api/authApi.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersDTS extends DataTableSource {

  final List<User> usuarios;
  final BuildContext context;

  UsersDTS(this.context, {required this.usuarios});

  @override
  DataRow getRow(int index) {

    final authRole = Provider.of<AuthApi>(context).role!;
    bool isAdmin;
    final usuario = usuarios[index];
    if(usuario.rol == 'SUPERADMIN' || usuario.rol == 'ADMINISTRADOR'){
      isAdmin = true;
    } else {
      isAdmin = false;
    }
    
    // Return only teachers on the list
    if(authRole == 'JEFE DE DEPARTAMENTO'){
      while(usuario.rol == 'profesor'){
        return DataRow.byIndex(
          index: index,
          cells: [
            DataCell(Text("${usuario.id}")),
            DataCell(Text(usuario.name)),
            DataCell(Text(usuario.account)),
            DataCell(Text(usuario.email)),
            DataCell(Text(usuario.rol)),
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

    // Return all the users except for SUPERADMIN
    if(authRole == 'ADMINISTRADOR'){
      while(authRole != 'SUPERADMIN'){
        return DataRow.byIndex(
          index: index,
          cells: [
            DataCell(Text("${usuario.id}")),
            DataCell(Text(usuario.name)),
            DataCell(Text(usuario.account)),
            DataCell(Text(usuario.email)),
            DataCell(Text(authRole)),
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
                    },
                    mouseCursor: SystemMouseCursors.click,
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
                    },
                    mouseCursor: SystemMouseCursors.click,
                  )
                ],
              )
            ),
          ]
        );
      }
    }

    // Return all the users if authRole == 'SUPERADMIN'
    if(authRole == 'SUPERADMIN'){
      return DataRow.byIndex(
        index: index,
        cells: [
          DataCell(Text("${usuario.id}")),
          DataCell(Text(usuario.name)),
          DataCell(Text(usuario.account)),
          DataCell(Text(usuario.email)),
          DataCell(Text(usuario.rol)),
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