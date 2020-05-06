import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Notice with ChangeNotifier{

  Future<String> getNotice(String mess)async{
    int a=0;
    if(mess == 'Mess 1'){a=201;}
    if(mess == 'Mess 2'){a=202;}
    final url = 'https://institutemess-a112a.firebaseio.com/Mess/Mess%$a/board_sheet/notice_board.json';
    final response = await http.get(url);
    final data = json.decode(response.body);
    return data['message'];
  } 
}