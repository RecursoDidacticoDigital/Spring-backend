import 'package:admin_dashboard_new/providers/sidemenu_provider.dart';
import 'package:flutter/material.dart';

import 'package:admin_dashboard_new/ui/shared/widgets/search_text.dart';
import 'package:admin_dashboard_new/ui/shared/widgets/navbar_avatar.dart';
import 'package:admin_dashboard_new/ui/shared/widgets/notifications_indicator.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;


    return Container(
      width: double.infinity,
      height: 50,
      decoration: buildBoxDecoration(),
      child: Row(
        children: [

          if(size.width <= 1000)
            IconButton(icon: const Icon(Icons.menu_outlined), onPressed: (){
              SideMenuProvider.openMenu();
            }),

          const SizedBox(width: 5),

          // Search input
          if(size.width > 400)
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 250),
              child: const SearchText(),
            ),

          const Spacer(),

          const NotificationsIndicator(),

          const SizedBox(width: 10,),

          const NavbarAvatar(),

          const SizedBox(width: 10,),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        spreadRadius: 1,
        blurRadius: 5,
        offset: Offset(0, 1), // changes position of shadow
      ),
    ],
  );
}