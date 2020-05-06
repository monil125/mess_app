import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sattvik_mess/models/auth.dart';
import 'package:sattvik_mess/models/menu.dart';

class MenuScreen extends StatelessWidget {
  List<MenuItem> _menu;
  @override
  Widget build(BuildContext context) {
    final mess = Provider.of<Auth>(context, listen: false).mess;
    return Padding(
      padding: const EdgeInsets.only(left:10,right: 10,bottom: 10),
      child: Card(
        elevation: 5,
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.grey[200],
              padding: EdgeInsets.only(top:5,left:25,bottom: 5),
              child: Row(
                children: <Widget>[                   
                  Text(
                    'Menu',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      letterSpacing: 4.0,
                      fontFamily: 'Courgette',
                      color: Colors.grey[700],
                    ),
                  ),
                  // SizedBox(width: 200),
                  // CircleAvatar(
                  //   backgroundImage: AssetImage('assets/notice.png'),
                  //   ),               
                ]
              )
            ),
            Container(
              margin: EdgeInsets.only(left:10,right:10),
              child: FutureBuilder(
                future: Provider.of<Menu>(context,listen: false).getMenu(mess),
                builder: (context, snapshot){
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return Container(
                      height: 100,
                      child: Center(child: Text('Loading...',style: TextStyle(fontSize: 20),),));
                  }else{
                    _menu = snapshot.data;
                    return Container(
                      height: 300,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(bottom: 50),
                            width: 300,
                            child: Card(
                              //elevation: 5.0,
                              margin: EdgeInsets.only(left:30,top:20),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: 10,),
                                  Center(child: Text('TODAY'),),
                                  SizedBox(height: 20,),
                                  Text('Breakfast: ${_menu[0].breakfast}'),
                                  SizedBox(height: 5,),
                                  Text('Lunch: ${_menu[0].lunch}'),
                                  SizedBox(height: 5,),
                                  Text('Dinner: ${_menu[0].dinner}'),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 50),
                            width: 300,
                            child: Card(
                              //elevation: 5.0,
                              margin: EdgeInsets.only(left:30,top:20),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: 10,),
                                  Center(child: Text('TOMMOROW'),),
                                  SizedBox(height: 20,),
                                  Text('Breakfast: ${_menu[1].breakfast}'),
                                  SizedBox(height: 5,),
                                  Text('Lunch: ${_menu[1].lunch}'),
                                  SizedBox(height: 5,),
                                  Text('Dinner: ${_menu[1].dinner}'),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 50),
                            width: 300,
                            child: Card(
                              //elevation: 5.0,
                              margin: EdgeInsets.only(left:30,top:20),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: 10,),
                                  Center(child: Text('NEXT'),),
                                  SizedBox(height: 20,),
                                  Text('Breakfast: ${_menu[2].breakfast}'),
                                  SizedBox(height: 5,),
                                  Text('Lunch: ${_menu[2].lunch}'),
                                  SizedBox(height: 5,),
                                  Text('Dinner: ${_menu[2].dinner}'),
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                  );
                }
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}