import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sattvik_mess/screens/meals_cancel_screen.dart';
import './screens/splash_screen.dart';
import './screens/auth_screens.dart';
import './screens/home_screen.dart';

import 'models/auth.dart';
import 'models/meal_cancel.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProvider.value(value: MealCancel())
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _)=>MaterialApp(
          title:'Sattvik Mess',
          //darkTheme: ThemeData.dark(),
          home: auth.isAuth ? HomeScreen(): FutureBuilder(
            future: auth.tryAutoLogin(),
            builder: (context,snapshot)=>
            snapshot.connectionState == ConnectionState.waiting
            ? SplashScreen() : AuthScreen(),
          ),
          routes: {
            MealsCancelScreen.routeName: (c)=>MealsCancelScreen(),
          },
        ),
      ),
    );
  }
}