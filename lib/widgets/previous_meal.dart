import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sattvik_mess/models/meal_cancel.dart';

class PreviousCancelledMeals extends StatefulWidget {
  @override
  _PreviousCancelledMealsState createState() => _PreviousCancelledMealsState();
}

class _PreviousCancelledMealsState extends State<PreviousCancelledMeals> {
  List<MealCancelItem> meal=[];
  List<MealCancelItem> pmeal = [];
  List<MealCancelItem> cmeal = [];
  @override
  Widget build(BuildContext context) {
    meal = Provider.of<MealCancel>(context).items;
    for(int i=0;i<meal.length;i++){
      if(meal[i].acceptance=='1'){
        cmeal.add(meal[i]);
      }else{
        pmeal.add(meal[i]);
      }
    }
    return Container(
      height: 200,//MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              //IconButton(icon: Icon(Icons.refresh), onPressed: (){}),
              Text('Previoisly Cancelled Meals',style: TextStyle(fontSize: 18),)
            ],
          ),
          SizedBox(height: 20,),
          if(pmeal.isNotEmpty)
          Container(
            height: 30,
            padding: EdgeInsets.only(left: 10,top: 5,bottom: 5),
            margin: EdgeInsets.only(bottom:10),
            color: Colors.grey,
            child: Text('Pending Requests'),
          ),
          if(cmeal.isNotEmpty)
          Expanded(
            child: ListView.builder(
              itemCount: pmeal.length,
              itemBuilder: (context, i)=>Container(
                margin: EdgeInsets.only(bottom: 10,left: 5,right: 5),
                child: ListTile(
                  title: Text(pmeal[i].requestDate),
                  trailing: Column(children: <Widget>[
                    Text('B    ${pmeal[i].b}'),
                    Text('L    ${pmeal[i].l}'),
                    Text('D    ${pmeal[i].d}'),
                  ],),
                ),
              ),
            ),
          ),
          if(cmeal.isNotEmpty)
          SizedBox(height: 20,),
          if(cmeal.isNotEmpty)
          Container(
            height: 30,
            padding: EdgeInsets.only(left: 10,top: 5,bottom: 5),
            margin: EdgeInsets.only(bottom:10),
            color: Colors.grey,
            child: Text('Confirmed Requests'),
          ),
          if(cmeal.isNotEmpty)
          Expanded(
            child: ListView.builder(
              itemCount: cmeal.length,
              itemBuilder: (context, i)=>Container(
                margin: EdgeInsets.only(bottom: 10,left: 5,right: 5),
                child: ListTile(
                  title: Text(cmeal[i].requestDate),
                  trailing: Column(children: <Widget>[
                    Text('B    ${cmeal[i].b}'),
                    Text('L    ${cmeal[i].l}'),
                    Text('D    ${cmeal[i].d}'),
                  ],),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}