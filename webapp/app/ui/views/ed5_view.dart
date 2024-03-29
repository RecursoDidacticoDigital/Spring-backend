import '../../api/authApi.dart';
import '../cards/white_card.dart';
import '../labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Ed5View extends StatelessWidget {
  const Ed5View({super.key});


  @override
  Widget build(BuildContext context) {

    final authRole = Provider.of<AuthApi>(context).role!;
    final user = Provider.of<AuthApi>(context).user!;
    // ignore: avoid_unnecessary_containers
    return Container(
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Edificio 5', style: CustomLabels.h1),
          
          WhiteCard(
            title: authRole,
            child: Text('Hola ${user.username}'),
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
                  semanticsLabel: 'Salón 5001',
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