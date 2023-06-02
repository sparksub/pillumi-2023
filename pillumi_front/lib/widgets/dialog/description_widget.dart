import 'package:flutter/material.dart';
import 'package:pillumi_front/util/Palette.dart';

class DescriptionWidget extends StatelessWidget {
  final Color color;

  const DescriptionWidget({
    super.key,
    required this.color
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 1. 알약이 네모칸 중앙에 오도록
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('1. 알약이',
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: color
                )),
            const Text(' 네모칸 중앙',
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Palette.pointColor
                )),
            Text('에 오도록',
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: color
                )),
          ],
        ),
        // 2. 밝은 조명 아래서
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('2.',
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: color
                )),
            const Text(' 밝은',
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Palette.pointColor
                )),
            Text('조명 아래서',
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: color
                )),
          ],
        ),
        // 3. 대비되는 깔끔한 배경에서
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('3.',
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: color
                )),
            const Text(' 대비되는 깔끔한',
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Palette.pointColor
                )),
            Text(' 배경에서',
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: color
                )),
          ],
        ),
      ],
    );
  }
}