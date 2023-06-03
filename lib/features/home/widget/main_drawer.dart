import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/core/common/title_text.dart';
import 'package:twitter_clone/features/auth/auth_controller.dart';
import 'package:twitter_clone/theme/pallete.dart';

import '../../../core/common/follow.dart';
import '../../../core/constants/constants.dart';
import '../../../core/utils.dart';
import '../../../models/user.dart';
import 'drawer_list_item.dart';

class MainDrawer extends ConsumerStatefulWidget {
  const MainDrawer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainDrawerState();
}

class _MainDrawerState extends ConsumerState<MainDrawer> {
  User? currentUser;

  @override
  void initState() {
    super.initState();

    currentUser = ref.read(userProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Pallete.whiteColor,
      height: double.maxFinite,
      padding: const EdgeInsets.only(
        top: 65,
      ),
      width: 300,
      child: Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.grey,
                  width: .3,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: Icon(
                    IconData(
                      AppIcon.bulb,
                      fontFamily: IconProvider.twitterIcon,
                    ),
                    color: Pallete.primaryColor,
                  ),
                ),
                Image.asset(
                  AssetConst.qr,
                  width: 23,
                )
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder(
                  future: getImage(Appwrite.profileImageId,
                      currentUser!.imgUrl!, ref, DirNamse.profile),
                  builder: (context, snapshot) {
                    return CircleAvatar(
                      radius: 30,
                      backgroundImage: snapshot.data != null
                          ? FileImage(snapshot.data!)
                          : null,
                    );
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 2, right: 4),
                              child: Text(
                                currentUser!.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Icon(
                              IconData(
                                AppIcon.blueTick,
                                fontFamily: IconProvider.twitterIcon,
                              ),
                              color: Pallete.primaryColor,
                              size: 17,
                            )
                          ],
                        ),
                        Text(
                          '@${currentUser!.userName}',
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Icon(
                      IconData(
                        AppIcon.arrowDown,
                        fontFamily: IconProvider.twitterIcon,
                      ),
                      color: Pallete.primaryColor,
                      size: 18,
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Follow(
                      title: "Followers",
                      num: currentUser!.followers!.length,
                    ),
                    const SizedBox(
                      width: 13,
                    ),
                    Follow(
                      title: "Followings",
                      num: currentUser!.following!.length,
                    )
                  ],
                ),
                const SizedBox(
                  height: 3,
                ),
                const Divider(),
                DrawerListItem(
                  icon: AppIcon.profile,
                  title: "Profile",
                  onTap: () {
                    context.push(RouteConst.profilePage);
                  },
                ),
                const DrawerListItem(
                  icon: AppIcon.lists,
                  title: "Lists",
                ),
                const DrawerListItem(
                  icon: AppIcon.bookmark,
                  title: "Bookmarks",
                ),
                const DrawerListItem(
                  icon: AppIcon.moments,
                  title: "Moments",
                ),
                const DrawerListItem(
                  icon: AppIcon.twitterAds,
                  title: "Twitter ads",
                ),
                const SizedBox(
                  height: 5,
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                const TitleText(
                  text: "Settings and Privacy",
                  color: Colors.black,
                  fontSize: 19,
                  fontWeight: FontWeight.normal,
                ),
                const SizedBox(
                  height: 30,
                ),
                const TitleText(
                  text: "Help Center",
                  color: Pallete.fadeTextColor,
                  fontSize: 19,
                  fontWeight: FontWeight.normal,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                Consumer(builder: (context, ref, child) {
                  final isLoading = ref.watch(loadingProvider);
                  return isLoading ?
                   const Center(child: CircularProgressIndicator(color: Pallete.primaryColor),):
                   InkWell(
                    onTap: () {
                      ref.read(authNotifierProvider.notifier).signOut(context);
                    },
                    child: Ink(
                      child: const TitleText(
                        text: "Logout",
                        color: Colors.black,
                        fontSize: 19,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
