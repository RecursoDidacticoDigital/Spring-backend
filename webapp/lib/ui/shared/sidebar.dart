import 'package:admin_dashboard_new/api/authApi.dart';
import 'package:admin_dashboard_new/router/router.dart';
import 'package:admin_dashboard_new/services/navigation_service.dart';
import 'package:flutter/material.dart';

import 'package:admin_dashboard_new/providers/sidemenu_provider.dart';

import 'package:admin_dashboard_new/ui/shared/widgets/logo.dart';
import 'package:admin_dashboard_new/ui/shared/widgets/menu_item.dart';
import 'package:admin_dashboard_new/ui/shared/widgets/text_separator.dart';
import 'package:provider/provider.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  void navigateTo(String routeName){
    NavigationService.navigateTo(routeName);
    SideMenuProvider.closeMenu();
  }

  @override
  Widget build(BuildContext context) {

    
    final sideMenuProvider = Provider.of<SideMenuProvider>(context);

    return Container(
      width: 270,
      height: double.infinity,
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [

          const Logo(),

          const SizedBox(height: 50),

          const TextSeparator(text: 'Menu edificios'),

          MenuItem(isActive: sideMenuProvider.currentPage == Flurorouter.dashboardRoute, 
            text: 'Vista general', icon: Icons.map_outlined,
            onPressed: () => navigateTo(Flurorouter.dashboardRoute)
          ),
          MenuItem(isActive: sideMenuProvider.currentPage == Flurorouter.govRoute,
            text: 'Edificio de Gobierno', icon: Icons.assured_workload_outlined, 
            onPressed: () => navigateTo(Flurorouter.govRoute)
          ),
          MenuItem(isActive: sideMenuProvider.currentPage == Flurorouter.ed1Route, 
            text: 'Edificio 1', icon: Icons.looks_one_outlined, 
            onPressed: () => navigateTo(Flurorouter.ed1Route)
          ),
          MenuItem(isActive: sideMenuProvider.currentPage == Flurorouter.ed2Route, 
            text: 'Edificio 2', icon: Icons.looks_two_outlined, 
            onPressed: () => navigateTo(Flurorouter.ed2Route)
          ),
          MenuItem(isActive: sideMenuProvider.currentPage == Flurorouter.ed3Route,
            text: 'Edificio 3', icon: Icons.looks_3_outlined, 
            onPressed: () => navigateTo(Flurorouter.ed3Route)
          ),
          MenuItem(isActive: sideMenuProvider.currentPage == Flurorouter.ed4Route,
            text: 'Edificio 4', icon: Icons.looks_4_outlined, 
            onPressed: () => navigateTo(Flurorouter.ed4Route)
          ),
          MenuItem(isActive: sideMenuProvider.currentPage == Flurorouter.ed5Route,
            text: 'Edificio 5', icon: Icons.looks_5_outlined, 
            onPressed: () => navigateTo(Flurorouter.ed5Route)
          ),
          MenuItem(isActive: sideMenuProvider.currentPage == Flurorouter.edlabRoute,
            text: 'Edificio de Laboratorios', icon: Icons.electric_bolt_outlined, 
            onPressed: () => navigateTo(Flurorouter.edlabRoute)
          ),

          const SizedBox(height: 30),

          const TextSeparator(text: 'Salir'),

          MenuItem(text: 'Cerrar sesión', icon: Icons.logout_outlined, isActive: false, 
            onPressed: (){
              Provider.of<AuthProvider>(context, listen: false).logout();
            }
          ),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color(0xff092044),
        Color(0xff091052)
      ]
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        spreadRadius: 1,
        blurRadius: 10,
        offset: Offset(0, 1)
      )
    ]
  );
}