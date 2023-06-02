import 'package:flutter/material.dart';
import 'package:pillumi_front/util/Palette.dart';

Scaffold buildProgress() {
  return Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('검색 중입니다.',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 20.0),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Palette.pointColor),
          ),
        ],
      ),
    ),
  );
}