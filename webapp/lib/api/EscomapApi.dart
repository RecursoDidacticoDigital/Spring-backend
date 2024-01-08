// ignore_for_file: avoid_print

import 'package:admin_dashboard_new/services/local_storage.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class EscomapApi {

  static final Dio _dio = Dio();

  static void configureDio(){

    // Base del url
    _dio.options.baseUrl = 'http://localhost:8081/api';

    // Configurar headers
    _dio.options.headers = {
      'x-token': LocalStorages.prefs.getString('jwt') ?? ''
    };
  }

  static Future httpGet(String path) async{
    try{

      final resp = await _dio.get(path);

      return resp.data;

    } catch(e){
      print(e);
      throw('Error en el GET');
    }
  }

  static Future getClassroomByName(String name) async {
    try {
      final resp = await _dio.get('/classrooms/$name');
      return resp.data;
    } catch (e) {
      print(e);
      throw('Error en el GET por nombre');
    }
  }

  static Future post(String path, Map<String, dynamic> data) async{

    var formData = json.encode(data);
    //final formData = FormData.fromMap(data);

    try{
      final resp = await _dio.post(path, data: formData);
      return resp.data;

    } catch(e){
      print(e);
      throw('Error en el POST');
    }
  }

  static Future put(String path, Map<String, dynamic> data) async{

    var formData = json.encode(data);

    try{
      final resp = await _dio.put(path, data: formData);
      return resp.data;

    } catch(e){
      print(e);
      throw('Error en el PUT');
    }
  }

}