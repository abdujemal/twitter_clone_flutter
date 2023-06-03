import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/core/common/title_text.dart';
import 'package:twitter_clone/core/constants/constants.dart';
import 'package:twitter_clone/features/auth/auth_controller.dart';
import 'package:twitter_clone/theme/pallete.dart';

class GoogleBtn extends StatelessWidget {
  const GoogleBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      bool loading = ref.watch(loadingProvider);
      final authNotifier = ref.read(authNotifierProvider.notifier);
      return
       loading?
       const Center(child: CircularProgressIndicator(color: Pallete.primaryColor),):
       InkWell(
        onTap: () {
          authNotifier.signInWithGoogle(context);
        },
        borderRadius: BorderRadius.circular(10),
        child: Ink(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey,
                    offset: Offset(1, 1),
                    blurRadius: .5,
                    spreadRadius: .2)
              ]),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                AssetConst.googleLogo,
                width: 23,
              ),
              const SizedBox(
                width: 15,
              ),
              const TitleText(
                text: "Continue with Google",
                color: Pallete.textColor,
                fontWeight: FontWeight.w800,
                fontSize: 18,
              )
            ],
          ),
        ),
      );
    });
  }
}
