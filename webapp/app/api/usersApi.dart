import '../models/http/http_response.dart';
import 'ApiClient.dart';
import '../models/http/users_response.dart';
import 'package:flutter/material.dart';


class UsersApi extends ChangeNotifier {
  List<User> usuarios = [];

  getUsers() async{
    final HttpResponses resp = await ApiClient.httpGet('/members');
    
    if (resp.statusCode == 200) {
      final List<dynamic> response = resp.data;
      usuarios = response.map((userJson) => User.fromMap(userJson)).toList();
      notifyListeners();
    } else {
      print("STATUS CODE: ${resp.statusCode}");
    }
  }
}