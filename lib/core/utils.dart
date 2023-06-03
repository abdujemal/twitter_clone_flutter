import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:appwrite/models.dart' as am;
import 'package:fpdart/fpdart.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toast/toast.dart';
import 'package:twitter_clone/core/provider/appwrite_provider.dart';
import 'package:twitter_clone/theme/pallete.dart';

void toast(String text, Color color) {
  Fluttertoast.showToast(msg: text, backgroundColor: color);
}

Future<File?> pickImage() async {
  try {
    FilePickerResult? res = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (res != null) {
      return File(res.files.first.path!);
    } else {
      toast("Nothing is picked", Pallete.orangeColor);
      return null;
    }
  } catch (e) {
    toast(e.toString(), Pallete.favColor);
    return null;
  }
}

Future<String> uploadImage(
    File file, Ref ref, String bucketId, String imageName) async {
  am.File res = await ref.read(storageProvider).createFile(
        bucketId: bucketId,
        fileId: ID.unique(),
        file: InputFile.fromPath(
          path: file.path,
          filename: imageName,
        ),
      );
  return res.$id;
}

Future<File> getImage(
    String bucketId, String fileId, WidgetRef ref, String dir) async {
  final directory = await getApplicationDocumentsDirectory();
  String path = "${directory.path}/$dir/$fileId.jpg";
  File file = File(path);
  if (file.existsSync()) {
    return file;
  } else {
    Uint8List data = await ref
        .read(storageProvider)
        .getFileDownload(bucketId: bucketId, fileId: fileId);

    file = await (await file.create(recursive: true)).writeAsBytes(data);

    return file;
  }
}
