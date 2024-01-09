import '../api/authApi.dart';
import '../ui/views/dashboard_view.dart';
import 'package:fluro/fluro.dart';

import '../ui/views/login_view.dart';
import '../ui/views/register_view.dart';
import 'package:provider/provider.dart';

class AdminHandlers{

  static Handler login = Handler(
    handlerFunc: (context, params){

      final authProvider = Provider.of<AuthApi>(context!);

      if(authProvider.authStatus == AuthStatus.notAuthenticated) {
        return const LoginView();
      }
      else {
        return const DashboardView();
      }
    }
  );
  
  static Handler register = Handler(
    handlerFunc: (context, params){

      final authProvider = Provider.of<AuthApi>(context!);

      if(authProvider.authStatus == AuthStatus.notAuthenticated) {
        return const RegisterView();
      }
      else {
        return const DashboardView();
      }
    }
  );
}