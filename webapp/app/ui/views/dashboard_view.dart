import '../../api/authApi.dart';
//import '../../api/classroomsApi.dart';
import '../cards/white_card.dart';
import '../labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});


  @override
  Widget build(BuildContext context) {
    const double classroomWidth = 7;
    const double classroomHeight = 5;
    
    final authRole = Provider.of<AuthApi>(context).role!;
    final user = Provider.of<AuthApi>(context).user!;
    //final salones = Provider.of<ClassroomsApi>(context).salones;
    // ignore: avoid_unnecessary_containers
    return Container(
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Vista general', style: CustomLabels.h1),

          WhiteCard(
            title: authRole,
            child: Text('Hola ${user.username}'),
          ),

          const SizedBox(height: 20),
          
          InteractiveViewer(
            boundaryMargin: const EdgeInsets.all(20.0),
            minScale: 0.1,
            maxScale: 5,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  'ESCOMAP_Planta_baja-Model.svg'
                ),
                // Classrooms
                Positioned(
                  left: 5,
                  top: 5,
                  child: InkWell(
                    onTap: (){},
                    child: Container(
                      width: classroomWidth,
                      height: classroomHeight,
                      color: Colors.blue,
                      child: Icon(
                        Icons.circle_notifications_outlined, color: Colors.red
                      ),
                    )
                  )
                )
              ]
            ),
          ),
        ],
      ),
    );
  }
}