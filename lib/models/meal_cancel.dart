import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class MealCancelItem{
  String acceptance,b,d,l,date,diet,email,name,requestDate,id;
  MealCancelItem({
    this.acceptance,
    this.b,
    this.l,
    this.d,
    this.date,
    this.diet,
    this.email,
    this.name,
    this.requestDate,
    this.id
  });
}
class MealCancel with ChangeNotifier{
  List<MealCancelItem> _items=[];

  List<MealCancelItem> get items{
    return [..._items];
  }

  bool checkDate(String date){
    //var fDate = DateFormat("yy/MM/dd").format(date);
    var b = false;
    for(int i=0;i<_items.length;i++){
      if(_items[i].requestDate==date){
        b=true;//print('Check Date working');
        break;
      }
    }
    return b;
  }

  MealCancelItem findById(String id){
    return _items.firstWhere((meal)=>meal.id==id)??null;
  }



  Future<void> cancelMeal(String mess, String email, List<MealCancelItem> mealItems) async {
    int a=0;
    if(mess == 'Mess 1'){a=201;}
    if(mess == 'Mess 2'){a=202;}
    String newEmail='';
    for(int i=0;i<email.length;i++){
      if(email[i]=='@'||email[i]=='.'){
        continue;
      }else{
        newEmail+=email[i];
      }
    }
    final url = 'https://institutemess-a112a.firebaseio.com/Mess/Mess%$a/cancel_sheet/$newEmail.json';
    try{
      for(int i=0;i<mealItems.length;i++){
      final response = await http.post(url,body: json.encode({
        'Acceptance':mealItems[i].acceptance,
        'b':mealItems[i].b,
        'd':mealItems[i].d,
        'l':mealItems[i].l,
        'date':mealItems[i].date,
        'diet':mealItems[i].diet,
        'email':mealItems[i].email,
        'name':mealItems[i].name,
        'request_date':mealItems[i].requestDate
      }));
      //print(json.decode(response.body)['name']);
      final tempItem = MealCancelItem(
        acceptance: mealItems[i].acceptance,
        b: mealItems[i].b,
        l: mealItems[i].l,
        d: mealItems[i].d,
        date: mealItems[i].date,
        diet: mealItems[i].diet,
        email: mealItems[i].email,
        id: json.decode(response.body)['name'],
        name: mealItems[i].name,
        requestDate: mealItems[i].requestDate
      );
      _items.add(tempItem);
      //print(_items.length);
    }
    notifyListeners();
    }catch(error){
      print(error);
      throw(error);
    }
  }

  Future<void> updateCancelMeal(String mess, String email, List<MealCancelItem> mealItems) async {
    int a=0;
    if(mess == 'Mess 1'){a=201;}
    if(mess == 'Mess 2'){a=202;}
    String newEmail='';
    for(int i=0;i<email.length;i++){
      if(email[i]=='@'||email[i]=='.'){
        continue;
      }else{
        newEmail+=email[i];
      }
    }
    try{
      for(int i=0;i<mealItems.length;i++){
        final j = _items.indexWhere((test)=>test.requestDate==mealItems[i].requestDate);
        String id = _items[j].id; 
        _items[j].b=mealItems[i].b;
        _items[j].d=mealItems[i].d;
        _items[j].l=mealItems[i].l;
        _items[j].date=mealItems[i].date;
        _items[j].diet=mealItems[i].diet;
        //print(id);
        var url = 'https://institutemess-a112a.firebaseio.com/Mess/Mess%$a/cancel_sheet/$newEmail/$id.json';
        await http.patch(url,body: json.encode({
        'Acceptance': '0',
        'b':mealItems[i].b,
        'd':mealItems[i].d,
        'l':mealItems[i].l,
        'date':mealItems[i].date,
        'diet':mealItems[i].diet,
        }));
      }
      notifyListeners();
    }catch(error){
      print(error);
      throw(error);
    }
  }

  Future<void> fetchCancelMeal(String mess, String email) async {
    int a=0;
    if(mess == 'Mess 1'){a=201;}
    if(mess == 'Mess 2'){a=202;}
    String newEmail='';
    for(int i=0;i<email.length;i++){
      if(email[i]=='@'||email[i]=='.'){
        continue;
      }else{
        newEmail+=email[i];
      }
    }
    final url = 'https://institutemess-a112a.firebaseio.com/Mess/Mess%$a/cancel_sheet/$newEmail.json';
    try{
      final response = await http.get(url);
      final data = json.decode(response.body) as Map<String,dynamic>;
      if(data==null){return;}
      final List<MealCancelItem> loadedMeal=[];
      data.forEach((id,da){
        //print(id);
        //print(da);
        loadedMeal.add(MealCancelItem(
          id: id,
          acceptance: da['Acceptance'],
          b: da['b'],
          l: da['l'],
          diet: da['diet'],
          d: da['d'],
          date: da['date'],
          email: da['email'],
          name: da['name'],
          requestDate: da['request_date']
        ));
      });
      _items = loadedMeal;
      //print(_items.length);
      notifyListeners();
    }catch(error){
      print(error);
      throw(error);
    }
  }
}