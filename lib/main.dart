import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/splash_screen.dart';
import './screens/auth_screens.dart';
import './screens/home_screen.dart';

import 'models/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _)=>MaterialApp(
          title:'Sattvik Mess',
          home: auth.isAuth ? HomeScreen(): FutureBuilder(
            future: auth.tryAutoLogin(),
            builder: (context,snapshot)=>
            snapshot.connectionState == ConnectionState.waiting
            ? SplashScreen() : AuthScreen(),
          ),
        ),
      ),
    );
  }
}