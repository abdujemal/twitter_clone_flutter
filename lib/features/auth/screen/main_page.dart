import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/features/auth/widget/bottom_nav_bar.dart';
import 'package:twitter_clone/features/chat/chat_page.dart';
import 'package:twitter_clone/features/home/home_page.dart';
import 'package:twitter_clone/features/notification/notification_page.dart';
import 'package:twitter_clone/features/search/search_page.dart';
import 'package:twitter_clone/theme/pallete.dart';

import '../../home/widget/main_drawer.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {

  final tabs = [
    const HomePage(),
    const SearchPage(),
    const NotificationPage(),
    const ChatPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final index = ref.watch(navIndexProvider);
    return Scaffold(
      drawer: const MainDrawer(),
      bottomNavigationBar: const BottomNavBar(),
      backgroundColor: Pallete.notificationBgColor,
      body: tabs[index]
    );
  }
}

