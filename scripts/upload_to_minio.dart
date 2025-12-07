import 'dart:io';

import 'package:flutter/services.dart';
import 'package:minio/minio.dart';

Future<void> main(List<String> args) async {
  /** 
   * https://minio.hader.online/
   * mobile
   * hader
   * Hader@123
   * 
   */

  if (args.length < 4) {
    print('Usage: dart upload_to_minio.dart <endpoint> <bucket> <accessKey> <secretKey> <filePath>');
    exit(1);
  }

  final endpoint = "https://minio.hader.online/";
  final bucket = "mobile";
  final accessKey = "hader";
  final secretKey = "Hader@123";
  final filePath =
      "build/app/outputs/apk/${appFlavor ?? "development"}/release/app-${appFlavor ?? "development"}-release.apk";

  final file = File(filePath);

  if (!file.existsSync()) {
    print('File does not exist: $filePath');
    exit(1);
  }

  final minio = Minio(
    endPoint: endpoint,
    accessKey: accessKey,
    secretKey: secretKey,
    useSSL: endpoint.startsWith('https'),
  );

  final objectName = file.uri.pathSegments.last;

  print('Uploading $objectName to $bucket ...');

  await minio.putObject(bucket, objectName, file.openRead().cast<Uint8List>());

  print('Upload successful!');
}
