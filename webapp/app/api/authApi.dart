// ignore_for_file: avoid_print

import 'dart:convert';

import 'ApiClient.dart';
import '../models/http/auth_response.dart';
import '../router/router.dart';
import '../services/local_storage.dart';
import '../services/navigation_service.dart';
import '../services/notifications_service.dart';
import 'package:flutter/material.dart';

enum AuthStatus {
  checking,
  authenticated,
  notAuthenticated
}

class AuthApi
 extends ChangeNotifier {
  //String? _jwt;
  AuthStatus authStatus = AuthStatus.checking;
  User? user;
  String? role;
  bool isLoading = true;

  AuthApi
  () {
    isAuthenticated();
  }

  login( String account, String email, String password ) async {

    final data = {
      'password': password,
      'email': email,
      'account': account
    };

    try {
      var json = await ApiClient.post('/auth/local', data);
      final authResponse = AuthResponses.fromMap(json);
      
      user = authResponse.user;
      role = authResponse.role;
      authStatus = AuthStatus.authenticated;

      NotificationsService.showSnackbarNotification("Datos correctos, iniciando sesión...");
      // Save JWT token
      await LocalStorages.saveJwt(authResponse.jwt);

      NavigationService.replaceTo(Flurorouter.dashboardRoute);
      ApiClient.configureDio();
      notifyListeners();
    } catch (e) {
      print('error en: $e');
      NotificationsService.showSnackbarError('Número de cuenta / Correo / Contraseña no válidos');
    }
  }

  register( String name, String account, String email, String password ) async {

    final data = {
      'name': name,
      'email': email,
      'password': password,
      'account': account
    };

    try {
      var json = await ApiClient.post('/members', data);
      final authResponse = AuthResponses.fromMap(json);
      
      user = authResponse.user;
      role = authResponse.role;
      authStatus = AuthStatus.authenticated;

      // Save JWT token
      await LocalStorages.saveJwt(authResponse.jwt); // Assuming saveJwt is an async function
      await LocalStorages.saveUser(jsonEncode(user!.toMap()));
      await LocalStorages.saveRole(role!);

      NotificationsService.showSnackbarNotification("Usuario registrado");

      NavigationService.replaceTo(Flurorouter.dashboardRoute);
      ApiClient.configureDio();
      notifyListeners();
    } catch (e) {
      print('ERROR EN POST /members: $e');
      NotificationsService.showSnackbarError('Usuario / Contraseña / Correo no válidos');
    }
  }

  Future<bool> isAuthenticated() async {

    final jwt = LocalStorages.prefs.getString('jwt');

    if( jwt == null ) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }

    try {
      print("TRYING TO AUTHENTICATE");
      Map<String, String> headers = await LocalStorages.getAuthHeaders();

      final response = await ApiClient.httpGet('/auth/local/headers');
      print("RESPONSE TYPE: ${response.runtimeType}");
      print("RESPONSE: $response");

      if(response.statusCode == 202){
        print("Request accepted, but no content returned");
        authStatus = AuthStatus.authenticated;
        // Save JWT, user data, and role

        final String? userJson = LocalStorages.readUser();
        if(userJson != null){
          user = User.fromMap(jsonDecode(userJson));
          role = LocalStorages.readRole();
          notifyListeners();
          return true;
        }
        authStatus = AuthStatus.notAuthenticated;
        notifyListeners();
        return false;
        
      } else if (response.data == null){
        print("ERROR: EMPTY RESPONSE FROM SERVER");
        authStatus = AuthStatus.notAuthenticated;
        notifyListeners();
        return false;
      }

      print("RESPONSE STRING: $response");

      try {
        final Map<String, dynamic> resp = jsonDecode(response.data);
        final authResponse = AuthResponses.fromMap(resp);

        LocalStorages.prefs.setString('jwt', authResponse.jwt);
        await LocalStorages.saveJwt(authResponse.jwt);

        user = authResponse.user;
        authStatus = AuthStatus.authenticated;
        notifyListeners();
        return true;
      } catch (e) {
        print("JSON Parsing Error: $e");
        authStatus = AuthStatus.notAuthenticated;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print("ERROR, AUTHENTICATION FAILED: $e");
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }
  }

  logout() {
    LocalStorages.clearJwt();
    LocalStorages.clearUser();
    LocalStorages.clearRole();
    authStatus = AuthStatus.notAuthenticated;
    notifyListeners();
  }
}