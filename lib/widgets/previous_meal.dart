import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sattvik_mess/models/auth.dart';
import 'package:sattvik_mess/models/meal_cancel.dart';

class PreviousCancelledMeals extends StatefulWidget {
  @override
  _PreviousCancelledMealsState createState() => _PreviousCancelledMealsState();
}

class _PreviousCancelledMealsState extends State<PreviousCancelledMeals> {
  List<MealCancelItem> meal=[];
  List<MealCancelItem> pmeal = [];
  List<MealCancelItem> cmeal = [];
  bool _isLoading = false;
  bool _isInit = true;
  void didChangeDependencies() {
    if(_isInit){
      setState(() {
        _isLoading=true;

      });
      final _user = Provider.of<Auth>(context,listen: false);
      Provider.of<MealCancel>(context,listen: false).fetchCancelMeal(_user.mess, _user.email).then((_){
        print('Meal fetched'); 
        meal = Provider.of<MealCancel>(context,listen: false).items;
        // for(int i=meal.length-1;i>=0;i--){
        //   if(meal[i].acceptance=='1'){
        //     cmeal.add(meal[i]);
        //   }else{
        //     pmeal.add(meal[i]);
        //   }
        // }
        print(meal.length);
        setState(() {
          _isLoading=false;
        });
      });
    }
    _isInit=false;
    super.didChangeDependencies();
  }
  Future<void> refreshMeal()async{
    setState(() {
      _isLoading=true;
      meal.clear();
      pmeal.clear();
      cmeal.clear();
    });
    final _user = Provider.of<Auth>(context,listen: false);
    await Provider.of<MealCancel>(context,listen: false).fetchCancelMeal(_user.mess, _user.email);
    print('Meal fetched on refresh');        
    meal = Provider.of<MealCancel>(context,listen: false).items;
    // for(int i=meal.length-1;i>=0;i--){
    //   if(meal[i].acceptance=='1'){
    //     cmeal.add(meal[i]);
    //   }else{
    //     pmeal.add(meal[i]);
    //   }
    // }
    print(meal.length);
    setState(() {
      _isLoading=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    Provider.of<MealCancel>(context);
    double ml = (133+meal.length*72).toDouble();
    return _isLoading?Padding(
      padding: const EdgeInsets.all(30.0),
      child: Center(child: Column(
        children: <Widget>[
          Text('Loding Previous Cancelled Meals'),
          SizedBox(height: 5,),
          CircularProgressIndicator(),
        ],
      )),
    ):Container(
      height: ml,//MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          Divider(),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(icon: Icon(Icons.refresh), onPressed: ()=>refreshMeal()),
              Text('Previoisly Cancelled Meals',style: TextStyle(fontSize: 18),)
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('P ->  Pending'),
              Text('C -> Confirmed'),
            ],
          ),
          SizedBox(height: 15,),
          // SizedBox(height: 20,),
          // if(pmeal.isNotEmpty)
          // Container(
          //   height: 30,
          //   padding: EdgeInsets.only(left: 10,top: 5,bottom: 5),
          //   margin: EdgeInsets.only(bottom:10),
          //   color: Colors.grey,
          //   child: Text('Pending Requests'),
          // ),
          // if(pmeal.isNotEmpty)
          Expanded(
            child: ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              reverse: true,
              separatorBuilder: (context,i)=>Divider(),
              itemCount: meal.length,
              itemBuilder: (context, i)=>ListTile(
                title: Text(meal[i].requestDate),
                leading: CircleAvatar(
                  child: Text(meal[i].acceptance=='1'?'C':'P'),
                ),
                trailing: Wrap(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text('B'),
                        Text(meal[i].b)
                      ],
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Column(
                      children: <Widget>[
                        Text('L'),
                        Text(meal[i].l)
                      ],
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Column(
                      children: <Widget>[
                        Text('D'),
                        Text(meal[i].d)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          //if(cmeal.isNotEmpty)
          //SizedBox(height: 20,),
          // if(cmeal.isNotEmpty)
          // Container(
          //   height: 30,
          //   padding: EdgeInsets.only(left: 10,top: 5,bottom: 5),
          //   margin: EdgeInsets.only(bottom:10),
          //   color: Colors.grey,
          //   child: Text('Confirmed Requests'),
          // ),
          // if(cmeal.isNotEmpty)
          // Expanded(
          //   child: ListView.separated(
          //     separatorBuilder: (context,i)=>Divider(),
          //     itemCount: cmeal.length,
          //     itemBuilder: (context, i)=>ListTile(
          //       title: Text(cmeal[i].requestDate),
          //       leading: CircleAvatar(
          //         child: Text('C'),
          //       ),
          //       trailing: Wrap(
          //         direction: Axis.horizontal,
          //         children: <Widget>[
          //           Column(
          //             children: <Widget>[
          //               Text('B'),
          //               Text(cmeal[i].b)
          //             ],
          //           ),
          //           SizedBox(
          //             width: 20.0,
          //           ),
          //           Column(
          //             children: <Widget>[
          //               Text('L'),
          //               Text(cmeal[i].l)
          //             ],
          //           ),
          //           SizedBox(
          //             width: 20.0,
          //           ),
          //           Column(
          //             children: <Widget>[
          //               Text('D'),
          //               Text(cmeal[i].d)
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}



















// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sattvik_mess/models/auth.dart';
// import 'package:sattvik_mess/models/meal_cancel.dart';

// class PreviousCancelledMeals extends StatefulWidget {
//   @override
//   _PreviousCancelledMealsState createState() => _PreviousCancelledMealsState();
// }

// class _PreviousCancelledMealsState extends State<PreviousCancelledMeals> {
//   List<MealCancelItem> meal=[];
//   List<MealCancelItem> pmeal = [];
//   List<MealCancelItem> cmeal = [];
//   bool _isLoading = false;
//   bool _isInit = true;
//   void didChangeDependencies() {
//     if(_isInit){
//       setState(() {
//         _isLoading=true;

//       });
//       final _user = Provider.of<Auth>(context,listen: false);
//       Provider.of<MealCancel>(context,listen: false).fetchCancelMeal(_user.mess, _user.email).then((_){
//         print('Meal fetched'); 
//         meal = Provider.of<MealCancel>(context,listen: false).items;
//         print(meal.length);
//         setState(() {
//           _isLoading=false;
//         });
//       });
//     }
//     _isInit=false;
//     super.didChangeDependencies();
//   }
//   Future<void> refreshMeal()async{
//     setState(() {
//       _isLoading=true;
//       meal.clear();
//       pmeal.clear();
//       cmeal.clear();
//     });
//     final _user = Provider.of<Auth>(context,listen: false);
//     await Provider.of<MealCancel>(context,listen: false).fetchCancelMeal(_user.mess, _user.email);
//     print('Meal fetched on refresh');        
//     meal = Provider.of<MealCancel>(context,listen: false).items;
//     print(meal.length);
//     setState(() {
//       _isLoading=false;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     Provider.of<MealCancel>(context);
//     var size = meal.length==1?180:90;
//     double ml = (meal.length*size).toDouble();
//     return _isLoading?Padding(
//       padding: const EdgeInsets.all(30.0),
//       child: Center(child: Column(
//         children: <Widget>[
//           Text('Loding Previous Cancelled Meals'),
//           SizedBox(height: 10,),
//           CircularProgressIndicator(),
//         ],
//       )),
//     ):Container(
//       height: ml,
//       child: Column(
//         children: <Widget>[
//           Divider(),
//           SizedBox(height: 10,),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               IconButton(icon: Icon(Icons.refresh), onPressed: ()=>refreshMeal()),
//               Text('Previoisly Cancelled Meals',style: TextStyle(fontSize: 18),)
//             ],
//           ),
//           SizedBox(height: 10,),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               Text('P ->  Pending'),
//               Text('C -> Confirmed'),
//             ],
//           ),
//           SizedBox(height: 15,),
//           Expanded(
//             child: ListView.separated(
//               reverse: true,
//               separatorBuilder: (context,i)=>Divider(),
//               itemCount: meal.length,
//               itemBuilder: (context, i)=>ListTile(
//                 title: Text(meal[i].requestDate),
//                 leading: CircleAvatar(
//                   child: Text(meal[i].acceptance=='1'?'C':'P'),
//                 ),
//                 trailing: Wrap(
//                   direction: Axis.horizontal,
//                   children: <Widget>[
//                     Column(
//                       children: <Widget>[
//                         Text('B'),
//                         Text(meal[i].b)
//                       ],
//                     ),
//                     SizedBox(
//                       width: 20.0,
//                     ),
//                     Column(
//                       children: <Widget>[
//                         Text('L'),
//                         Text(meal[i].l)
//                       ],
//                     ),
//                     SizedBox(
//                       width: 20.0,
//                     ),
//                     Column(
//                       children: <Widget>[
//                         Text('D'),
//                         Text(meal[i].d)
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }