import 'ApiClient.dart';
import '../models/http/users_response.dart';
import 'package:flutter/material.dart';


class UsersApi extends ChangeNotifier {
  List<Usuarios> usuarios = [];

  getUsers() async{
    final resp = await ApiClient.httpGet('/members');
    final usersResp = UsersResponse.fromMap(resp);

    usuarios = [...usersResp.usuarios];

    notifyListeners();
  }
}