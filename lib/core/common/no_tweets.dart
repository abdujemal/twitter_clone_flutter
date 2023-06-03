import 'package:flutter/material.dart';
import 'package:twitter_clone/core/common/title_text.dart';
import 'package:twitter_clone/theme/pallete.dart';

class NoTweet extends StatelessWidget {
  const NoTweet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          TitleText(
            text: "No Tweet added yet",
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
          SizedBox(height: 20,),
          TitleText(
            text: "When new Tweet added, they'll show up here Tap tweet button to add new",
            color: Pallete.textColor,
            fontWeight: FontWeight.normal,
            fontSize: 15,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
