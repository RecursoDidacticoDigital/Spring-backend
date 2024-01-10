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

      // Save JWT token
      await LocalStorages.saveJwt(authResponse.jwt); // Assuming saveJwt is an async function

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

    ApiClient.post('/members', data).then(
      (json){
        final authResponse = AuthResponses.fromMap(json);
        user = authResponse.user;

        authStatus = AuthStatus.authenticated;
        
        LocalStorages.prefs.setString('jwt', authResponse.jwt);
        
        NavigationService.replaceTo(Flurorouter.dashboardRoute);

        ApiClient.configureDio();
        notifyListeners();

      }
    ).catchError((e){
      print('error en: $e');
      NotificationsService.showSnackbarError('User / Contraseña / Correo no válidos');
    });
  }

  Future<bool> isAuthenticated() async {

    final jwt = LocalStorages.prefs.getString('jwt');

    if( jwt == null ) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }

    try {
      final resp = await ApiClient.httpGet('/');
      final authResponse = AuthResponses.fromMap(resp);
      LocalStorages.prefs.setString('jwt', authResponse.jwt);

      user = authResponse.user;
      authStatus = AuthStatus.authenticated;
      notifyListeners();
      return true;

    } catch (e) {
      print(e);
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }
  }

  logout(){
    LocalStorages.prefs.remove('jwt');
    authStatus = AuthStatus.notAuthenticated;
    notifyListeners();
  }
}