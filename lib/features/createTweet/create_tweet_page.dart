import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:twitter_clone/features/auth/auth_controller.dart';
import 'package:twitter_clone/features/auth/widget/auth_btn.dart';
import 'package:twitter_clone/features/createTweet/create_tweet_controller.dart';
import 'package:twitter_clone/features/profile/widget/profile_input.dart';
import 'package:twitter_clone/models/tweet.dart';
import 'package:twitter_clone/theme/pallete.dart';

import '../../core/constants/constants.dart';
import '../../core/utils.dart';
import '../../models/user.dart';

final tweetTextProvider = StateProvider<String>((ref) {
  return "";
});

class CreateTweetPage extends ConsumerStatefulWidget {
  final String tweetType;
  final String? tweetId;
  const CreateTweetPage({super.key, required this.tweetType, this.tweetId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateTweetPageState();
}

class _CreateTweetPageState extends ConsumerState<CreateTweetPage> {
  User? currentUser;

  TextEditingController tweetTc = TextEditingController();

  static const int maxNoOfText = 350;

  File? file;

  @override
  void initState() {
    super.initState();
    currentUser = ref.read(userProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: .5,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(
            Icons.close,
          ),
        ),
        actions: [
          Consumer(builder: (context, ref, child) {
            final createTweetNotifier =
                ref.read(createTweetNotifierProvider.notifier);
            final loading = ref.watch(createTweetLoadingProvider);
            return loading
                ? const SizedBox(
                    width: 40,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                      child: CircularProgressIndicator(
                        color: Pallete.primaryColor,
                      ),
                    ),
                  )
                : AuthButton(
                    text: "Tweet",
                    size: 'sm',
                    onTap: () {
                      if (tweetTc.text.isNotEmpty) {
                        final List<String> tags = tweetTc.text
                            .replaceAll('\n', ' ')
                            .split(" ")
                            .filter((e) => e.startsWith("#"))
                            .toList();

                        if (file != null) {
                          createTweetNotifier.createTweet(
                            Tweet(
                                id: null,
                                userImg: currentUser!.imgUrl!,
                                tweetType: widget.tweetType,
                                tags: tags,
                                dataTime: DateTime.now().toString(),
                                text: tweetTc.text),
                            file!.path,
                            context,
                          );
                        } else {
                          createTweetNotifier.createTweet(
                            Tweet(
                                id: null,
                                userImg: currentUser!.imgUrl!,
                                tweetType: widget.tweetType,
                                tags: tags,
                                dataTime: DateTime.now().toString(),
                                text: tweetTc.text),
                            null,
                            context,
                          );
                        }
                      } else {
                        toast(
                            'Please, write something...', Pallete.orangeColor);
                      }
                    },
                  );
          })
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder(
                        future: getImage(Appwrite.profileImageId,
                            currentUser!.imgUrl!, ref, DirNamse.profile),
                        builder: (context, snapshot) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 26,
                              backgroundImage: snapshot.data != null
                                  ? FileImage(snapshot.data!)
                                  : null,
                            ),
                          );
                        },
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            ProfileInput(
                              controller: tweetTc,
                              hint: null,
                              noOfLine: 10,
                              noOfText: maxNoOfText,
                              onChanged: (s) {
                                ref
                                    .read(tweetTextProvider.notifier)
                                    .update((state) => s);
                              },
                            ),
                            if (file != null)
                              Container(
                                height: 270,
                                width: double.maxFinite,
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: FileImage(file!),
                                    fit: BoxFit.fill,
                                  ),
                                  color: Pallete.greyColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      file = null;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    size: 20,
                                    color: Pallete.whiteColor,
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Pallete.whiteColor,
              border: Border(
                top: BorderSide(
                  width: .7,
                  color: Colors.grey,
                ),
              ),
            ),
            height: 50,
            child: Row(
              children: [
                const SizedBox(
                  width: 5,
                ),
                IconButton(
                  onPressed: () async {
                    final fl = await pickImage();
                    setState(() {
                      file = fl;
                    });
                  },
                  icon: const Icon(
                    IconData(
                      AppIcon.image,
                      fontFamily: IconProvider.twitterIcon,
                    ),
                    size: 19,
                    color: Pallete.primaryColor,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    IconData(
                      AppIcon.camera,
                      fontFamily: IconProvider.twitterIcon,
                    ),
                    size: 19,
                    color: Pallete.primaryColor,
                  ),
                ),
                const Spacer(),
                Consumer(builder: (context, ref, child) {
                  final String text = ref.watch(tweetTextProvider);
                  return SizedBox(
                    height: 60,
                    width: 60,
                    child: PieChart(
                      chartLegendSpacing: 0,
                      centerText: "${maxNoOfText - text.length}",
                      centerTextStyle: const TextStyle(
                          color: Pallete.orangeColor, fontSize: 14),
                      chartValuesOptions: const ChartValuesOptions(
                        showChartValues: false,
                        showChartValueBackground: false,
                      ),
                      chartType: ChartType.ring,
                      ringStrokeWidth: 4,
                      dataMap: {
                        'Text': text.length.toDouble(),
                        "empty": maxNoOfText - text.length.toDouble()
                      },
                      legendOptions: const LegendOptions(showLegends: false),
                      colorList: const [Pallete.orangeColor, Colors.grey],
                    ),
                  );
                })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
