import 'package:flutter/material.dart';
import 'package:sattvik_mess/widgets/app_drawer.dart';
import 'package:sattvik_mess/widgets/calender.dart';
import 'package:sattvik_mess/widgets/previous_meal.dart';

class MealsCancelScreen extends StatelessWidget {
  static const routeName='/meals_cancel';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cancel Meals'),
      ),
      drawer: AppDrawer(),
      body: ListView(
        children: <Widget>[
          Calender(),
          PreviousCancelledMeals()
        ],
      ),
    );
  }
}