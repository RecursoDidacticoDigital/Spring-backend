import '../providers/sidemenu_provider.dart';
import 'router.dart';
import '../ui/views/blank_view.dart';
import '../ui/views/ed1_view.dart';
import '../ui/views/ed2_view.dart';
import '../ui/views/ed3_view.dart';
import '../ui/views/ed4_view.dart';
import '../ui/views/ed5_view.dart';
import '../ui/views/edlab_view.dart';
import '../ui/views/gov_view.dart';
import '../ui/views/login_view.dart';
import '../ui/views/request_list_view.dart';
import '../ui/views/user_list_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

import '../api/authApi.dart';
import '../ui/views/dashboard_view.dart';

class DashboardHandlers {

  static Handler requestlist = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthApi>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.requestlistRoute);

      if ( authProvider.authStatus == AuthStatus.authenticated ) {
        return const RequestListView();
      } else {
        return const LoginView();
      }
    }
  );

  static Handler userlist = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthApi>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.userlistRoute);

      if ( authProvider.authStatus == AuthStatus.authenticated ) {
        return const UserListView();
      } else {
        return const LoginView();
      }
    }
  );

  static Handler dashboard = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthApi>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.dashboardRoute);

      if ( authProvider.authStatus == AuthStatus.authenticated ) {
        return const DashboardView();
      } else {
        return const LoginView();
      }
    }
  );

  static Handler gov = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthApi>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.govRoute);

      if ( authProvider.authStatus == AuthStatus.authenticated ) {
        return const GovView();
      } else {
        return const LoginView();
      }
    }
  );

  static Handler ed1 = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthApi>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.ed1Route);

      if ( authProvider.authStatus == AuthStatus.authenticated ) {
        return const Ed1View();
      } else {
        return const LoginView();
      }
    }
  );

  static Handler ed2 = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthApi>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.ed2Route);

      if ( authProvider.authStatus == AuthStatus.authenticated ) {
        return const Ed2View();
      } else {
        return const LoginView();
      }
    }
  );

  static Handler ed3 = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthApi>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.ed3Route);

      if ( authProvider.authStatus == AuthStatus.authenticated ) {
        return const Ed3View();
      } else {
        return const LoginView();
      }
    }
  );

  static Handler ed4 = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthApi>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.ed4Route);

      if ( authProvider.authStatus == AuthStatus.authenticated ) {
        return const Ed4View();
      } else {
        return const LoginView();
      }
    }
  );

  static Handler ed5 = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthApi>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.ed5Route);

      if ( authProvider.authStatus == AuthStatus.authenticated ) {
        return const Ed5View();
      } else {
        return const LoginView();
      }
    }
  );

  static Handler edlab = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthApi>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.edlabRoute);

      if ( authProvider.authStatus == AuthStatus.authenticated ) {
        return const EdlabView();
      } else {
        return const LoginView();
      }
    }
  );

  static Handler blank = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthApi>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.blankRoute);

      if ( authProvider.authStatus == AuthStatus.authenticated ) {
        return const BlankView();
      } else {
        return const LoginView();
      }
    }
  );
}