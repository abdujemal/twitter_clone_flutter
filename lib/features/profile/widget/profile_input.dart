// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../core/common/title_text.dart';
import '../../../theme/pallete.dart';

class ProfileInput extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final int noOfLine;
  final bool readOnly;
  final int? noOfText;
  final void Function(String)? onChanged;
  const ProfileInput({
    Key? key,
    required this.controller,
    required this.hint,
    required this.noOfLine,
    this.readOnly = false,
    this.noOfText,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hint != null)
            TitleText(
              text: hint!,
              color: Pallete.subtitleColor,
              fontSize: 15,
              fontWeight: FontWeight.normal,
            ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "This Feild is required";
              }
            },
            maxLength: noOfText,
            onChanged: onChanged,
            readOnly: readOnly,
            controller: controller,
            maxLines: noOfLine,
            minLines: 1,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: hint == null
                    ? BorderSide.none
                    : BorderSide(
                        color: Pallete.textColor,
                      ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: hint == null
                    ? BorderSide.none
                    : BorderSide(
                        color: Pallete.textColor,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
