import 'package:admin_dashboard_new/providers/sidemenu_provider.dart';
import 'package:admin_dashboard_new/ui/views/no_page_found_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

class NoPageFoundHandlers{

  static Handler noPageFound = Handler(
    handlerFunc: (context, params){

      Provider.of<SideMenuProvider>(context!, listen: false).setCurrentPageUrl('/404');

      return const NoPageFoundView();
    }
  );
}