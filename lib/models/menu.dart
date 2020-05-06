import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class MenuItem{
  String breakfast;
  String lunch;
  String dinner;
  MenuItem({this.breakfast,this.lunch,this.dinner});
}

class Menu with ChangeNotifier{
  List<MenuItem> menu = List<MenuItem>();

  Future<List<MenuItem>> getMenu(String mess)async{
    int a=0;
    if(mess == 'Mess 1'){a=201;}
    if(mess == 'Mess 2'){a=202;}
    final url = 'https://institutemess-a112a.firebaseio.com/Mess/Mess%$a/board_sheet/menu_board.json';
    final response = await http.get(url);
    final data = json.decode(response.body) as Map<String, dynamic>;
    menu.add(MenuItem(
      breakfast: data['today']['breakfast'],
      lunch: data['today']['lunch'],
      dinner: data['today']['dinner']
    ));
    menu.add(MenuItem(
      breakfast: data['tomorrow']['breakfast'],
      lunch: data['tomorrow']['lunch'],
      dinner: data['tomorrow']['dinner']
    ));
    menu.add(MenuItem(
      breakfast: data['next']['breakfast'],
      lunch: data['next']['lunch'],
      dinner: data['next']['dinner']
    ));
    return menu;
  }
}