import 'package:flutter/material.dart';

import 'package:admin_dashboard_new/api/EscomapMainApi.dart';

import 'package:admin_dashboard_new/router/router.dart';

import 'package:provider/provider.dart';
import 'package:admin_dashboard_new/api/authApi.dart';
import 'package:admin_dashboard_new/providers/sidemenu_provider.dart';
import 'package:admin_dashboard_new/api/usersApi.dart';

import 'package:admin_dashboard_new/services/local_storage.dart';
import 'package:admin_dashboard_new/services/navigation_service.dart';
import 'package:admin_dashboard_new/services/notifications_service.dart';

import 'package:admin_dashboard_new/ui/layouts/auth/auth_layout.dart';
import 'package:admin_dashboard_new/ui/layouts/dashboard/dashboard_layout.dart';
import 'package:admin_dashboard_new/ui/layouts/splash/splash_layout.dart';


void main() async{

  await LocalStorages.configurePrefs();
  EscomapApi.configureDio();
  Flurorouter.configureRoutes();
  

  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(lazy: false, create: (_) => AuthProvider()),

        ChangeNotifierProvider(lazy: false, create: (_) => SideMenuProvider()),

        ChangeNotifierProvider(create: (_) => UsersProvider()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Dashboard',
      initialRoute: Flurorouter.rootRoute,
      onGenerateRoute: Flurorouter.router.generator,
      navigatorKey: NavigationService.navigatorKey,
      scaffoldMessengerKey: NotificationsService.messengerKey,
      builder: (_, child){
        final authProvider = Provider.of<AuthProvider>(context);

        if(authProvider.authStatus == AuthStatus.checking) {
          print('Checking...');
          // ignore: prefer_const_constructors
          return SplashLayout();
        }
        if(authProvider.authStatus == AuthStatus.authenticated) {
          return DashboardLayout(child: child!);
        } else {
          return AuthLayout(child: child!);
        }
      },
      theme: ThemeData.light().copyWith(
        scrollbarTheme: const ScrollbarThemeData().copyWith(
          thumbColor: MaterialStateProperty.all(
            Colors.grey[500]
          ),
        ),
      )
    );
  }
}