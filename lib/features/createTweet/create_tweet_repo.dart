// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/core/constants/constants.dart';
import 'package:twitter_clone/core/failure.dart';
import 'package:twitter_clone/core/provider/appwrite_provider.dart';
import 'package:twitter_clone/core/typedef.dart';
import 'package:twitter_clone/models/tweet.dart';

final createTweetProvider = Provider<CreateTweetRepo>((ref) {
  return CreateTweetRepo(
    storage: ref.read(storageProvider),
    databases: ref.read(databaseProvider),
    ref: ref,
  );
});

class CreateTweetRepo {
  final Storage storage;
  final Databases databases;
  final Ref ref;
  CreateTweetRepo({
    required this.storage,
    required this.databases,
    required this.ref,
  });

  FutureEither<bool> createTweet(Tweet tweet, String? filePath) async {
    try {
      String? fileId;
      if (filePath != null) {
        final file = await storage.createFile(
          bucketId: Appwrite.tweetImageId,
          fileId: ID.unique(),
          file: InputFile.fromPath(path: filePath),
        );
        fileId = file.$id;
      }

      final doc = await databases.createDocument(
        databaseId: Appwrite.databaseId,
        collectionId: Appwrite.tweetColId,
        documentId: ID.unique(),
        data: tweet.copyWith(img: fileId,).toMap(),
      );

      return right(true);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
