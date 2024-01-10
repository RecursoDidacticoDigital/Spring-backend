import 'package:shared_preferences/shared_preferences.dart';

class LocalStorages {

  static late SharedPreferences prefs;

  static Future<void> configurePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveJwt(String token) async{
    await prefs.setString('jwt', token);
  }

  static Future<String> readJwt() async{
    return prefs.getString('jwt') ?? '';
  }
}
