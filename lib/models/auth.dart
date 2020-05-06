import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'http_exception.dart';

class Auth with ChangeNotifier{
  String _token,_userId,_email;
  DateTime _expiryDate;
  Timer _authTimer;
  String _mess;

  bool get isAuth{
    return token!=null;
  }

  String get token{
    if(_expiryDate!=null&&
      _expiryDate.isAfter(DateTime.now())&&
      _token!=null){
        return _token;
      }
      return null;
  }

  String get userId{
    return _userId;
  }

  String get mess{
    return _mess;
  }

  String get email{
    return _email;
  }

  Future<void> signUp(String email, String password, String mess)async{
    const url = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key= AIzaSyBQQU_3TSuSxjczM-BXA92JkoXfUWJ_xdM';
    try{
      bool b = await checkUser(email, mess);
      print(b);
      if(b){
      _mess=mess;  
      final response = await http.post(url,body: json.encode({
      'email':email,
      'password':password,
      'returnSecureToken':true
    }));
    final responseData = json.decode(response.body);
    if(responseData['error']!=null){
      throw HttpException(responseData['error']['message']);
    }
    _token = responseData['idToken'];
    _email = responseData['email'];
    _userId = responseData['localId'];
    _expiryDate = DateTime.now().add(Duration(
      seconds: int.parse(responseData['expiresIn'])
    ));
    autoLogout();
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode({
      'email': _email,
      'token': _token,
      'userId': _userId,
      'expiryDate': _expiryDate.toIso8601String(),
      'mess': _mess
    });
    prefs.setString('userData', userData);
    }else{
      throw HttpException('Register First');
    }
    }catch(error){
      throw error;
    }
    //print(json.decode(response.body));
  }

  Future<void> login(String email, String password, String mess)async{
    
    const url = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key= AIzaSyBQQU_3TSuSxjczM-BXA92JkoXfUWJ_xdM';
    try{
      final response = await http.post(url,body: json.encode({
      'email':email,
      'password':password,
      'returnSecureToken':true
    }));
    final responseData = json.decode(response.body);
    if(responseData['error']!=null){
      throw HttpException(responseData['error']['message']);
    }
    _token = responseData['idToken'];
    _email = responseData['email'];
    _userId = responseData['localId'];
    _expiryDate = DateTime.now().add(Duration(
      seconds: int.parse(responseData['expiresIn'])
    ));
    bool b = await checkUser(email, mess);
    print(b);
    if(b){
    _mess=mess;
    autoLogout();
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode({
      'email': _email,
      'token': _token,
      'userId': _userId,
      'expiryDate': _expiryDate.toIso8601String(),
      'mess': _mess
    });
    prefs.setString('userData', userData);
    }else{
      logOut();
      notifyListeners();
      throw HttpException('Register First');
    }
    }catch(error){
      throw error;
    }
    //print(json.decode(response.body));

  }

  Future<bool> tryAutoLogin()async{
    final prefs = await SharedPreferences.getInstance();
    if(!prefs.containsKey('userData')){return false;}
    final data = json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(data['expiryDate']);
    if(expiryDate.isBefore(DateTime.now())){return false;}
    _token = data['token'];
    _userId = data['userId'];
    _mess = data['mess'];
    _email = data['email'];
    _expiryDate = expiryDate;
    notifyListeners();
    autoLogout();
    return true;
  }

  Future<void> logOut()async{
    _token = null;
    _userId = null;
    _expiryDate = null;
    if(_authTimer!=null){
      _authTimer.cancel();
      _authTimer=null;
    }
    _mess=null;
    _email = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
  }

  void autoLogout(){
    if(_authTimer!=null){
      _authTimer.cancel();
    }
    var timeToExpire = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpire), logOut);
  }

  Future<bool> checkUser(String email, String mess) async {
    _mess=mess;
    String newEmail='';
    for(int i=0;i<email.length;i++){
      if(email[i]=='@'||email[i]=='.'){
        continue;
      }else{
        newEmail+=email[i];
      }
    }
    int a=0;
    if(mess == 'Mess 1'){a=201;}
    if(mess == 'Mess 2'){a=202;}
    final url = 'https://institutemess-a112a.firebaseio.com/Mess/Mess%$a/students/$newEmail.json';
    try{
      String isActive;
      final response = await http.get(url);
      final data = json.decode(response.body);
      if(data==null){return false;}
      print(data);
      isActive = data['isactive'];
      if(isActive == '0'){return false;}
      return true;
    }catch(error){
      return false;
    }
  }
} 