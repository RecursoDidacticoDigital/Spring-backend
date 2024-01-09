// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class RegisterFormProvider extends ChangeNotifier {

  // ignore: unnecessary_new
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String name    = '';
  String account = '';
  String email     = '';
  String password = '';


  validateForm() {

    if ( formKey.currentState!.validate() ) {
      //print('Form valid ... Login');
      //print('$email === $password === $name === $account');
      return true;
    } else {
      print('Form not valid');
      return false;
    }
  }
}