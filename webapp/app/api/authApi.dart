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
  //String? _token;
  AuthStatus authStatus = AuthStatus.checking;
  Usuario? user;

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

    ApiClient.post('/members/local', data).then(
      (json){
        print(json);
        final authResponse = AuthResponses.fromMap(json);
        user = authResponse.usuario;

        authStatus = AuthStatus.authenticated;
        
        LocalStorages.prefs.setString('jwt', authResponse.token);
        
        NavigationService.replaceTo(Flurorouter.dashboardRoute);

        ApiClient.configureDio();
        notifyListeners();

      }
    ).catchError((e){
      print('error en: $e');
      NotificationsService.showSnackbarError('Número de cuenta / Correo / Contraseña no válidos');
    });
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
        user = authResponse.usuario;

        authStatus = AuthStatus.authenticated;
        
        LocalStorages.prefs.setString('jwt', authResponse.token);
        
        NavigationService.replaceTo(Flurorouter.dashboardRoute);

        ApiClient.configureDio();
        notifyListeners();

      }
    ).catchError((e){
      print('error en: $e');
      NotificationsService.showSnackbarError('Usuario / Contraseña / Correo no válidos');
    });
  }

  Future<bool> isAuthenticated() async {

    final token = LocalStorages.prefs.getString('jwt');

    if( token == null ) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }

    try {
      final resp = await ApiClient.httpGet('/');
      final authResponse = AuthResponses.fromMap(resp);
      LocalStorages.prefs.setString('jwt', authResponse.token);

      user = authResponse.usuario;
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