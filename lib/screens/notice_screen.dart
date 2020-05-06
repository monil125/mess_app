import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sattvik_mess/models/auth.dart';
import 'package:sattvik_mess/models/notice.dart';

class NoticeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mess = Provider.of<Auth>(context, listen: false).mess;
    return Padding(
      padding: EdgeInsets.only(left:10,right: 10,bottom: 10),
      child: Card(
        elevation: 5.0,
        child: Column(
          children: <Widget>[
            Container(
            color: Colors.grey[200],
            padding: EdgeInsets.only(top:5,left:25,bottom: 5),
            child: Row(
              children: <Widget>[                   
                Text(
                  'Notice',
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
          Padding(padding: EdgeInsets.only(top: 10)),
            Container(
              margin: EdgeInsets.only(left:10,right:10),
              // decoration: BoxDecoration(
              //   border: Border.all(
              //     color: Colors.lightGreen[500],
              //     width: 2,
              //   ),
              //   borderRadius: BorderRadius.circular(10.0),
              // ),
              child: FutureBuilder(
                future: Provider.of<Notice>(context).getNotice(mess),
                builder: (context, snapshot)=>snapshot.connectionState == ConnectionState.waiting ? 
                Container(
                  height: 100,
                  child: Center(child: Text('Loading...',style: TextStyle(fontSize: 20),),)) :
                 Padding(
                   padding: const EdgeInsets.only(right: 5,left: 5,top: 10,bottom: 10),
                   child: Center(
                    child:Text(snapshot.data,style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20)
                    ,)),
                 ),
              )
            ),
          Padding(padding: EdgeInsets.only(top: 10)),
          ],
        ),
      ),
    );
  }
}