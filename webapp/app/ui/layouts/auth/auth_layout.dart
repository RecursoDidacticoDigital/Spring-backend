import 'widgets/background_image.dart';
import 'widgets/custom_title.dart';
import 'widgets/links_bar.dart';
import 'package:flutter/material.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context). size;

    return Scaffold(
      body: Scrollbar(
        thickness: 10,
        thumbVisibility: true,
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
      
            (size.width > 1000)
            // Desktop
            ? _DesktopBody(child: child)
            // Mobile
            : _MobileBody(child: child),
            // LinksBar
            const LinkBar(),
          ],
        ),
      ),
    );
  }
}

class _MobileBody extends StatelessWidget {
  final Widget child;

  const _MobileBody({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const CustomTitle(),
          SizedBox(
            width: double.infinity,
            height: 520,
            child: child,
          ),
          const SizedBox(
            width: double.infinity,
            height: 400,
            child: Expanded(child: BackgroundImage()),
          )
        ],
      )
    );
  }
}

class _DesktopBody extends StatelessWidget {

  final Widget child;

  const _DesktopBody({required this.child});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height*0.95,
      child: Row(
        children: [
          // Background
          const Expanded(child: BackgroundImage()),
          // View container
          Container(
            width: 600,
            height: double.infinity,
            color: Colors.black,
            child: Column(
              children: [
                const SizedBox(height: 20),
                const CustomTitle(),
                const SizedBox(height: 50),
                Expanded(child: child),
              ],
            ), //TODO: la vista
          )
        ],
      )
    );
  }
}