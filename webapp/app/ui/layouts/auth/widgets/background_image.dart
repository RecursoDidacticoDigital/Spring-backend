import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: buildBoxDecoration(),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
              child: Image(
                image: AssetImage('escom-white-logo.png'),
                width: 400,
              ),
            ),
          ),
        ),
      )
    );
  }

  BoxDecoration buildBoxDecoration() {
    return const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('escom-bg.jpg'),
          fit: BoxFit.cover
        ),
      );
  }
}