import 'package:flutter/material.dart';
import 'package:sattvik_mess/screens/meals_cancel_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello there'),
              automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Sattvik Home'),
            onTap: ()=>Navigator.of(context).pushReplacementNamed('/'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.cancel),
            title: Text('Cancel Meals'),
            onTap: (){
              Navigator.of(context).pushNamed(MealsCancelScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}