import '../../api/authApi.dart';
import '../../api/subjectsApi.dart';
import '../../models/http/subjects_response.dart';
import '../../providers/classroom_name_provider.dart';
import '../../providers/classroom_name_provider.dart';
import '../../providers/classroom_provider.dart';
import '../cards/white_card.dart';
import '../labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../router/router.dart';
import '../../services/navigation_service.dart';
import '../shared/widgets/classroom_item.dart';

class Ed1View extends StatefulWidget {
  const Ed1View({super.key});

  @override
  State<Ed1View> createState() => _Ed1ViewState();
}

class _Ed1ViewState extends State<Ed1View> {
  List<Subject> materias = [];
  bool isDataLoaded = false;

  void loadData() async{
    if(!isDataLoaded){
      final classroomNameProvider = Provider.of<ClassroomNameProvider>(context, listen:false);
      final subjectsApi = Provider.of<SubjectsApi>(context, listen: false);

      try {
        await subjectsApi.getSubjectByString(classroomNameProvider.getClassroom());
        setState((){
          materias = subjectsApi.materias;
          isDataLoaded = true;
        });
      } catch (e) {
        print("ERROR EN EL VIEW: $e");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadData();
  }

  // Si se quiere limitar el número de filas por página.
  @override
  Widget build(BuildContext context) {
    final classroomNameProvider = Provider.of<ClassroomNameProvider>(context, listen: false);
    final authRole = Provider.of<AuthApi>(context).role!;
    final user = Provider.of<AuthApi>(context).user!;

    // ignore: avoid_unnecessary_containers
    return ChangeNotifierProvider<ClassroomProvider>(
      create: (context) => ClassroomProvider(),
      child: Consumer<ClassroomProvider>(
        builder: (context, classroomProvider, child){

          void navigateTo(String routeName){
            NavigationService.navigateTo(routeName);
          }

          return ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              Text('Edificio 1', style: CustomLabels.h1),
              
              WhiteCard(
                title: authRole,
                child: Text("Hola ${user.username}")
              ),
          
              const SizedBox(height: 20),
              
              LayoutBuilder(
                builder: (context, constraints){
                  double maxWidth = constraints.maxWidth;
                  double maxHeight = constraints.maxHeight;
                  double leftPosition = maxWidth * 0.5;
                  double leftPositionOffset = leftPosition*0.0153;
                  double leftCorrection = leftPosition*0.148;
                  double topPositionBase = 125;
                  double yPositionOffset1 = 90;
                  double yPositionOffset2 = 210;
          
                  return InteractiveViewer(
                    boundaryMargin: const EdgeInsets.all(20.0),
                    minScale: 0.1,
                    maxScale: 1,
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Image.asset(
                          'ESCOMAP_Ed1_PB.png'
                        ),
                        /*SvgPicture.network(
                          'https://drive.google.com/uc?export=view&id=1vvNKi2ylMkLA-JAjphgmkOBcDkS49kF4'
                        ),*/
                        // Classrooms
                        Positioned(       //cuando width es 2050, left = leftPosition - offset - 150
                                          //cuando width es 1969, left = leftPosition - offset - 175
                          left: leftPosition-leftPositionOffset-leftCorrection,
                          top: topPositionBase+(yPositionOffset1*0),
                          child: ClassroomItem(
                            classroom: "1001",
                            label: '                    ',
                            onPressed: () {
                              classroomNameProvider.setClassroom("1001");
                              navigateTo(Flurorouter.classroomScheduleRoute);
                            },
                          ),
                        ),
                        Positioned(
                          left: leftPosition-leftPositionOffset-leftCorrection,
                          top: topPositionBase+(yPositionOffset1*1),
                          child: ClassroomItem(
                            classroom: "1002",
                            label: '                    ',
                            onPressed: () {
                              classroomNameProvider.setClassroom("1002");
                              navigateTo(Flurorouter.classroomScheduleRoute);
                            },
                          ),
                        ),
                        Positioned(
                          left: leftPosition-leftPositionOffset-leftCorrection,
                          top: topPositionBase+(yPositionOffset1*2),
                          child: ClassroomItem(
                            classroom: "1003",
                            label: '                    ',
                            onPressed: () {
                              classroomNameProvider.setClassroom("1003");
                              navigateTo(Flurorouter.classroomScheduleRoute);
                            },
                          ),
                        ),
                        Positioned(
                          left: leftPosition-leftPositionOffset-leftCorrection,
                          top: topPositionBase+(yPositionOffset1*3),
                          child: ClassroomItem(
                            classroom: "1004",
                            label: '                    ',
                            onPressed: () {
                              classroomNameProvider.setClassroom("1004");
                              navigateTo(Flurorouter.classroomScheduleRoute);
                            },
                          ),
                        ),
                        Positioned(
                          left: leftPosition-leftPositionOffset-leftCorrection,
                          top: 630-15,
                          child: ClassroomItem(
                            classroom: "1005",
                            label: '                    ',
                            onPressed: () {
                              classroomNameProvider.setClassroom("1005");
                              navigateTo(Flurorouter.classroomScheduleRoute);
                            },
                          ),
                        ),
                        Positioned(
                          left: leftPosition-leftPositionOffset-leftCorrection,
                          top: 720-15,
                          child: ClassroomItem(
                            classroom: "1006",
                            label: '                    ',
                            onPressed: () {
                              classroomNameProvider.setClassroom("1006");
                              navigateTo(Flurorouter.classroomScheduleRoute);
                            },
                          ),
                        ),
                        Positioned(
                          left: leftPosition-leftPositionOffset-leftCorrection,
                          top: 810-15,
                          child: ClassroomItem(
                            classroom: "1007",
                            label: '                    ',
                            onPressed: () {
                              classroomNameProvider.setClassroom("1007");
                              navigateTo(Flurorouter.classroomScheduleRoute);
                            },
                          ),
                        ),
                        Positioned(
                          left: leftPosition-leftPositionOffset-leftCorrection,
                          top: 1077-15,
                          child: ClassroomItem(
                            classroom: "1008",
                            label: '                    ',
                            onPressed: () {
                              classroomNameProvider.setClassroom("1008");
                              navigateTo(Flurorouter.classroomScheduleRoute);
                            },
                          ),
                        ),
                        Positioned(
                          left: leftPosition-leftPositionOffset-leftCorrection,
                          top: 1167-10,
                          child: ClassroomItem(
                            classroom: "1009",
                            label: '                    ',
                            onPressed: () {
                              classroomNameProvider.setClassroom("1009");
                              navigateTo(Flurorouter.classroomScheduleRoute);
                            },
                          ),
                        ),
                        Positioned(
                          left: leftPosition-leftPositionOffset-leftCorrection,
                          top: 1257-10,
                          child: ClassroomItem(
                            classroom: "1010",
                            label: '                    ',
                            onPressed: () {
                              classroomNameProvider.setClassroom("1010");
                              navigateTo(Flurorouter.classroomScheduleRoute);
                            },
                          ),
                        ),
                        Positioned(
                          left: leftPosition-leftPositionOffset-leftCorrection,
                          top: 1347-10,
                          child: ClassroomItem(
                            classroom: "1011",
                            label: '                    ',
                            onPressed: () {
                              classroomNameProvider.setClassroom("1011");
                              navigateTo(Flurorouter.classroomScheduleRoute);
                            },
                          ),
                        ),
                        Positioned(
                          left: leftPosition-leftPositionOffset-leftCorrection,
                          top: 1567-15,
                          child: ClassroomItem(
                            classroom: "1012",
                            label: '                    ',
                            onPressed: () {
                              classroomNameProvider.setClassroom("1012");
                              navigateTo(Flurorouter.classroomScheduleRoute);
                            },
                          ),
                        ),
                        Positioned(
                          left: leftPosition-leftPositionOffset-leftCorrection,
                          top: 1657-15,
                          child: ClassroomItem(
                            classroom: "1013",
                            label: '                    ',
                            onPressed: () {
                              classroomNameProvider.setClassroom("1013");
                              navigateTo(Flurorouter.classroomScheduleRoute);
                            },
                          ),
                        ),
                        Positioned(
                          left: leftPosition-leftPositionOffset-leftCorrection,
                          top: 1747-15,
                          child: ClassroomItem(
                            classroom: "1014",
                            label: '                    ',
                            onPressed: () {
                              classroomNameProvider.setClassroom("1014");
                              navigateTo(Flurorouter.classroomScheduleRoute);
                            },
                          ),
                        ),
                      ]
                    ),
                  );
                },
              )
            ],
          );
        }
      )
    );
  }
}