import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../util/utils.dart';
import 'class/pill_list.dart';

String base_url = 'http://172.20.10.5:5001';

Future<PillList> SearchPill(base64frontImg, base64backImg) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  var img = imgToBase64(base64frontImg, base64backImg);

  Uri uri = Uri.parse('$base_url/pillsearch/');
  print(uri);
  http.Response response = await http.post(
    uri,
    headers: headers,
    body: jsonEncode(
        {
          "image_front": img[0],
          "image_back": img[1]
        }
      )
  );

  if(response.statusCode == 200){
    final pillMap = await json.decode(response.body);
    return PillList.fromJson(pillMap);
  }

  throw Exception('검색 실패');
}