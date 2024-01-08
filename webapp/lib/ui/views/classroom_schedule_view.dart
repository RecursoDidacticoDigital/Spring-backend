import 'package:admin_dashboard_new/datatables/subjects_datasource.dart';
import 'package:admin_dashboard_new/models/http/subjects_response.dart';
import 'package:admin_dashboard_new/api/authApi.dart';
import 'package:admin_dashboard_new/api/classroomsApi.dart';
import 'package:admin_dashboard_new/api/subjectsApi.dart';
import 'package:admin_dashboard_new/ui/cards/white_card.dart';
import 'package:admin_dashboard_new/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClassroomScheduleView extends StatefulWidget {
  const ClassroomScheduleView({super.key});

  @override
  State<ClassroomScheduleView> createState() => _ClassroomScheduleViewState();
}

class _ClassroomScheduleViewState extends State<ClassroomScheduleView> {

  //int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    
    //Cuando se encuentra dentro de la funcion build(), listen suele estar en true,
    //pero en la función init no necesita estar en true.
    Provider.of<SubjectsProvider>(context, listen: false).getSubjects();
    Provider.of<ClassroomsProvider>(context, listen: false).getClassroom("1006");
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AuthProvider>(context).user!;
    final List<Materias> materias = Provider.of<SubjectsProvider>(context).materias;
    // Here I used the materia variable to access one of the subjects on the list.
    final salon = Provider.of<ClassroomsProvider>(context).salon!;
    // ignore: avoid_unnecessary_containers
    return Container(
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Salón ${salon.name}', style: CustomLabels.h1),
          
          WhiteCard(
            title: user.userRole,
            child: Text("Hola ${user.userName}")
          ),

          const SizedBox(height: 20),

          PaginatedDataTable(
            columns: const [
              DataColumn(label: Text("Grupo")),
              DataColumn(label: Text("Unidad de aprendizaje")),
              DataColumn(label: Text("Salón")),
              DataColumn(label: Text("Laboratorio")),
              DataColumn(label: Text("Lunes")),
              DataColumn(label: Text("Martes")),
              DataColumn(label: Text("Miercoles")),
              DataColumn(label: Text("Jueves")),
              DataColumn(label: Text("Viernes")),
            ], 
            source: SubjectsDTS( materias: materias),
            header: Text("Hoja de horarios del salón ${salon.name}"),
          ),
        ],
      ),
    );
  }
}