import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/app_write_config.dart';
import 'package:twitter_clone/core/common/no_tweets.dart';
import 'package:twitter_clone/core/constants/constants.dart';
import 'package:twitter_clone/core/provider/appwrite_provider.dart';
import 'package:twitter_clone/core/utils.dart';
import 'package:twitter_clone/features/auth/auth_controller.dart';
import 'package:twitter_clone/features/home/home_controller.dart';
import 'package:twitter_clone/models/tweet.dart';
import 'package:twitter_clone/models/user.dart';
import 'package:twitter_clone/theme/pallete.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  User? currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = ref.read(userProvider);

    final realtime = Realtime(client);

    final subscription = realtime.subscribe([
      'databases.${Appwrite.databaseId}.collections.${Appwrite.tweetColId}.documents'
      // 'databases.${Appwrite.databaseId}.collections.${Appwrite.tweetColId}'
    ]);

    subscription.stream.listen((data) {
      // Callback will be executed on changes for documents A and all files.

      if (data.payload.isNotEmpty) {
        data.events.map((e) {
          switch (e) {
            case "database.documents.create":
              var item = data.payload;
              ref.read(tweetsProvider.notifier).update(
                  (state) => [...state, Tweet.fromMap(item, item["\$id"])]);
              setState(() {});
              break;
            case "database.documents.update":
              var item = data.payload;
              ref.read(tweetsProvider.notifier).update((state) => state
                  .map((e) => e.id == item['\$id']
                      ? Tweet.fromMap(item, item['\$id'])
                      : e)
                  .toList());
              setState(() {});
              break;
            default:
              break;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.notificationBgColor,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
              future: getImage(Appwrite.profileImageId, currentUser!.imgUrl!,
                  ref, DirNamse.profile),
              builder: (context, snapshot) {
                return CircleAvatar(
                  radius: 10,
                  backgroundImage:
                      snapshot.data != null ? FileImage(snapshot.data!) : null,
                );
              }),
        ),
        centerTitle: false,
        title: const Text(
          "Home",
          style: TextStyle(color: Colors.black),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          IconData(AppIcon.fabTweet, fontFamily: 'TwitterIcon'),
          color: Pallete.whiteColor,
        ),
        onPressed: () {
          context.push(
            Uri(
              path: RouteConst.createTweetPage,
              queryParameters: {'tweetType': TweetType.normal},
            ).toString(),
          );
        },
      ),
      body: Center(child: NoTweet()),
    );
  }
}
