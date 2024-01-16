import '../../api/authApi.dart';
import '../cards/white_card.dart';
import '../labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../router/router.dart';
import '../../services/navigation_service.dart';
import '../shared/widgets/classroom_item.dart';

class Ed2View extends StatelessWidget {
  const Ed2View({super.key});

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
          Text('Edificio 2', style: CustomLabels.h1),
          
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
                  'ESCOMAP_Ed2_PB.png'
                ),
                /*SvgPicture.network(
                  'https://drive.google.com/uc?export=view&id=11IDUyQJMTFaFyXuUx7mhS1gz_VPksmj0'
                ),*/
                // Classrooms
                Positioned(
                  left: 5.0,
                  top: 5.0,
                  child: ClassroomItem(
                    classroom: "2001",
                    label: 'Classroom 2001',
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