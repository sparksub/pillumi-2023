import 'package:flutter/material.dart';
import 'dart:async';

import 'package:camera/camera.dart';

import 'package:pillumi_front/screens/check_screen_widget.dart';
import 'package:pillumi_front/util/Palette.dart';

import '../util/utils.dart';
import '../widgets/dialog/description_widget.dart';


class CameraScreenWidget extends StatefulWidget {
  final _cameras;
  final _page;
  final _frontImage;
  const CameraScreenWidget(
      this._cameras,
      this._page,
      this._frontImage,
      {Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreenWidget> {
  late CameraController controller;
  late String imagePath;


  @override
  void initState() {
    super.initState();
    controller = CameraController(widget._cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
          // Handle access errors here.
            break;
          default:
          // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (!controller.value.isInitialized) {
      return Container();
    }
    return Stack(
        children: <Widget>[
          Column(
            children: [
              // SizedBox(height: size.height*0.4),
              Center(child: ClipRRect(
                child: SizedOverflowBox(
                  size: Size(size.width, size.height), // aspect is 1:1
                  alignment: Alignment.center,
                  child:
                  CameraPreview(controller),
                ),
              )),
            ],
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  Stack(
                    children: <Widget>[
                      Container(
                        height: size.height*0.5,
                        width: size.width,
                        color: Palette.transparentGrayColor,
                      ),
                      SizedBox(
                        height: size.height*0.5,
                        width: size.width,
                        child: Material(
                          type: MaterialType.transparency,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // 알약 #면을 촬영해주세요!
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('알약',
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white
                                      )),
                                  Text(' ${widget._page}면',
                                      style: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: Palette.redColor
                                      )),
                                  const Text('을 촬영해주세요!',
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: size.height*0.05,
                              ),
                              const DescriptionWidget(color: Colors.white),
                              SizedBox(
                                height: size.height*0.05,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  // 알약이 들어와야 하는 부분
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 투명한 부분의 너비 높이 길이가 같도록 세팅
                      Container(
                        height: size.width*0.4,
                        width: size.width*0.3,
                        color: Palette.transparentGrayColor,
                      ),
                      Stack(
                          children: <Widget> [
                            Container(
                              height: size.width*0.4,
                              width: size.width*0.4,
                              decoration: BoxDecoration(
                                  border: Border.all(color:Palette.transparentGrayColor, width: 5)),
                            ),
                            Container(
                              height: size.width*0.4,
                              width: size.width*0.4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12), //모서리를 둥글게
                                  border: Border.all(color: Palette.pointColor, width: 5)),
                            ),
                            Container(
                              height: size.width*0.4,
                              width: size.width*0.4,
                              child: const Icon(
                                Icons.add,
                                color: Palette.pointColor,
                                size: 62
                              ),
                            )
                          ]
                        ),
                        Container(
                          height: size.width*0.4,
                          width: size.width*0.3,
                          color: Palette.transparentGrayColor,
                        ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: (size.height - size.height*0.5 - size.width*0.4),
                        width: size.width*0.3,
                        color: Palette.transparentGrayColor,
                      ),
                      Container(
                        height: (size.height - size.height*0.5 - size.width*0.4),
                        width: size.width*0.4,
                        padding: EdgeInsets.all(20.0),
                        color: Palette.transparentGrayColor,
                        child: Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.center,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                                    onTap: () async {
                                      imagePath = (await _captureImage())!;
                                      setCameraResult(size);
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Palette.deepGreenColor,
                                            borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                            border: Border.all(
                                                width: 7,
                                                color: Palette.pointColor
                                            )
                                        ),
                                        padding: const EdgeInsets.all(10.0),
                                        child: const Icon(
                                            Icons.camera_alt,
                                            color: Colors.white,
                                            size: 72.0
                                        )
                                    ),
                                  ),
                                ),
                              ),
                            ]
                        ),
                      ),
                      Container(
                        height: (size.height - size.height*0.5 - size.width*0.4),
                        width: size.width*0.3,
                        color: Palette.transparentGrayColor,
                      ),
                    ],
                  ),
                ],
              )
          )
        ]
    );
  }

  void onCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) await controller.dispose();
    controller = CameraController(
        cameraDescription,
        ResolutionPreset.medium,
        imageFormatGroup: ImageFormatGroup.yuv420);

    controller.addListener(() {
      if (mounted) setState(() {});
      if (controller.value.hasError) {
        showMessage('Camera Error: ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      showException(e);
    }

    if (mounted) setState(() {});
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  Future<String?> _captureImage() async {
    final XFile image;
    if (!controller.value.isInitialized) {
      showMessage('Error: select a camera first.');
      return null;
    }
    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      image = await controller.takePicture();
        if (!mounted) {
          return null;
        }
        return image.path;
    } on CameraException catch (e) {
      showException(e);
      return null;
    }
  }

  void setCameraResult(size) {
    if(widget._page == '앞'){
      Future.delayed(Duration(milliseconds: 300)).then((onValue) => {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>
          CameraScreenWidget(widget._cameras, '뒷', imagePath)),
        )
      });

    }
    if(widget._page == '뒷'){
      // print(widget._frontImage);
      // print(imagePath);
      cropImg(imagePath);
      cropImg(widget._frontImage);

      Future.delayed(Duration(milliseconds: 300)).then((onValue) => {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CheckScreenWidget(
                  widget._cameras, widget._frontImage, imagePath)),
        )
      });
    }

  }

  void showException(CameraException e) {
    logError(e.code, e.description.toString());
    showMessage('Error: ${e.code}\n${e.description}');
  }

  void showMessage(String message) {
    print(message);
  }

  void logError(String code, String message) =>
    print('Error: $code\nMessage: $message');
}


