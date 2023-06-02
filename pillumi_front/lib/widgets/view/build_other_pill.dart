import 'package:flutter/cupertino.dart';

import '../../api/class/pill.dart';
import '../card/build_another_pill_card.dart';

Column BuildOtherPill(List<Pill> otherPill, BuildContext context) {
  return Column(
      children: otherPill.map<Widget>(
              (data)=>BuildAnotherPillCard(context, data)
      ).toList()
  );
}