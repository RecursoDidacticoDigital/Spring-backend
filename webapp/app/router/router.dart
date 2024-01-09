import 'admin_handlers.dart';
import 'dashboard_handlers.dart';
import 'no_page_found_handlers.dart';
import 'package:fluro/fluro.dart';

class Flurorouter{
  static final FluroRouter router = FluroRouter();

  static String rootRoute = '/auth/login';

  // Auth Router
  static String loginRoute = '/auth/login';
  static String registerRoute = '/auth/register';

  // Admin
  static String requestlistRoute = '/dashboard/requestlist';
  static String userlistRoute = '/dashboard/userlist';

  // Dashboard
  static String dashboardRoute = '/dashboard';
  static String govRoute = '/dashboard/gov';
  static String ed1Route = '/dashboard/ed1';
  static String ed2Route = '/dashboard/ed2';
  static String ed3Route = '/dashboard/ed3';
  static String ed4Route = '/dashboard/ed4';
  static String ed5Route = '/dashboard/ed5';
  static String edlabRoute = '/dashboard/edlab';
  static String blankRoute = '/dashboard/blank';

  
  static void configureRoutes(){
    // AuthRoutes
    router.define(rootRoute, handler: AdminHandlers.login, transitionType: TransitionType.none);
    router.define(loginRoute, handler: AdminHandlers.login, transitionType: TransitionType.none);
    router.define(registerRoute, handler: AdminHandlers.register, transitionType: TransitionType.none);

    // AdminRoutes
    router.define(requestlistRoute, handler: DashboardHandlers.requestlist, transitionType: TransitionType.none);
    router.define(userlistRoute, handler: DashboardHandlers.userlist, transitionType: TransitionType.none);

    // Dashboard
    router.define(dashboardRoute, handler: DashboardHandlers.dashboard, transitionType: TransitionType.none);
    router.define(govRoute, handler: DashboardHandlers.gov, transitionType: TransitionType.none);
    router.define(ed1Route, handler: DashboardHandlers.ed1, transitionType: TransitionType.none);
    router.define(ed2Route, handler: DashboardHandlers.ed2, transitionType: TransitionType.none);
    router.define(ed3Route, handler: DashboardHandlers.ed3, transitionType: TransitionType.none);
    router.define(ed4Route, handler: DashboardHandlers.ed4, transitionType: TransitionType.none);
    router.define(ed5Route, handler: DashboardHandlers.ed5, transitionType: TransitionType.none);
    router.define(edlabRoute, handler: DashboardHandlers.edlab, transitionType: TransitionType.none);
    router.define(blankRoute, handler: DashboardHandlers.blank, transitionType: TransitionType.none);

    // 404
    router.notFoundHandler = NoPageFoundHandlers.noPageFound;
  }
}