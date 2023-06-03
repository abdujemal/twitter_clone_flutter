import 'package:flutter/material.dart';

class TweetDetailPage extends StatefulWidget {
  final String id;
  const TweetDetailPage({super.key, required this.id});

  @override
  State<TweetDetailPage> createState() => _TweetDetailPageState();
}

class _TweetDetailPageState extends State<TweetDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [Text("Tweet Detail page")]),
    );
    ;
  }
}
