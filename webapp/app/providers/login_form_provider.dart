// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier{

  // ignore: unnecessary_new
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String account = '';
  String email = '';
  String password = '';

  bool validateForm(){
    
    if(formKey.currentState!.validate()){
      return true;
    } else {
      print('Form not valid');
      return false;
    }
  }
}
