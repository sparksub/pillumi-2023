import 'pill.dart';

class PillList{
  final Pill main;
  final List<Pill> others;

  PillList({required this.main, required this.others});

  factory PillList.fromJson(Map<String, dynamic> pillMap){
    var list = pillMap['ResultsPill'] as List;
    List<Pill> othersPill = list.map((i)=> Pill.fromJson(i)).toList();

    return PillList(
      main: othersPill[0],
      others: othersPill,
    );
  }
}