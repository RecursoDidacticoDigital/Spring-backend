import 'dart:html';

import '../../api/authApi.dart';
import '../cards/white_card.dart';
import '../labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../router/router.dart';
import '../../services/navigation_service.dart';
import '../shared/widgets/Image_widget.dart';
import '../shared/widgets/classroom_item.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  void navigateTo(String routeName){
    NavigationService.navigateTo(routeName);
  }

  @override
  Widget build(BuildContext context) {
    final String imageUrl = "https://drive.google.com/uc?export=view&id=1vIHkMaFAXQRNBFSeTRrTr8gxcdoej6RF";
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
            boundaryMargin: EdgeInsets.all(20.0),
            minScale: 0.05,
            maxScale: 0.1,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                //ImageWidget(imageUrl: imageUrl),
                Image.asset(
                  'ESCOMAP_VistaGeneral.png'
                ),
              ]
            ),
          ),
        ],
      ),
    );
  }
}