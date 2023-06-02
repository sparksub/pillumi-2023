import 'package:flutter/material.dart';
import '../screens/camera_screen_widget.dart';

import 'dart:io';
import 'package:image/image.dart' as img;

import '../screens/pill_list_screen_widget.dart';
import 'dart:convert';


List<String> imgToBase64 (pillImageFront, pillImageBack) {
  File frontImgFile = File(pillImageFront);
  File backImgFile = File(pillImageBack);

  List<int> frontImgBytes = frontImgFile.readAsBytesSync();
  List<int> backImgBytes = backImgFile.readAsBytesSync();

  String base64frontImg = base64Encode(frontImgBytes);
  String base64backImg = base64Encode(backImgBytes);
  return [base64frontImg, base64backImg];
}

void goToCameraPage (context, cameras) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => CameraScreenWidget(cameras, '앞', '0')),
  );
}

void goToPillListPage (context, frontPhoto, backPhoto) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => PillListScreenWidget(frontPhoto, backPhoto)),
  );
}

Future<void> cropImg(String imgPath) async{
  final image = img.decodeJpg(File(imgPath).readAsBytesSync());

  final _width = image?.width;
  final _height = image?.height;
  // Resize the image to a 120x? thumbnail (maintaining the aspect ratio).
  final frontThumbnail = img.copyCrop(image!,
      x:(_width!*0.3).toInt(),
      y:(_height!*0.5).toInt(),
      width:(_width*0.4).toInt(),
      height:(_width*0.4).toInt());
  // Save the thumbnail to a jpeg file.
  await img.encodeJpgFile(imgPath, frontThumbnail);
}