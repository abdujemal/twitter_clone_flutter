import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter_clone/app_write_config.dart';

final accountProvider = Provider((ref) => Account(client));
final databaseProvider = Provider((ref) => Databases(client));
final storageProvider = Provider((ref) => Storage(client));



final sharedPrefProvider = Provider((ref) => SharedPreferences.getInstance());
