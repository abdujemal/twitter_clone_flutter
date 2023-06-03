import 'package:flutter/material.dart';

class Validator {
  final TextInputType type;
  Validator({required this.type});

  String? validate(String? val) {
    RegExp reg = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (val!.isEmpty) {
      return "This Field is required.";
    }
    if (type == TextInputType.emailAddress) {
      if (!reg.hasMatch(val)) {
        return "Please write the correct email";
      }
    }
    if (type == TextInputType.visiblePassword) {
      if (val.length < 8) {
        return "Your password have to be at least 8 chars";
      }
    }
  }
}

