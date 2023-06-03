import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/core/common/title_text.dart';
import 'package:twitter_clone/core/constants/constants.dart';
import 'package:twitter_clone/core/provider/appwrite_provider.dart';
import 'package:twitter_clone/features/auth/widget/auth_btn.dart';
import 'package:twitter_clone/theme/pallete.dart';
import '../../../core/common/logo.dart';

class WelcomPage extends ConsumerStatefulWidget {
  const WelcomPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WelcomPageState();
}

class _WelcomPageState extends ConsumerState<WelcomPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Logo(),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              const Spacer(),
              const TitleText(
                text: "See what's happening in the world right now.",
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontSize: 26,
              ),
              const SizedBox(
                height: 35,
              ),
              AuthButton(
                text: "Create account",
                p: 0,
                onTap: () {
                  context.push(RouteConst.signupPage);
                },
              ),
              const Spacer(),
              Row(
                children: [
                  const TitleText(
                    text: "Have an account already?",
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                  ),
                  InkWell(
                    onTap: () {
                      context.push(RouteConst.loginPage);
                    },
                    child: Ink(
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TitleText(
                          text: "Log in",
                          color: Pallete.primaryColor,
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class WelcomePage extends StatefulWidget {
//   const WelcomePage({super.key});

//   @override
//   State<WelcomePage> createState() => _WelcomePageState();
// }

// class _WelcomePageState extends State<WelcomePage> {

//   @override
//   void initState() {
    
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }
