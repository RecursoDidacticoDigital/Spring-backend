import 'package:flutter/material.dart';

import 'api/ApiClient.dart';

import 'api/classroomsApi.dart';
import 'api/requestsApi.dart';
import 'api/subjectsApi.dart';
import 'providers/classroom_name_provider.dart';
import 'providers/classroom_provider.dart';
import 'router/router.dart';

import 'package:provider/provider.dart';
import 'api/authApi.dart';
import 'providers/sidemenu_provider.dart';
import 'api/usersApi.dart';

import 'services/local_storage.dart';
import 'services/navigation_service.dart';
import 'services/notifications_service.dart';

import 'ui/layouts/auth/auth_layout.dart';
import 'ui/layouts/dashboard/dashboard_layout.dart';
import 'ui/layouts/splash/splash_layout.dart';


void main() async{

  await LocalStorages.configurePrefs();
  ApiClient.configureDio();
  Flurorouter.configureRoutes();
  

  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(lazy: false, create: (_) => AuthApi()),

        ChangeNotifierProvider(lazy: false, create: (_) => SideMenuProvider()),

        ChangeNotifierProvider(create: (_) => UsersApi()),

        ChangeNotifierProvider(create: (_) => ClassroomsApi()),

        ChangeNotifierProvider(create: (_) => SubjectsApi()),

        ChangeNotifierProvider(create: (_) => RequestsApi()),

        ChangeNotifierProvider(create: (_) => ClassroomProvider()),

        Provider(create: (_) => ClassroomNameProvider()),
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
        final authProvider = Provider.of<AuthApi>(context);

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