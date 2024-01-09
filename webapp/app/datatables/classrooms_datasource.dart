// ignore_for_file: avoid_print

import '../models/http/classrooms_response.dart';
import 'package:flutter/material.dart';

class ClassroomsDTS extends DataTableSource {

  final List<Salones> salones;

  ClassroomsDTS({required this.salones});

  @override
  DataRow getRow(int index) {
    final salon = salones[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell( Text(salon.number) ),
        DataCell( Text("Nombre del salón: ${salon.name}") ),
        DataCell( Text("Materias: ${salon.subjects}") ),
        DataCell( Text("Edificio: ${salon.building}") ),
        DataCell(
          Row(
            children: [
              IconButton(
                onPressed: (){print('Ver horario del salón');}, 
                icon: const Icon(Icons.looks, color: Colors.black)
              )
            ],
          )
        )
      ]
    );
  }

  @override
  
  bool get isRowCountApproximate => false;

  @override
  
  int get rowCount => salones.length;

  @override
  
  int get selectedRowCount => 0;

}