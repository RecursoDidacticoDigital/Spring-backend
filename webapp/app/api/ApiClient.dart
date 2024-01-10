// ignore_for_file: avoid_print

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

import '../services/local_storage.dart';

class ApiClient {

  static final Dio _dio = Dio();

  static void configureDio(){

    // Base del url
    _dio.options.baseUrl = 'http://localhost:8081/api';

    // Configurar headers
    _dio.options.headers = {
      'Content-Type': 'Application/json',
      //'jwt': LocalStorages.prefs.getString('jwt') ?? ''
    };
    print("Headers: ${_dio.options.headers}");
  }

  static Future httpGet(String path) async{
    var headers = await _getHeaders();
    try{
      final resp = await _dio.get(path, options: Options(headers: headers));
      return resp.data;

    } catch(e){
      print(e);
      throw('Error en el GET');
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
    var headers = await _getHeaders();
    var formData = json.encode(data);

    try{
      final resp = await _dio.put(path, data: formData);
      return resp.data;

    } catch(e){
      print(e);
      throw('Error en el PUT');
    }
  }

  static Future<Map<String, String>> _getHeaders() async{
    String jwt = await LocalStorages.readJwt();
    return{
      'Content-Type': 'Application/json',
      'Authorization': 'Bearer $jwt',
    };
  }
}