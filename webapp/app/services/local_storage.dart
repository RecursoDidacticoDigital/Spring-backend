// ignore_for_file: avoid_print

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorages {

  static Future<Map<String, String>> getAuthHeaders() async{
    String jwt = await readJwt();
    if(jwt.isNotEmpty){
      print("\n\n\nJSON WEB TOKEN FOUND\n\n");
      print("RETURNING: Authorization: Bearer $jwt\n\n");
      return {
        'Authorization': 'Bearer $jwt',
      };
    }
    return{};
  }
  static late SharedPreferences prefs;

  static Future<void> saveUser(String userData) async{
    await prefs.setString('user', userData);
  }

  static Future<void> saveRole(String role) async{
    await prefs.setString('role', role);
  }

  static String? readUser() {
    return prefs.getString('user');
  }

  static String? readRole() {
    return prefs.getString('role');
  }

  static Future<void> clearUser() async {
    await prefs.remove('user');
  }

  static Future<void> clearRole() async {
    await prefs.remove('role');
  }

  static Future<void> configurePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveJwt(String token) async{
    await prefs.setString('jwt', token);
  }

  static Future<String> readJwt() async{
    return prefs.getString('jwt') ?? '';
  }

  static Future<void> clearJwt() async{
    await prefs.remove('jwt');
  }
}
