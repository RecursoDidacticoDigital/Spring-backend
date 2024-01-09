import 'package:admin_dashboard_new/api/ApiClient.dart';
import 'package:admin_dashboard_new/models/http/auth_response.dart';
import 'package:admin_dashboard_new/router/router.dart';
import 'package:admin_dashboard_new/services/local_storage.dart';
import 'package:admin_dashboard_new/services/navigation_service.dart';
import 'package:admin_dashboard_new/services/notifications_service.dart';
import 'package:flutter/material.dart';

enum AuthStatus {
  checking,
  authenticated,
  notAuthenticated
}

class AuthProvider extends ChangeNotifier {
  //String? _token;
  AuthStatus authStatus = AuthStatus.checking;
  Usuario? user;

  AuthProvider() {
    isAuthenticated();
  }

  login( String account, String password ) async {

    final data = {
      'password': password,
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
      NotificationsService.showSnackbarError('Número de cuenta / Contraseña no válidos');
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