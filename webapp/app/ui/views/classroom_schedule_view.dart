import '../../datatables/subjects_datasource.dart';
import '../../models/http/subjects_response.dart';
import '../../api/authApi.dart';
import '../../api/classroomsApi.dart';
import '../../api/subjectsApi.dart';
import '../cards/white_card.dart';
import '../labels/custom_labels.dart';
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
    Provider.of<SubjectsApi>(context, listen: false).getSubjects();
    Provider.of<ClassroomsApi>(context, listen: false).getClassroomByName("1006");
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AuthApi>(context).user!;
    final List<Materias> materias = Provider.of<SubjectsApi>(context).materias;
    // Here I used the materia variable to access one of the subjects on the list.
    final salon = Provider.of<ClassroomsApi>(context).salon!;
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