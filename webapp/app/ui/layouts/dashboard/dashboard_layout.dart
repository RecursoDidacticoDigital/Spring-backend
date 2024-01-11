import '../../../api/authApi.dart';
import '../../shared/sidebar_admin.dart';
import 'package:flutter/material.dart';

import '../../../providers/sidemenu_provider.dart';

import '../../shared/navbar.dart';
import '../../shared/sidebar.dart';
import 'package:provider/provider.dart';


class DashboardLayout extends StatefulWidget {

  final Widget child;

  const DashboardLayout({
    Key? key, 
    required this.child
  }) : super(key: key);

  @override
  State<DashboardLayout> createState() => _DashboardLayoutState();
}

class _DashboardLayoutState extends State<DashboardLayout> with SingleTickerProviderStateMixin{

  @override
  void initState() {
    super.initState();
    SideMenuProvider.menuController = AnimationController(
      vsync: this, 
      duration: const Duration(milliseconds: 300)
    );
  }

  @override
  Widget build(BuildContext context) {

    final authRole = Provider.of<AuthApi>(context).role!;
    final size = MediaQuery.of(context).size;
    bool isAdmin;
    if(authRole == 'SUPERADMIN' || authRole == 'ADMINISTRADOR' || authRole == 'JEFE DE DEPARTAMENTO'){
      isAdmin = true;
    } else {isAdmin = false;}

    return Scaffold(
      backgroundColor: const Color(0xFFEDF1F2),
      body: Stack(
        children: [
          Row(
            children: [

              if(size.width > 1000)
                isAdmin 
                ? const SidebarAdmin()
                : const Sidebar()
              ,
              Expanded(
                child: Column(
                  children: [

                    // Navbar
                    const Navbar(),
              
                    // Contenedor de nuestro View
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10), 
                          child: widget.child,)
                    ),
                  ],
                ),
              ),
            ],
          ),

          if(size.width <= 1000)
            AnimatedBuilder(
              animation: SideMenuProvider.menuController, 
              builder: (context, _) => Stack(
                children: [
                  if(SideMenuProvider.isOpen)
                    AnimatedOpacity(
                      opacity: SideMenuProvider.opacity.value, 
                      duration: const Duration(milliseconds: 200),
                      child: GestureDetector(
                        onTap: () => SideMenuProvider.closeMenu(),
                        child: Container(
                          width: size.width,
                          height: size.height,
                          color: Colors.black26,
                        ),
                      ),
                    ),

                  Transform.translate(
                    offset: Offset(SideMenuProvider.movement.value,0),
                    child: isAdmin 
                    ? const SidebarAdmin()
                    : const Sidebar(),
                  )
                ],
              )
            ),
        ],
      )
    );
  }
}