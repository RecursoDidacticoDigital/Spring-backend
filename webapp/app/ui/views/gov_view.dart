import '../../api/authApi.dart';
import '../cards/white_card.dart';
import '../labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class GovView extends StatelessWidget {
  const GovView({super.key});


  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<AuthApi>(context).user!;
    // ignore: avoid_unnecessary_containers
    return Container(
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Edificio de Gobierno', style: CustomLabels.h1),

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
                  semanticsLabel: 'Salón 1001',
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