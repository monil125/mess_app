import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class PollingScreen extends StatefulWidget {
  @override
  _PollingScreenState createState() => _PollingScreenState();
}

class _PollingScreenState extends State<PollingScreen> {
  DateTime today = DateTime.now();
  int hour = int.parse(DateFormat("HH").format(DateTime.now()));
  int selectRadio =  0;
  String type='';
  @override
  Widget build(BuildContext context) {
    //print(hour);
    if(hour<12&&hour>6){type='Breakfast';}
    else if(hour>12&&hour<20){type='Lunch';}
    else{type='Dinner';}
    return Padding(
      padding: EdgeInsets.only(left:10,right: 10,top: 10,bottom: 10),
      child: Card(
        elevation: 5.0,
        child: Row(children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0,horizontal:8.0),
            child: Column(children: <Widget>[
              Text(
                'PollingScreen',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20.0
                ),
              ),
              SizedBox(height: 10,),
              Center(child: Text(
                'How was the $type \n     on ${DateFormat("dd/MM").format(today)} ?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 20.0,
                ),
              )),
              SizedBox(height: 40,),
              SizedBox(
                width: 140,
                height: 40,
                child: RaisedButton(
                child: Text(
                  'Rate',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ), 
                onPressed: () {},
                ),
              )
            ],),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            Row(
              children: <Widget>[
                Radio(
                  value: 1,
                  groupValue: selectRadio,
                  onChanged: (val){
                    setState(() {
                      selectRadio=val;
                    });
                  },
                ),
                Text('Good',style: TextStyle(fontSize: 20),)
              ],
            ),
            
            Row(
              children: <Widget>[
                Radio(
                  value: 2,
                  groupValue: selectRadio,
                  onChanged: (val){
                    setState(() {
                      selectRadio=val;
                    });
                  },
                ),
                Text('Fine',style: TextStyle(fontSize: 20),)
              ],
            ),
            Row(
              children: <Widget>[
                Radio(
                  value: 3,
                  groupValue: selectRadio,
                  onChanged: (val){
                    setState(() {
                      selectRadio=val;
                    });
                  },
                ),
                Text('Bad',style: TextStyle(fontSize: 20),)
              ],
            )
          ],)
        ],),
      ),
    );
  }
}