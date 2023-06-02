import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'package:pillumi_front/screens/main_screen_widget.dart';
import 'package:pillumi_front/util/Palette.dart';

late List<CameraDescription> _cameras;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  _cameras = await availableCameras();
  runApp(const PillumiApp());
}

class PillumiApp extends StatelessWidget {
  const PillumiApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pillumi App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: MainScreenWidget(_cameras),
    );
  }
}