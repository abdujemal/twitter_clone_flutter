import 'package:flutter/material.dart';
import 'package:twitter_clone/theme/pallete.dart';

import 'title_text.dart';

class Follow extends StatelessWidget {
  final int num;
  final String title;
  const Follow({
    Key? key,
    required this.num,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TitleText(
          text: "$num",
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
        const SizedBox(
          width: 8,
        ),
        TitleText(
          text: title,
          color: Pallete.textColor,
          fontWeight: FontWeight.normal,
          fontSize: 17,
        )
      ],
    );
  }
}
