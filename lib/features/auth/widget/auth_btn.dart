import 'package:flutter/material.dart';
import 'package:twitter_clone/theme/pallete.dart';

import '../../../core/common/title_text.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double p;
  final String size;
  const AuthButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.p = 30,
      this.size = 'bg'});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size == 'sm' ? 10 : p, vertical: size == 'sm' ? 10 : 0),
      child: InkWell(
        borderRadius: BorderRadius.circular(size == 'sm' ? 20 : 25),
        onTap: onTap,
        child: Ink(
          height: size == 'sm' ? null : 45,
          width: size == 'sm' ? 80 : double.infinity,
          decoration: BoxDecoration(
            color: Pallete.primaryColor,
            borderRadius: BorderRadius.circular(size == 'sm' ? 20 : 25),
          ),
          child: Center(
            child: TitleText(
              color: Pallete.whiteColor,
              text: text,
              fontSize: size == 'sm' ? 15 : 17,
              fontWeight: size == 'sm' ? FontWeight.normal : FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
