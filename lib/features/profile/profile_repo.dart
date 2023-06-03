// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/core/failure.dart';
import 'package:twitter_clone/core/provider/appwrite_provider.dart';
import 'package:twitter_clone/core/utils.dart';

import '../../core/constants/constants.dart';
import '../../core/typedef.dart';
import '../../models/user.dart';

final profileRepoProvider = Provider<ProfileRepo>((ref) {
  return ProfileRepo(
      databases: ref.read(databaseProvider),
      storage: ref.read(storageProvider),
      ref: ref);
});

class ProfileRepo {
  final Databases databases;
  final Storage storage;
  final Ref ref;
  ProfileRepo({
    required this.databases,
    required this.storage,
    required this.ref,
  });

  FutureEither<User> addUser(User user, File profile, File bg) async {
    try {
      final profileId =
          await uploadImage(profile, ref, Appwrite.profileImageId, user.uid);

      final bgId = await uploadImage(bg, ref, Appwrite.bgImageId, user.uid);

      User mainUser = user.copyWith(
        imgUrl: profileId,
        backgroundImgUrl: bgId,
        userName: user.userName.replaceAll(" ", ""),
      );

      final doc = await databases.createDocument(
        databaseId: Appwrite.databaseId,
        collectionId: Appwrite.userColId,
        documentId: user.uid,
        data: mainUser.toMap(),
      );
      return right(User.fromMap(doc.data));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
