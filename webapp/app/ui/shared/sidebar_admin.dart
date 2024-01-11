import '../../api/authApi.dart';
import '../../router/router.dart';
import '../../services/navigation_service.dart';
import 'package:flutter/material.dart';

import '../../providers/sidemenu_provider.dart';

import 'widgets/logo.dart';
import 'widgets/menu_item.dart';
import 'widgets/text_separator.dart';
import 'package:provider/provider.dart';

class SidebarAdmin extends StatelessWidget {
  const SidebarAdmin({super.key});

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
          
          const TextSeparator(text: 'Menu administrador'),

          MenuItem(isActive: sideMenuProvider.currentPage == Flurorouter.requestlistRoute,
            text: 'Solicitudes de reserva', icon: Icons.request_page_outlined,
            onPressed: () => navigateTo(Flurorouter.requestlistRoute),
          ),
          MenuItem(isActive: sideMenuProvider.currentPage == Flurorouter.userlistRoute,
            text: 'Lista de usuarios', icon: Icons.verified_user_outlined,
            onPressed: () => navigateTo(Flurorouter.userlistRoute),
          ),

          const SizedBox(height: 30),

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
          MenuItem(isActive: sideMenuProvider.currentPage == Flurorouter.edlabRoute,
            text: 'Edificio de Laboratorios', icon: Icons.electric_bolt_outlined, 
            onPressed: () => navigateTo(Flurorouter.edlabRoute)
          ),

          const SizedBox(height: 30),

          const TextSeparator(text: 'Salir'),

          MenuItem(text: 'Cerrar sesión', icon: Icons.logout_outlined, isActive: false, 
            onPressed: (){
              Provider.of<AuthApi>(context, listen: false).logout();
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