import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/core/provider/appwrite_provider.dart';

final homeProvider = Provider<HomeRepo>((ref) {
  return HomeRepo(
    databases: ref.read(databaseProvider),
    account: ref.read(accountProvider),
  );
});

class HomeRepo {
  final Databases databases;
  final Account account;
  HomeRepo({
    required this.databases,
    required this.account,
  });
}
