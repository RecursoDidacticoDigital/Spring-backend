import 'package:flutter/material.dart';

class CustomInputs{

  static InputDecoration loginInputDecoration({
    required String hint,
    required String label,
    required IconData icon,
  }){
    return InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white.withOpacity(0.3),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
      ),
      hintText: hint,
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.grey),
      hintStyle: const TextStyle(color: Colors.grey),
      labelStyle: const TextStyle(color: Colors.grey),
    );
  }

  static InputDecoration searchInputDecoration({
    required String hint,
    required String label,
    required IconData icon,
  }){
    return InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white.withOpacity(0.3),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
      ),
      hintText: hint,
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.grey),
      hintStyle: const TextStyle(color: Colors.grey),
      labelStyle: const TextStyle(color: Colors.grey),
    );
  }

  static InputDecoration reservationInputDecoration({
    required String hint,
    required String label,
    required IconData icon,
  }){
    return InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.indigo.shade900,
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
      hintText: hint,
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.blue.shade800),
      hintStyle: TextStyle(color: Colors.blue.shade800),
      labelStyle: TextStyle(color: Colors.blue.shade800),
    );
  }
}