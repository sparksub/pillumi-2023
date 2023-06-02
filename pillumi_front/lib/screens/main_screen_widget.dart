import 'package:flutter/material.dart';
import 'package:pillumi_front/util/Palette.dart';

import 'package:pillumi_front/widgets/dialog/description_widget.dart';
import 'package:pillumi_front/util/utils.dart';

class MainScreenWidget extends StatefulWidget{
  final _cameras;
  const MainScreenWidget(this._cameras, {Key? key}) : super(key: key);

  @override
  _MainScreenState createState()=> _MainScreenState();
}

class _MainScreenState extends State<MainScreenWidget> {

  // void _incrementCounter() {
  //   setState(() {
  //   });
  // }

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
                  '알약 촬영 시',
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
                height: 38,
              ),
              // 사진 촬영 예시 그림들
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 잘못 촬영된 알약 사진
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('assets/wrong-example.png'),
                        width: 172,
                        height: 172,
                      ),
                      SizedBox(width: 38),
                      Image(
                        image: AssetImage('assets/x_icon.png'),
                        width: 71,
                        height: 71,
                      )
                    ],
                  ),
                  SizedBox(height: 19),
                  // 잘 촬영된 알약 사진
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('assets/correct-example.png'),
                        width: 172,
                        height: 172,
                      ),
                      SizedBox(width: 38),
                      Image(
                        image: AssetImage('assets/o_icon.png'),
                        width: 71,
                        height: 71,
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 76,
              ),
              // 알약 촬영하러 가기 버튼
              OutlinedButton.icon(
                onPressed: (){
                  goToCameraPage(context, widget._cameras);
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Palette.deepGreenColor,
                  alignment: Alignment.center,
                  fixedSize: const Size(350, 50),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))
                  )
                ),
                icon: const Icon(Icons.camera_alt_outlined,
                  color: Colors.white,
                ),
                label: const Text("알약 촬영하기",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
            )
            ],
          ),
        ),
      ),
    );
  }
}
