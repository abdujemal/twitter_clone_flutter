// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:ffi';
import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as mw;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter_clone/core/constants/constants.dart';
import 'package:twitter_clone/core/failure.dart';
import 'package:twitter_clone/core/provider/appwrite_provider.dart';
import 'package:twitter_clone/core/typedef.dart';

import '../../models/user.dart';

final authRepoProvider = Provider(
  (ref) => AuthRepo(
    databases: ref.read(databaseProvider),
    account: ref.read(accountProvider),
    sharedPreferences: ref.read(sharedPrefProvider),
  ),
);

class AuthRepo {
  final Databases databases;
  final Account account;
  final Future<SharedPreferences> sharedPreferences;
  AuthRepo({
    required this.databases,
    required this.account,
    required this.sharedPreferences,
  });

  FutureEither<User> getCurrentUser(String id) async {
    try {
      final doc = await databases.getDocument(
        databaseId: Appwrite.databaseId,
        collectionId: Appwrite.userColId,
        documentId: id,
      );

      return right(User.fromMap(doc.data));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureEither<Account> signUpWEmail(
      String email, String password, String name) async {
    try {
      final user = await account.create(
          userId: ID.unique(), email: email, password: password, name: name);

      return right(user as Account);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureEither<mw.Session> signInWEmail(String email, String password) async {
    try {
      final session =
          await account.createEmailSession(email: email, password: password);

      final pref = await sharedPreferences;
      pref.setBool("isLoggedIn", true);
      pref.setString('uid', session.userId);

      return right(session);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureEither<dynamic> googleSignIn() async {
    try {
      final session = await account.createOAuth2Session(provider: 'google');

      return right(session);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureEither<bool> signOut() async {
    try {
      await account.deleteSessions();
      final pref = await sharedPreferences;

      pref.clear();

      return right(true);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureEither<User> updateUser(User user) async {
    try {
      final doc = await databases.createDocument(
        databaseId: Appwrite.databaseId,
        collectionId: Appwrite.userColId,
        documentId: user.uid,
        data: user.toMap(),
      );
      return right(User.fromMap(doc.data));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
