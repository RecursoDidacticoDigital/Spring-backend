import '../../api/authApi.dart';
import '../cards/white_card.dart';
import '../labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class EdlabView extends StatelessWidget {
  const EdlabView({super.key});


  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AuthApi>(context).user!;
    // ignore: avoid_unnecessary_containers
    return Container(
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Edificio de Laboratorios', style: CustomLabels.h1),
          
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
                  semanticsLabel: 'Laboratorio 01',
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