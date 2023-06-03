import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/core/constants/constants.dart';
import 'package:twitter_clone/core/utils.dart';
import 'package:twitter_clone/features/auth/auth_controller.dart';
import 'package:twitter_clone/features/profile/profile_controller.dart';
import 'package:twitter_clone/features/profile/widget/profile_input.dart';
import 'package:twitter_clone/models/user.dart';

import '../../../core/common/title_text.dart';
import '../../../core/provider/appwrite_provider.dart';
import '../../../theme/pallete.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  final String? country;
  const EditProfilePage({super.key, this.country});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  TextEditingController nameTc = TextEditingController();
  TextEditingController userNameTc = TextEditingController();
  TextEditingController emailTc = TextEditingController();
  TextEditingController bioTc = TextEditingController();

  String? uid;

  File? profileImage;
  File? bgImage;

  GlobalKey<FormState> profileKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    ref.read(accountProvider).get().then((acc) {
      setState(() {
        emailTc.text = acc.email;
        nameTc.text = acc.name;
        uid = acc.$id;
      });
    });
  }

  @override
  void dispose() {
    nameTc.dispose();
    userNameTc.dispose();
    emailTc.dispose();
    bioTc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool loading = ref.watch(loadingProvider);
    final profileNotifier = ref.read(profileNotifierProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const TitleText(
          text: "Profile Edit",
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(19),
            child: loading
                ? const SizedBox(
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Pallete.primaryColor,
                    ),
                  )
                : InkWell(
                    onTap: () {
                      if (profileKey.currentState!.validate()) {
                        if (profileImage != null && bgImage != null) {
                          profileNotifier.addUser(
                            User(
                              uid: uid!,
                              email: emailTc.text,
                              name: nameTc.text,
                              userName: userNameTc.text,
                              bio: bioTc.text,
                              address: widget.country!,
                              joinedIn: DateTime.now().toString(),
                              imgUrl: null,
                              isVerified: false,
                              backgroundImgUrl: null,
                              following: [],
                              followers: [],
                            ),
                            profileImage!,
                            bgImage!,
                            context,
                          );
                        } else {
                          toast("Please select the images.", Pallete.favColor);
                        }
                      }
                    },
                    child: Ink(
                      child: const Text(
                        "Save",
                        style: TextStyle(
                          color: Pallete.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: profileKey,
          child: Column(
            children: [
              Stack(
                children: [
                  InkWell(
                    onTap: () async {
                      final file = await pickImage();
                      if (file != null) {
                        setState(() {
                          bgImage = file;
                        });
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Pallete.settingTitle,
                          image: bgImage != null
                              ? DecorationImage(
                                  image: FileImage(
                                    bgImage!,
                                  ),
                                  fit: BoxFit.cover,
                                  alignment: Alignment.topCenter,
                                )
                              : null),
                      margin: const EdgeInsets.only(bottom: 44),
                      height: 120,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              IconData(
                                AppIcon.camera,
                                fontFamily: 'TwitterIcon',
                              ),
                              color: Pallete.whiteColor,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Add Image",
                              style: TextStyle(color: Pallete.whiteColor),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      width: 83,
                      height: 83,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Pallete.whiteColor, width: 4),
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(100),
                          image: profileImage != null
                              ? DecorationImage(
                                  image: FileImage(
                                    profileImage!,
                                  ),
                                  fit: BoxFit.cover,
                                  alignment: Alignment.topCenter,
                                )
                              : null),
                      child: Center(
                        child: IconButton(
                          onPressed: () async {
                            final file = await pickImage();
                            if (file != null) {
                              setState(() {
                                profileImage = file;
                              });
                            }
                          },
                          icon: const Icon(
                            Icons.camera_alt,
                            size: 23,
                            color: Pallete.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ProfileInput(
                controller: nameTc,
                hint: "Name",
                noOfLine: 1,
              ),
              const SizedBox(
                height: 20,
              ),
              ProfileInput(
                controller: userNameTc,
                hint: "User Name",
                noOfLine: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              ProfileInput(
                controller: emailTc,
                hint: "Email",
                noOfLine: 1,
                readOnly: true,
              ),
              const SizedBox(
                height: 10,
              ),
              ProfileInput(controller: bioTc, hint: "Bio", noOfLine: 5),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
