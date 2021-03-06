import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sattvik_mess/models/menu.dart';
import 'package:sattvik_mess/models/notice.dart';
import 'package:sattvik_mess/widgets/app_drawer.dart';
import '../models/auth.dart';
import 'menu_screen.dart';
import 'notice_screen.dart';
import 'polling_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Notice()),
        ChangeNotifierProvider.value(value: Menu()),
      ],
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red,Colors.blue[800]]
              )
            ),
          ),
          title:const Text('Sattvik Mess',style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: 23.0
          ),),
          actions: <Widget>[
            FlatButton(child: const Text('Logout'),onPressed: (){
              Provider.of<Auth>(context,listen: false).logOut();
              Navigator.of(context).pushReplacementNamed('/');
            },)
          ],
        ),
        drawer: AppDrawer(),
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            // Card(
            //   child: Center(
            //     child: Image(
            //       image: AssetImage('assets/img.jpg'),
            //     ),
            //   )
            // ),
            SizedBox(height: 5,),
            PollingScreen(),
            NoticeScreen(),
            MenuScreen(),
          ],  
        ),
      ),
    );
  }
}