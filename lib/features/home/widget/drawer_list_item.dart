// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:twitter_clone/core/common/title_text.dart';
import 'package:twitter_clone/core/constants/constants.dart';
import 'package:twitter_clone/theme/pallete.dart';

class DrawerListItem extends StatelessWidget {
  final String title;
  final int icon;
  final VoidCallback? onTap;
  const DrawerListItem({
    Key? key,
    required this.title,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  IconData(
                    icon,
                    fontFamily: IconProvider.twitterIcon,
                  ),
                  color: Pallete.textColor,
                ),
                SizedBox(width: 28,),
                Padding(
                  padding: const EdgeInsets.only(top: 7.0),
                  child: TitleText(
                    text: title,
                    color: onTap == null ? Pallete.fadeTextColor : Colors.black,
                    fontSize: 19,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
