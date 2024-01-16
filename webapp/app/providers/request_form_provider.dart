// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class RequestFormProvider extends ChangeNotifier {

  // ignore: unnecessary_new
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String memberName = '';
  String memberAccount = '';
  String department = '';
  String subject = '';
  int classroomId = 0;
  String classroom = '';
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