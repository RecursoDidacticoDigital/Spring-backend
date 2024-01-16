// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class ReservationFormProvider extends ChangeNotifier {

  // ignore: unnecessary_new
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String name    = '';
  String classroom = '';
  String teacher = '';
  int dayId = 0;
  int timeblockId = 0;


  validateForm() {

    if ( formKey.currentState!.validate() ) {
      return true;
    } else {
      print('Form not valid');
      return false;
    }
  }
}