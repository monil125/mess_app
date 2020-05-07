import 'package:flutter/material.dart';
import 'package:calendarro/calendarro.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sattvik_mess/models/auth.dart';
import 'package:sattvik_mess/models/meal_cancel.dart';


class Calender extends StatefulWidget {
  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  //List<bool> breakfast = [], lunch = [], dinner = [];
  List<MealCancelItem> meal=[];
  List<MealCancelItem> updateMeal = [];
  List<MealCancelItem> newMeal = [];
  bool isInit = true;
  static DateTime _today = DateTime.now();
  List<CalendarItem> selectedDates = [];
  List<DateTime> tempDate=[];
  var _isLoading = false;
  final TextStyle genStyle = TextStyle(color: Colors.grey, fontSize: 18.0);
  //@override
  // void didChangeDependencies() {
  //   if(isInit){
  //     final _user = Provider.of<Auth>(context,listen: false);
  //     Provider.of<MealCancel>(context,listen: false).fetchCancelMeal(_user.mess, _user.email).then((onValue){
  //       print('Meal fetched');        
  //     });
  //   }
  //   isInit=false;
  //   super.didChangeDependencies();
  // }
  Future<void> cancelIt()async{
    setState(() {
      _isLoading=true;
    });
    final _user = Provider.of<Auth>(context,listen: false);
    for(int i=0;i<selectedDates.length;i++){
        int _b = selectedDates[i].b;
        int _l = selectedDates[i].l;
        int _d = selectedDates[i].d;
        meal.add(MealCancelItem(
          acceptance: '0',
          b: _b.toString(),
          d: _d.toString(),
          l: _l.toString(),
          date: DateTime.now().toIso8601String(),
          requestDate: selectedDates[i].date,
          diet: (_b+_l+_d).toString(),
          email: _user.email,
          name: _user.email
        ));
      }
      //print(meal);
    for(int i=0;i<meal.length;i++){
      if(Provider.of<MealCancel>(context,listen: false).checkDate(meal[i].requestDate)){
        updateMeal.add(meal[i]);
      }else{
        newMeal.add(meal[i]);
      }
    }
    //print(newMeal.length); 
    //print('update ${updateMeal.length}');
    try{
      await Provider.of<MealCancel>(context,listen: false).cancelMeal(_user.mess, _user.email, newMeal);
      await Provider.of<MealCancel>(context,listen: false).updateCancelMeal(_user.mess, _user.email, updateMeal);
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Thank You your request has been Submitted'),
        duration: Duration(seconds: 2),
      ));
      setState(() {
        meal.clear();
        updateMeal.clear();
        selectedDates.clear();
        tempDate.clear();
        newMeal.clear();
        _isLoading=false;
      });
    }catch(error){print(error);}
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
          SizedBox(height: 20.0),
          Calendarro(
            startDate: _today.add(Duration(days: 1)),
            endDate: _today.add(Duration(days: 6)),//DateUtils.getLastDayOfNextMonth(),
            displayMode: DisplayMode.MONTHS,
            selectionMode: SelectionMode.MULTI,
            selectedDates:tempDate,
            onTap: (date) {
              setState(() {
                String fDate = DateFormat("yy/MM/dd").format(date);
                int i = selectedDates.indexWhere((test)=>test.date==fDate);
                if(i>=0){
                  selectedDates.removeAt(i);
                }else{
                  selectedDates.add(CalendarItem(
                    date: fDate,
                    b: 0,
                    l: 0,
                    d: 0
                  ));
                }
              });
              //print(selectedDates);
            },
          ),
          Divider(height: 20.0),
          Center(child: Text('To cancel your meals', style: genStyle)),
          SizedBox(height: 25.0),
          _isLoading?Center(
            child: CircularProgressIndicator(),
          ):Container(
            height: 150,
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: selectedDates.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(selectedDates[index].date),
                  //subtitle: Text(DateFormat('EEEE').format(selectedDates[index])),
                  trailing: Wrap(
                    direction: Axis.horizontal,
                    children: [
                      Column(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text('B'),
                          Checkbox(
                            value: selectedDates[index].b==1,
                            onChanged: (bool newValue) {
                              setState(() {
                                selectedDates[index].b = newValue?1:0;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Column(
                        children: <Widget>[
                          Text('L'),
                          Checkbox(
                            value: selectedDates[index].l==1,
                            onChanged: (bool newValue) {
                              setState(() {
                                selectedDates[index].l = newValue?1:0;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Column(
                        children: <Widget>[
                          Text('D'),
                          Checkbox(
                            value: selectedDates[index].d==1,
                            onChanged: (bool newValue) {
                              setState(() {
                                selectedDates[index].d = newValue?1:0;
                              });
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('Select Meals to cancel',style: genStyle,),
                  FlatButton(
                      //color: Colors.grey,
                      onPressed: () =>cancelIt(),
                      child: Text('CONTINUE', style: TextStyle(fontSize: 20.0)))
                ],
              ),
              SizedBox(height: 5.0,),
              // Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              //   IconButton(icon: Icon(Icons.refresh), onPressed: () {}),
              //   Text('Previoisly Cancelled Meals',style: genStyle,)
              // ])
            ],
          )
        ]),
    );
  }
}

class CalendarItem{
  String date;
  int b;
  int l;
  int d;
  CalendarItem({this.date,this.b=0,this.l=0,this.d=0});
}