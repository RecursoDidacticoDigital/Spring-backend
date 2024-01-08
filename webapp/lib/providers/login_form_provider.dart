// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier{

  // ignore: unnecessary_new
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String account = '';
  String password = '';

  bool validateForm(){
    
    if(formKey.currentState!.validate()){
      //print('Form valid ... Login');
      //print('$account === $password');
      return true;
    } else {
      print('Form not valid');
      return false;
    }
  }
}
