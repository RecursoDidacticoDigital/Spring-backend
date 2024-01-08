import 'package:admin_dashboard_new/api/EscomapApi.dart';
import 'package:admin_dashboard_new/models/http/users_response.dart';
import 'package:flutter/material.dart';


class UsersProvider extends ChangeNotifier {
  List<Usuarios> usuarios = [];

  getUsers() async{
    final resp = await EscomapApi.httpGet('/members');
    final usersResp = UsersResponse.fromMap(resp);

    usuarios = [...usersResp.usuarios];

    notifyListeners();
  }
}