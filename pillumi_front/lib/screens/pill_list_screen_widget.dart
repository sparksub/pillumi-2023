import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pillumi_front/util/Palette.dart';

import '../api/class/pill_list.dart';
import '../api/search_pill.dart';
import '../widgets/dialog/bulid_progress.dart';
import '../widgets/view/build_main_pill.dart';
import '../widgets/view/build_other_pill.dart';

class PillListScreenWidget extends StatefulWidget {
  final frontPhoto;
  final backPhoto;
  const PillListScreenWidget(
      this.frontPhoto,
      this.backPhoto,
      {Key? key}) : super(key: key);

  @override
  State<PillListScreenWidget> createState() => _PillListScreenState();
}

class _PillListScreenState extends State<PillListScreenWidget> {
  var logData;

  @override
  void initState(){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    logData = SearchPill(widget.frontPhoto, widget.backPhoto);
    sleep(const Duration(seconds:1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: FutureBuilder<PillList>(
            future: SearchPill(widget.frontPhoto, widget.backPhoto),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.hasData == false)
              {
                return buildProgress();
              }
              else if (snapshot.hasError)
              {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text('검색결과',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    )),
                    leading:  IconButton(
                        onPressed: () {
                          Navigator.popUntil(context, ModalRoute.withName('/')); // 홈으로 가기
                          //  MaterialPageRoute(builder: (context) => MainScreenWidget()
                        },
                        color: Palette.pointColor,
                        icon: Icon(Icons.home)),
                    backgroundColor: Colors.white,
                  ),
                  body: Center(
                    child: Text(
                      'Error: ${snapshot.error} \n 인터넷 연결을 확인하세요!', // 에러명을 텍스트에 뿌려줌
                      style: const TextStyle(
                          color: Palette.redColor,
                          fontSize: 20
                      ),
                    ),
                  ),
                );
              }
              else
              {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text('검색결과',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        )),
                    leading:  IconButton(
                        onPressed: () {
                          Navigator.popUntil(context, ModalRoute.withName('/')); // 홈으로 가기
                          //  MaterialPageRoute(builder: (context) => MainScreenWidget()
                        },
                        color: Palette.pointColor,
                        icon: Icon(Icons.home)),
                    backgroundColor: Colors.white,
                  ),
                  body: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        child:  BuildOtherPill(snapshot.data!.others, context)
                    ),
                  ),
                );
              }
            }
        ),
      ),
    );
  }

}
