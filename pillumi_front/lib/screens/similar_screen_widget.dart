import 'package:flutter/material.dart';
import 'package:pillumi_front/widgets/view/build_main_pill.dart';

import '../util/Palette.dart';

class SimilarScreenWidget extends StatefulWidget {
  final pill;
  const SimilarScreenWidget(this.pill, {Key? key}) : super(key: key);

  @override
  State<SimilarScreenWidget> createState() => SimilarScreen();
}

class SimilarScreen extends State<SimilarScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pill.className.toString(),
            style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold
            )),
        leading:  IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: Palette.pointColor,
            icon: const Icon(Icons.arrow_back_ios_new)),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
              padding: const EdgeInsets.all(10),
              child: BuildMainPill(widget.pill)
          ),
        ),
      ),
    );
  }
}
