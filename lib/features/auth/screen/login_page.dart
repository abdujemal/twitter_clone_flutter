import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/core/common/title_text.dart';
import 'package:twitter_clone/core/constants/constants.dart';
import 'package:twitter_clone/features/auth/auth_controller.dart';
import 'package:twitter_clone/features/auth/widget/auth_btn.dart';
import 'package:twitter_clone/features/auth/widget/auth_input.dart';
import 'package:twitter_clone/theme/pallete.dart';

import '../widget/signin_google_btn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailTc = TextEditingController();
  TextEditingController passwordTc = TextEditingController();

  GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailTc.dispose();
    passwordTc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Sign in",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: loginKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 150),
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
                  height: 45,
                ),
                Consumer(builder: (context, ref, child) {
                  final isLoading = ref.watch(loadingProvider);
                  final authNotifier = ref.read(authNotifierProvider.notifier);
                  return isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                              color: Pallete.primaryColor),
                        )
                      : AuthButton(
                          text: "Email Login",
                          onTap: () {
                            if (loginKey.currentState!.validate()) {
                              authNotifier.signInWEmail(
                                emailTc.text,
                                passwordTc.text,
                                context,
                              );
                            }
                          });
                }),
                const SizedBox(
                  height: 65,
                ),
                InkWell(
                  onTap: () {
                    context.push(RouteConst.forgetPasswordPage);
                  },
                  child: Ink(
                    child: const TitleText(
                      text: "Forget password?",
                      color: Pallete.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 65,
                ),
                const GoogleBtn()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
