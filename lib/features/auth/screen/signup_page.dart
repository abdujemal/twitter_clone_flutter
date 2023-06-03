import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/core/constants/constants.dart';
import 'package:twitter_clone/features/auth/auth_controller.dart';
import 'package:twitter_clone/features/auth/widget/auth_btn.dart';
import 'package:twitter_clone/theme/pallete.dart';

import '../../../core/utils.dart';
import '../widget/auth_input.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  GlobalKey<FormState> signUpKey = GlobalKey();

  TextEditingController emailTc = TextEditingController();
  TextEditingController nameTc = TextEditingController();
  TextEditingController passwordTc = TextEditingController();
  TextEditingController confPasswordTc = TextEditingController();

  @override
  void dispose() {
    emailTc.dispose();
    passwordTc.dispose();
    nameTc.dispose();
    confPasswordTc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Sign up",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: signUpKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 150),
                AuthInput(
                  controller: nameTc,
                  hint: "Enter name",
                  isObscure: false,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(
                  height: 25,
                ),
                AuthInput(
                  controller: emailTc,
                  hint: "Enter email",
                  isObscure: false,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 25,
                ),
                AuthInput(
                  controller: passwordTc,
                  hint: "Enter password",
                  isObscure: true,
                  keyboardType: TextInputType.visiblePassword,
                ),
                const SizedBox(
                  height: 25,
                ),
                AuthInput(
                  controller: confPasswordTc,
                  hint: "Confirm password",
                  isObscure: true,
                  keyboardType: TextInputType.visiblePassword,
                ),
                const SizedBox(
                  height: 25,
                ),
                Consumer(builder: (context, ref, child) {
                  final authNotifier = ref.read(authNotifierProvider.notifier);
                  bool isLoading = ref.watch(loadingProvider);
                  return isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Pallete.primaryColor,
                          ),
                        )
                      : AuthButton(
                          text: "Sign up",
                          onTap: () async {
                            if (signUpKey.currentState!.validate()) {
                              if (confPasswordTc.text != passwordTc.text) {
                                toast("Please, write the correct password.",
                                    Pallete.favColor);
                              } else {
                                await authNotifier.signUpWEmail(emailTc.text,
                                    passwordTc.text, nameTc.text, context);
                              }
                            }
                          });
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
