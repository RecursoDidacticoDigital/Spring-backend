import '../../api/authApi.dart';
import '../../router/router.dart';
import '../../services/navigation_service.dart';
import '../cards/white_card.dart';
import '../labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../shared/widgets/classroom_item.dart';

class GovView extends StatelessWidget {
  const GovView({super.key});

  void navigateTo(String routeName){
    NavigationService.navigateTo(routeName);
  }

  @override
  Widget build(BuildContext context) {
    
    final authRole = Provider.of<AuthApi>(context).role!;
    final user = Provider.of<AuthApi>(context).user!;
    // ignore: avoid_unnecessary_containers
    return Container(
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Edificio de Gobierno', style: CustomLabels.h1),

          WhiteCard(
            title: authRole,
            child: Text('Hola ${user.username}'),
          ),

          const SizedBox(height: 20),
          
          InteractiveViewer(
            boundaryMargin: EdgeInsets.all(20.0),
            minScale: 0.1,
            maxScale: 5.0,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Image.asset(
                  'ESCOMAP_Gov_PB.png'
                ),
                /*SvgPicture.network(
                  'https://drive.google.com/uc?export=view&id=1uc3T7kHTFow3-nIeZ52_weisX8ZNT-M2'
                ),*/
                // Classrooms
                Positioned(
                  left: 500,
                  top: 250,
                  child: ClassroomItem(
                    label: 'Classroom 1001',
                    onPressed: () => navigateTo(Flurorouter.classroomScheduleRoute),
                  ),
                )
              ]
            ),
          ),
        ],
      ),
    );
  }
}