import 'package:flutter/material.dart';
import 'package:twitter_clone/core/common/title_text.dart';
import 'package:twitter_clone/features/auth/widget/auth_btn.dart';
import 'package:twitter_clone/features/auth/widget/auth_input.dart';
import 'package:twitter_clone/theme/pallete.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  TextEditingController emailTc = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey();

  @override
  void dispose() {
    emailTc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Forget Password",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Form(
        key: formState,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TitleText(
                text: "Forget Password",
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 23,
              ),
              const SizedBox(
                height: 16,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: TitleText(
                  text:
                      "Enter your email address below to receive password reset instruction",
                  color: Pallete.textColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              AuthInput(
                controller: emailTc,
                isObscure: false,
                keyboardType: TextInputType.emailAddress,
                hint: "Enter email",
              ),
              const SizedBox(
                height: 30,
              ),
              AuthButton(text: "Submit", onTap: () {
                if(formState.currentState!.validate()){
                  
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
