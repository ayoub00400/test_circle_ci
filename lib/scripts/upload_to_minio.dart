import 'dart:io';
import 'package:minio/minio.dart';

Future<void> main(List<String> args) async {
  /** 
   * https://minio.hader.online/
   * mobile
   * hader
   * Hader@123
   * 
   */

  // if (args.length < 4) {
  //   print('Usage: dart upload_to_minio.dart <endpoint> <bucket> <accessKey> <secretKey> <filePath>');
  //   exit(1);
  // }

  final endpoint = "play.min.io";
  final bucket = "mobile";
  final accessKey = "Q3AM3UQ867SPQQA43P2F";
  final secretKey = "zuf+tfteSlswRu7BJ86wekitnifILbZam1KYY3TG";
  final filePath = "lib/scripts/readme.txt";
  // final filePath =
  //     "build/app/outputs/apk/${appFlavor ?? "development"}/release/app-${appFlavor ?? "development"}-release.apk";

  final file = File(filePath);

  if (!file.existsSync()) {
    print('File does not exist: $filePath');
    exit(1);
  }

  final minio = Minio(
    endPoint: endpoint,
    accessKey: accessKey,
    secretKey: secretKey,
    useSSL: true,
  );

  final objectName = file.uri.pathSegments.last;

  print('Uploading $objectName to $bucket ...');
  if (!await minio.bucketExists(bucket)) minio.makeBucket(bucket);
  await minio.putObject(bucket, objectName, file.readAsBytes().asStream());

  print('Upload successful!');
}
