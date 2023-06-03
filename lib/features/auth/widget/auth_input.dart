import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/validators.dart';
import '../../../theme/pallete.dart';

class AuthInput extends StatelessWidget {
  final TextEditingController controller;
  final bool isObscure;
  final TextInputType keyboardType;
  final String hint;

  const AuthInput({
    super.key,
    required this.controller,
    required this.isObscure,
    required this.keyboardType,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        validator:
            Validator(type: keyboardType)
                .validate,
        controller: controller,
        obscureText: isObscure,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(15),
          filled: true,
          fillColor: Pallete.greyColor,
          hintText: hint,
          hintStyle: GoogleFonts.mulish(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
            gapPadding: 0,
          ),
        ),
      ),
    );
  }
}
