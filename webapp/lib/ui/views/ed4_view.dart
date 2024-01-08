import 'package:admin_dashboard_new/api/authApi.dart';
import 'package:admin_dashboard_new/ui/cards/white_card.dart';
import 'package:admin_dashboard_new/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Ed4View extends StatelessWidget {
  const Ed4View({super.key});


  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AuthProvider>(context).user!;
    // ignore: avoid_unnecessary_containers
    return Container(
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Edificio 4', style: CustomLabels.h1),
          
          WhiteCard(
            title: user.userRole,
            child: Text('Hola ${user.userName}'),
          ),

          const SizedBox(height: 20),

          SizedBox(
            height: 700,
            width: double.infinity,
            child: Center(
              child: InteractiveViewer(
                maxScale: 3.0,
                minScale: 0.01,
                child: SvgPicture.asset(
                  'Salon1001.svg',
                  semanticsLabel: 'Salón 4001',
                  height: 700,
                  width: double.infinity,
                  alignment: Alignment.center,
                  
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}