import 'ApiClient.dart';
import '../models/http/users_response.dart';
import 'package:flutter/material.dart';


class UsersApi extends ChangeNotifier {
  List<User> usuarios = [];

  getUsers() async{
    final List<dynamic> resp = await ApiClient.httpGet('/members');
    //final usersResp = UsersResponse.fromJson(resp).users;

    usuarios = resp.map((userJson) => User.fromMap(userJson)).toList();

    notifyListeners();
  }
}