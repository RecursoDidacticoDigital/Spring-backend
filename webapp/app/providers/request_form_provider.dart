// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class RequestFormProvider extends ChangeNotifier {

  // ignore: unnecessary_new
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String memberName = '';
  String memberAccount = '';
  String department = '';
  String subject = '';
  int classroomId = -1;
  int dayId = -1;
  int timeblockId = -1;


  validateForm() {

    if ( formKey.currentState!.validate() ) {
      return true;
    } else {
      print('Form not valid');
      return false;
    }
  }
}