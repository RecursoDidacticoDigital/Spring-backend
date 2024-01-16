// ignore_for_file: avoid_print

import '../../datatables/subjects_datasource.dart';
import '../../models/http/subjects_response.dart';
import '../../api/authApi.dart';
import '../../api/subjectsApi.dart';
import '../../providers/classroom_name_provider.dart';
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

  List<Subject> materias = [];
  ClassroomNameProvider? classroomNameProvider;
  late Future<void> _subjectsFuture;

  void navigateTo(String routeName){
    NavigationService.navigateTo(routeName);
  }

  @override
  void initState() {
    super.initState();
    classroomNameProvider = Provider.of<ClassroomNameProvider>(context, listen: false);
    _subjectsFuture = Provider.of<SubjectsApi>(context, listen: false).getSubjects();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _subjectsFuture,
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const CircularProgressIndicator();
        } else if(snapshot.hasError){
          return Text('Error: ${snapshot.error}');
        } else {
          final subjectsApi = Provider.of<SubjectsApi>(context);
          materias = subjectsApi.materias;
          final authRole = Provider.of<AuthApi>(context).role!;
          bool isUser = false;
          final user = Provider.of<AuthApi>(context).user!;
          if(authRole == 'STUDENT') isUser = true;
          return ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              // classroomNameProvider.getClassroom() can be changed for salon.name later.
              Text('Salón ${classroomNameProvider!.getClassroom()}', style: CustomLabels.h1),
              
              WhiteCard(
                title: authRole,
                child: Text("Hola ${user.username}")
              ),

              const SizedBox(height: 10),

              (isUser)
              ?const SizedBox(height: 20)
              :Container(
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
                  DataColumn(label: Text("Grupo", textAlign: TextAlign.center)),
                  DataColumn(label: Text("Unidad de aprendizaje", textAlign: TextAlign.center)),
                  DataColumn(label: Text("Salón", textAlign: TextAlign.center)),
                  DataColumn(label: Text("Laboratorio", textAlign: TextAlign.center)),
                  DataColumn(label: Text("Lunes", textAlign: TextAlign.center)),
                  DataColumn(label: Text("Martes", textAlign: TextAlign.center)),
                  DataColumn(label: Text("Miercoles", textAlign: TextAlign.center)),
                  DataColumn(label: Text("Jueves", textAlign: TextAlign.center)),
                  DataColumn(label: Text("Viernes", textAlign: TextAlign.center)),
                ], 
                source: SubjectsDTS( materias: materias, context),
                header: Text("Hoja de horarios del salón ${classroomNameProvider!.getClassroom()}"),
              ),
            ],
          );
        }
      }
    );
  }
}