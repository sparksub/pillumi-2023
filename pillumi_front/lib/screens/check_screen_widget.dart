import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../util/Palette.dart';
import '../util/utils.dart';
import '../widgets/dialog/description_widget.dart';

class CheckScreenWidget extends StatefulWidget {
  final _cameras;
  final _frontImage;
  final _backImage;
  const CheckScreenWidget(
      this._cameras,
      this._frontImage,
      this._backImage,
      {Key? key}) : super(key: key);

  @override
  State<CheckScreenWidget> createState() => _CheckScreenState();
}

class _CheckScreenState extends State<CheckScreenWidget> {

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 38,
              ),
              // 민트색 알약 촬영 박스
              Container(
                alignment: Alignment.center,
                width: 192,
                height: 42,
                decoration: BoxDecoration(
                  color: Palette.pointColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '사진 확인',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
              ),
              const SizedBox(
                height: 38,
              ),
              // 사진 촬영 가이드라인
              const DescriptionWidget(color: Colors.black),
              const SizedBox(
                height: 105,
              ),
              // 사진 촬영한 사진
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("알약 촬영이 잘 되었나요?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 11),
                  //촬영한 알약 사진들
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Image(
                            image: AssetImage(widget._frontImage),
                            width: 154,
                            height: 154,
                          ),
                          const SizedBox(height: 11),
                          const Text("앞",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 14),
                      Column(
                        children: [
                          Image(
                            image: AssetImage(widget._backImage),
                            width: 154,
                            height: 154,
                          ),
                          const SizedBox(height: 11),
                          const Text("뒤",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 19),
                  // 잘 촬영된 알약 사진

                ],
              ),
              const SizedBox(
                height: 76,
              ),
              // 버튼 모음
              Column(
                children: [
                  OutlinedButton.icon(
                    onPressed: (){
                      goToCameraPage(context, widget._cameras);
                      },
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Palette.pointColor,
                        alignment: Alignment.center,
                        fixedSize: const Size(350, 50),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12))
                        )
                    ),
                    icon: const Icon(Icons.camera_alt_outlined,
                      color: Colors.white,
                    ),
                    label: const Text("다시 촬영하기",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                  OutlinedButton(
                    // TODO: 검색 페이지 전환
                    onPressed: () {
                      goToPillListPage(context, widget._frontImage, widget._backImage);
                    },
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Palette.deepGreenColor,
                        alignment: Alignment.center,
                        fixedSize: const Size(350, 50),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12))
                        )
                    ),
                    child: const Text("알약 검색하기",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
