// ignore_for_file: avoid_print

import 'dart:io';

import 'package:dio/dio.dart';
import 'dart:convert';
import '../models/http/http_response.dart';
import '../services/local_storage.dart';

class ApiClient {

  static final Dio _dio = Dio();

  static void configureDio(){

    // Base del url
    _dio.options.baseUrl = 'http://localhost:8085/api';

    // Configurar headers
    _dio.options.headers = {
      'Content-Type': 'Application/json',
      //'jwt': LocalStorages.prefs.getString('jwt') ?? ''
    };
  }

  static Future<HttpResponses> httpGet(String path) async{
    print("PATH RECIBIDO EN EL HEADER: $path");
    try{
      Map<String, String> headers = await LocalStorages.getAuthHeaders();
      //print("HEADERS OBTAINED: $headers");

      final resp = await _dio.get(path, options: Options(headers: headers));
      print("RESPONSE: $resp");
      
      return HttpResponses(data: resp.data, statusCode: resp.statusCode);

    } catch(e){
      print(e);
      throw('Error en el GET: $e');
    }
  }

  static Future post(String path, Map<String, dynamic> data) async{

    var formData = json.encode(data);
    //final formData = FormData.fromMap(data);

    try{
      Map<String, String> headers = await LocalStorages.getAuthHeaders();
      final resp = await _dio.post(path, options: Options(headers: headers), data: formData);
      return resp.data;

    } catch(e){
      print(e);
      throw('Error en el POST: $e');
    }
  }

  static Future put(String path, Map<String, dynamic> data) async{
    Map<String, String> headers = await LocalStorages.getAuthHeaders();
    var formData = json.encode(data);

    try{
      final resp = await _dio.put(path, data: formData, options: Options(headers: headers));
      return resp.data;

    } catch(e){
      print(e);
      throw('Error en el PUT: $e');
    }
  }

  static Future patch(String path, Map<String, dynamic> data) async{
    Map<String, String> headers = await LocalStorages.getAuthHeaders();
    var formData = json.encode(data);

    try{
      final resp = await _dio.patch(path, data: formData, options: Options(headers: headers));
      return resp.data;

    } catch(e){
      print(e);
      throw('Error en el PUT: $e');
    }
  }

  static Future delete(String path) async{
    Map<String, String> headers = await LocalStorages.getAuthHeaders();
    try{
      final resp = await _dio.delete(path, options: Options(headers: headers));
      print(resp.data);
      return resp.data;
    } catch(e){
      print(e);
      throw('Error en el DELETE: $e');
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