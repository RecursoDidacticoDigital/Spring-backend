import '../../datatables/subjects_datasource.dart';
import '../../models/http/subjects_response.dart';
import '../../api/authApi.dart';
import '../../api/classroomsApi.dart';
import '../../api/subjectsApi.dart';
import '../../providers/classroom_provider.dart';
import '../../services/navigation_service.dart';
import '../buttons/custom_icon_button.dart';
import '../cards/white_card.dart';
import '../labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../router/router.dart';

class ClassroomScheduleView extends StatefulWidget {
  const ClassroomScheduleView({super.key});

  @override
  State<ClassroomScheduleView> createState() => _ClassroomScheduleViewState();
}

class _ClassroomScheduleViewState extends State<ClassroomScheduleView> {

  void navigateTo(String routeName){
    NavigationService.navigateTo(routeName);
  }

  //int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    
    //Cuando se encuentra dentro de la funcion build(), listen suele estar en true,
    //pero en la función init no necesita estar en true.
    final classroomProvider = Provider.of<ClassroomProvider>(context, listen: false);
    Provider.of<SubjectsApi>(context, listen: false).getSubjects();
    Provider.of<ClassroomsApi>(context, listen: false).getClassroomByName(classroomProvider.getClassroom());
  }

  @override
  Widget build(BuildContext context) {
    final classroomProvider = Provider.of<ClassroomProvider>(context, listen: false);
    final authRole = Provider.of<AuthApi>(context).role!;
    final user = Provider.of<AuthApi>(context).user!;
    final List<Subject> materias = Provider.of<SubjectsApi>(context).materias;
    // Here I used the materia variable to access one of the subjects on the list.
    //final List<Classroom> salones = Provider.of<ClassroomsApi>(context).salones;
    //final salon = salones.first;
    //print(salon.name);
    //print(user.username.runtimeType);
    // ignore: avoid_unnecessary_containers
    return Container(
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          // classroomProvider.getClassroom() can be changed for salon.name later.
          Text('Salón ${classroomProvider.getClassroom()}', style: CustomLabels.h1),
          
          WhiteCard(
            title: authRole,
            child: Text("Hola ${user.username}")
          ),

          const SizedBox(height: 10),

            Container(
              constraints: const BoxConstraints(
                maxWidth: 200
              ),
              child: CustomIconButton(
                onPressed: () => navigateTo(Flurorouter.classroomReserveFormRoute), 
                text: "Solicitar una reserva", 
                icon: Icons.edit_calendar_outlined,
              ),
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
            header: Text("Hoja de horarios del salón ${classroomProvider.getClassroom()}"),
          ),
        ],
      ),
    );
  }
}