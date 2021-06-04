import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutterphone/WORKER_SANAYEE/State_order_accept.dart';
import 'package:flutterphone/WORKER_SANAYEE/tassser.dart';
import 'package:flutterphone/constants.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'orders_workers.dart';

String IP4="192.168.1.8:8080";

DateTime _selectedDay = DateTime.now();

class not_conferm_order extends StatefulWidget {
  final phone;
  final DateTime time;
  final name;
  final  image;
  final  Work;
  final  Experiance;
  final  Information;
  final  token;
  final namefirst;
  final namelast;
  final lat;
  final lng;
  not_conferm_order({this.lat,this.lng,this.phone,this.time,this.name,this.namefirst,this.namelast,this.image,this.Work, this.Experiance, this.Information, this.token});
  @override
  _not_conferm_order createState() => _not_conferm_order();
}

class _not_conferm_order extends State<not_conferm_order> {
  var List11=[];
  var ListDate11=[];
  StreamController<Map<DateTime, List>> _streamController;
  CalendarController _calendarController;

  Map<DateTime, List<dynamic>> _events;
  Future getallorders() async {
    var formattedDate = DateFormat('yyyy-MM-dd').format(widget.time);
    var url = 'http://'+IP4+'/testlocalhost/count_not_conferm.php';
    var ressponse = await http.post(url, body: {
      "phone": widget.phone,
    });
    return json.decode(ressponse.body);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _calendarController = CalendarController();
    _streamController = StreamController();
    //_fetchEvents();
  }
  @override
  void dispose() {
    _calendarController.dispose();
    _streamController.close();
    super.dispose();
  }
  // void _fetchEvents() {
  //   List11=widget.List1;
  //   ListDate11=widget.ListDate;
  //   int i=0;
  //   print(widget.List1);
  //   Map<DateTime, List<dynamic>> _events={};
  //   DateTime date;
  //   widget.List1.forEach(
  //         (element) {
  //       date = DateTime.tryParse(widget.ListDate[i]);i++;
  //       if (_events[date] == null) _events[date] = [];
  //       _events[date].add(element);
  //     },
  //   );
  //   _streamController.add(_events);
  // }
  void _onDaySelected(DateTime day, List events,List r) {
    setState(() {
      _selectedDay = day;
      var dateParse = DateTime.parse(_selectedDay.toString());

      print(_selectedDay);
    });
  }
  @override
  Widget build(BuildContext context) {
    // print(Listsearch.toString());
    print(widget.name);
    print('BUILD');
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Directionality(textDirection: ui.TextDirection.rtl,
      child:Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.grey[50],
            key: _scaffoldKey,
            body: Form(
              child: Column(

                // crossAxisAlignment: CrossAxisAlignment.stretch,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => order_worker(lat:widget.lat,lng:widget.lng,Information:widget.Information,Experiance:widget.Experiance,Work:widget.Work,namelast:widget.namelast,name:widget.name,phone:widget.phone,image:widget.image,token:widget.token,namefirst:widget.namefirst)));},

                    child:Container(
                      margin:EdgeInsets.only(top:60,left:380),
                      child:Icon(Icons.arrow_back,color: Colors.black,),
                    ),
                  ),
                  SingleChildScrollView(
                    child:  Container(
                      height: 702,
                      width: 500,
                      decoration: BoxDecoration(
                        color:Colors.grey[50],
                        // borderRadius: BorderRadius.only(
                        //   topLeft: Radius.circular(50),
                        //   topRight: Radius.circular(50),
                        // ),
                      ),
                      child:FutureBuilder(
                        future: getallorders(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if(snapshot.hasData){
                            return ListView.builder(
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                var Listorder=snapshot.data;
                                return order(lat:widget.lat,lng:widget.lng,name:widget.name,List1:Listorder,phone: widget.phone,time: widget.time,);
                              },
                            );
                          }
                          print('bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbmmmmmmmmmmmmmmmmmmmmmmmmmmm');
                          return Center(child: CircularProgressIndicator());
                        },
                      ),
                    ),
                  ),
                ],),),),],),);
  }
}


class order extends StatefulWidget {
  final phone;
  final DateTime time;
  List<dynamic> List1;
  final name;
  final  image;
  final  Work;
  final  Experiance;
  final  Information;
  final  token;
  final namefirst;
  final namelast;
  final lng;
  final lat;
  order({this.lng,this.lat,this.name,this.phone,this.List1,this.time,this.namefirst,this.namelast,this.image,this.Work, this.Experiance, this.Information, this.token});
  @override
  _order createState() => _order();
}

class _order extends State<order> {
  var List11=[];
  var ListDate11=[];
  StreamController<Map<DateTime, List>> _streamController;
  CalendarController _calendarController;
  Map<DateTime, List<dynamic>> _events;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _calendarController = CalendarController();
    _streamController = StreamController();
    _fetchEvents();
  }
  @override
  void dispose() {
    _calendarController.dispose();
    _streamController.close();
    super.dispose();
  }

  // Future getallorders() async {
  //   var url = 'http://'+IP4+'/testlocalhost/day_order_accept.php';
  //   var ressponse = await http.post(url, body: {
  //     "phone": widget.phone,
  //     "date": formattedDate,
  //   });
  //   return json.decode(ressponse.body);
  // }

  void _fetchEvents() {
    int i=0;
    print(widget.List1);
    Map<DateTime, List<dynamic>> _events={};
    DateTime date;
    widget.List1.forEach(
          (element) {
        date = DateTime.tryParse(widget.List1[i]['date']);i++;
        if (_events[date] == null) _events[date] = [];
        _events[date].add(element);
      },
    );
    _streamController.add(_events);
  }
  void _onDaySelected(DateTime day, List events,List r) {
    _selectedDay = day;
    var dateParse = DateTime.parse(_selectedDay.toString());
    var formattedDate = DateFormat('yyyy-MM-dd').format(day);
    print(formattedDate);
    // print(_selectedDay);
    print(widget.name);
    Navigator.push(context, MaterialPageRoute(builder: (context) => not_conferm_order(lat:widget.lat,lng:widget.lng,phone:widget.phone,time: _selectedDay,name: widget.name,),),);
  }
  Future getallorders() async {
    var formattedDate = DateFormat('yyyy-MM-dd').format(widget.time);
    var url = 'http://'+IP4+'/testlocalhost/day_orders.php';
    var ressponse = await http.post(url, body: {
      "phone": widget.phone,
      "date": formattedDate,
    });
    return json.decode(ressponse.body);
  }
  @override
  Widget build(BuildContext context) {
    _fetchEvents();
    print(widget.List1);
    return Container(
      transform: Matrix4.translationValues(0.0, -52.0, 0.0),
      height: 710,
      color: Colors.white,
      child:Column(
        children:<Widget>[
          Container(
            color:Colors.grey[50],
            child: StreamBuilder<Map<DateTime, List>>(
              stream: _streamController.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SizedBox(
                    height: 100.0,
                    width: 100.0,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final events = snapshot.data;
                return TableCalendar(
                  onDaySelected: _onDaySelected,

                  calendarController: _calendarController,
                  events: events,
                  initialSelectedDay: widget.time,
                  initialCalendarFormat: CalendarFormat.week,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  formatAnimation: FormatAnimation.slide,
                  headerStyle: HeaderStyle(
                    centerHeaderTitle: true,
                    formatButtonVisible: false,
                    titleTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16
                    ),
                    leftChevronIcon: Icon(Icons.arrow_back_ios, color:Colors.black, size: 15,),
                    rightChevronIcon: Icon(Icons.arrow_forward_ios, color:Colors.black, size: 15,),
                    leftChevronMargin: EdgeInsets.only(left: 70),
                    rightChevronMargin: EdgeInsets.only(right: 70),
                  ),
                  calendarStyle: CalendarStyle(
                      todayColor: Colors.grey[200],
                      selectedColor: Y,
                      weekendStyle: TextStyle(
                          color: Colors.black
                      ),
                      weekdayStyle: TextStyle(
                          color: Colors.black
                      )
                      ),
                      daysOfWeekStyle: DaysOfWeekStyle(
                      weekendStyle: TextStyle(color: Colors.black,),
                      weekdayStyle: TextStyle(
                          color: Colors.black
                      )

                  ),);},),
          ),

          Container(
            height: 500,
            margin:EdgeInsets.only(top:35),
            child: Container(
              child:FutureBuilder(
                future: getallorders(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if(snapshot.hasData){
                    print('SARAHHHHHHHHHHHHHHHHhhhhhhhhhhhhhhhhhhhhhkkkkkkkkkkkkkkkkkkkkkkkk');
                    print(snapshot.data.length);
                    if(snapshot.data.length==0) {
                      print(widget.name);
                      print('EMPTEY');
                      return Empty();

                    }
                    return ListView.builder(
                      itemCount:snapshot.data.length,
                      itemBuilder: (context, index) {
                        print(snapshot.data.length);
                        print(widget.name);
                        print('ASDASDASD');

                        return not_conferm(lat:widget.lat,lng:widget.lng,latuser:snapshot.data[index]['lat'],lnguser:snapshot.data[index]['lng'],country:snapshot.data[index]['country'],city:snapshot.data[index]['city'],Information:snapshot.data[index]['Information'],Experiance:snapshot.data[index]['Experiance'],orderimage:snapshot.data[index]['orderimage'],workername:widget.name,timesend:snapshot.data[index]['timesend'],datesend:snapshot.data[index]['datesend'],image:snapshot.data[index]['image'],phoneworker:widget.phone,description:snapshot.data[index]['description'],namefirst:snapshot.data[index]['namefirst'],namelast:snapshot.data[index]['namelast'],phone:snapshot.data[index]['phoneworker'],name:snapshot.data[index]['username'],date:snapshot.data[index]['date'],timestart:snapshot.data[index]['timestart'],timeend:snapshot.data[index]['timeend'],Am_Pm:snapshot.data[index]['Am_Pm'],id:snapshot.data[index]['id']);
                      },
                    );
                  }
                  return Center(child: Container());
                },
              ),),
            // Column(
            //   children: [
            //     dayTask("10 am", "Michael Hamilton"),
            //     dayTask("11 am", "Alexandra Johnson"),
            //     dayTask("2 pm", "Michael Hamilton"),
            //   ],
            // )
          ),
        ],),);
  }
}

class Empty extends StatefulWidget {
  @override
  final phone;
  final DateTime time;
  final name;
  Empty({this.phone,this.time,this.name});
  _Empty createState() => _Empty();
}

class _Empty extends State<Empty> {
  CalendarController _calendarController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _calendarController = CalendarController();
    // _streamController = StreamController();
  }

  @override
  void _onDaySelected(DateTime day, List events,List r) {
    _selectedDay = day;
    var dateParse = DateTime.parse(_selectedDay.toString());
    var formattedDate = DateFormat('yyyy-MM-dd').format(day);
    print(formattedDate);
    print("Nulllll");
    // print(_selectedDay);
    Navigator.push(context, MaterialPageRoute(builder: (context) => not_conferm_order(phone:widget.phone,time: _selectedDay,name: widget.name,),),);

  }
  @override
  int _page = 0;
  bool image = false;
  GlobalKey _bottomNavigationKey = GlobalKey();

  Widget build(BuildContext context) {
    return Container(
      height: 400,
      color: Colors.white,
      child: Column(
          children: <Widget>[
            // final events = snapshot.data;
            Expanded(
              child: Container(
                width: 500,
                height: 400,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 150,),
                    Center(
                      child: Text('لا توجد لديك مواعيد في هذا اليوم',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 15.0,
                          fontFamily: 'Changa',
                          fontWeight: FontWeight.bold,
                        ),),
                    ),
                  ],
                ),
              ),
            ),

          ]
      ),
    );
  }
}


class not_conferm  extends StatefulWidget {
  final  date;
  final  timeend;
  final  timestart;
  final  Am_Pm;
  final AVG;
  final id;
  final name;
  final phone;
  final namefirst;
  final namelast;
  final image;
  final work;
  final country;
  final phoneworker;
  final description;
  final time;
  final datesend;
  final dateaccept;
  final timesend;
  final timeaccept;
  final datecancel;
  final timecancel;
  final  token;
  final workertoken;
  final index;
  final workername;
  final orderimage;
  final Information;
  final Experiance;
  final city;
  final lat;
  final lng;
  final latuser;
  final lnguser;
  //
  not_conferm({this.latuser,this.lnguser,this.lng,this.lat,this.city,this.Information,this.Experiance,this.orderimage,this.workername,this.datecancel,this.timecancel,this.index,this.AVG,this.token,this.workertoken,this.timeaccept,this.dateaccept,this.datesend,this.timesend,this.description,this.id,this.country,this.phoneworker,this.work,this.image,this.namefirst,this.namelast,this.name,this.date, this.timeend, this.timestart, this.Am_Pm,this.phone, this.time});

  @override
  _not_conferm createState() => _not_conferm();
}
class _not_conferm extends State<not_conferm> {
  var List=[];
  var DateList=[];
  bool press=true;
  double h=165;
  @override
  Widget build(BuildContext context) {

    return Column(
      children:[
        card(widget.date,widget.namefirst+" "+widget.namelast,widget.timestart,widget.timeend,widget.Am_Pm,widget.image,widget.work,widget.description),
      ],
    );

  }
  GestureDetector card(String date, String name,String timestart,String timeend,String Am_Pm,String image,String work,String desc)
  {
    return GestureDetector(
      onTap: (){
      },
      child:Container(
        width: 380,
        height: h,
        alignment: Alignment.topRight,
        decoration: BoxDecoration(
           color:Colors.grey[50],
          borderRadius: BorderRadius.circular(5),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black87.withOpacity(0.4),
          //     blurRadius: 1,
          //     spreadRadius: 1,
          //     offset: Offset(0.1,0.5), // shadow direction: bottom right
          //   )
          // ],
        ),
        margin: EdgeInsets.only(bottom: 20,),
        padding: EdgeInsets.only(right: 20,top: 20,bottom: 10),
        child:Column(
          children: [
            // Container(
            //   margin: EdgeInsets.only(top: 10, right: 5),
            //   child: CircleAvatar(backgroundImage: NetworkImage(
            //       'http://' + IP4 + '/testlocalhost/upload/' + widget.image),
            //     radius: 25.0,),),
            Container(
              alignment: Alignment.topRight,
              child:Row(
                children: [
                  Text('اسم العميل    ', style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                    fontFamily: 'Changa',
                  ),
                  ),
                  Text(widget.namefirst+" "+widget.namelast, style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black54,
                    fontFamily: 'Changa',
                  ),
                  ),
                ],
              ),

            ),
            Container(
              width: 370,
              margin: EdgeInsets.only(top:3),
              child:  Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width:83,
                    child:Text('الوقت', style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                      fontFamily: 'Changa',
                    ),
                    ),
                  ),
                  // Icon(Icons.access_time_rounded,size:20,color:Colors.black87,),
                  // SizedBox(width: 30,),
                  Container(child:Row(
                    children: [
                      Text(timestart +" - " +timeend, style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black54,
                        fontFamily: 'Changa',
                      ),),
                      Text(" "),
                      Text(Am_Pm=="am"?"صباحا":"مساء", style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.black54,
                        fontFamily: 'Changa',
                      ),),
                    ],
                  ),),
                ],
              ),
            ),
            Container(
              alignment: Alignment.topRight,
              margin: EdgeInsets.only(top:3),
              child:Row(
                children: [
                  Text('الموقع  ', style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                    fontFamily: 'Changa',
                  ),
                  ),
                  SizedBox(width: 30,),
                  Text(""+widget.country+" ("+widget.city+") ", style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black54,
                    fontFamily: 'Changa',
                  ),
                  ),
                  Icon(Icons.location_on,size:20,color:Colors.black87,),
                ],
              ),

            ),

            SizedBox(height:10,),
            press?Container():Container(
              margin: EdgeInsets.only(top:0,right: 0),
              child:  Row(
                children: [
                  Container(
                    width:90,
                    height: 60,
                    child:Text('تفاصبل الطلب', style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                      fontFamily: 'Changa',
                    ),
                    ),
                  ),
                  Container(
                    width:250,
                    height: 60,
                    child:Text(desc, style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.black54,
                      fontFamily: 'Changa',
                    ),
                    ),
                  ),
                ],
              ),
            ),
            widget.orderimage!=null && !press?Container(
              // print(_image[index].id+"");
              width: 200,
              height: 150,
              transform: Matrix4.translationValues(0.0, -0.0, 0.0),
              margin: EdgeInsets.only(left: 170,top:0,bottom: 15),
              decoration: BoxDecoration(
                color:Colors.white,
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(image: NetworkImage('http://'+IP4+'/testlocalhost/upload/'+widget.orderimage),
                  fit: BoxFit.cover,
                ),
              ),
            ):Container(),

            Container(
              margin:EdgeInsets.only(top: 10.0),
              child: Row(
                children: [
                  !press?GestureDetector(
                    onTap: (){
                      press=!press;
                      h=165;
                      setState(() {
                      });
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Text('عرض أقل',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                              fontFamily: 'Changa',
                            ),),
                          Icon(Icons.keyboard_arrow_up_outlined,size: 20,),
                        ],
                      ),
                    ),
                  ):
                  GestureDetector(
                    onTap: (){
                      press=!press;
                      if(widget.orderimage==null)h=220;
                      else h=385;
                      setState(() {

                      });
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Text('عرض المزيد',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                              fontFamily: 'Changa',
                            ),),
                          Icon(Icons.keyboard_arrow_down,size: 20,),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      _dialogCall();
                    },
                    child: Container(
                      width: 50,
                      margin:EdgeInsets.only(top: 0.0, bottom: 0.0, left: 25.0, right: 159),
                      child: Text(
                        "قبول",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Y,
                          fontFamily: 'Changa',
                        ),
                      ),
                    ),),
                  GestureDetector(
                    onTap: (){
                      print("delete");
                      print(widget.id);
                      _dialogCall2();
                    },
                    child: Container(
                      width: 50,
                      margin:EdgeInsets.only(top: 0.0, bottom: 0.0, left: 0.0, right: 0.0),
                      child: Text(
                        "حذف",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Y,
                          fontFamily: 'Changa',
                        ),
                      ),
                    ),),
                ],
              ),
            ),
          ],
        ),),
      // Container(
      //   padding: EdgeInsets.all(20),
      //   width: MediaQuery.of(context).size.width*0.2,
      //   child: Text(date, style: TextStyle(
      //     color: Colors.black,
      //     fontWeight: FontWeight.w700,
      //   ), textAlign: TextAlign.right,),
      // ),
    );
  }
  Future<void> _dialogCall() {
    print(widget.phoneworker);
    print(widget.workername);
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          print(widget.lat);
          print(widget.lng);
          print(widget.latuser);
          print(widget.lnguser);

          return Directionality(textDirection: ui.TextDirection.rtl,
            child:eaccept_order(lat:widget.lat,lng:widget.lng,latuser:widget.latuser,lnguser:widget.lnguser,orderimage:widget.orderimage,timestart:widget.timestart,timeend:widget.timeend,country:widget.country,city:widget.city,phoneworker:widget.phoneworker,workername:widget.workername,name:widget.name,ChooseDate:_selectedDay,image:widget.image,description:widget.description,datesend:widget.datesend,timesend:widget.timesend,id:widget.id,phone:widget.phoneworker,date:widget.date,namefirst: widget.namefirst,namelast:widget.namelast,time:widget.time,),);
        });
  }
  Future<void> _dialogCall2() {
    print(widget.phoneworker);
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Directionality(textDirection: ui.TextDirection.rtl,
            child:delete_order(country:widget.country,city:widget.city,name:widget.workername,work:widget.work,Information:widget.Information,Experiance:widget.Experiance,phoneworker:widget.phoneworker,chooseDate:_selectedDay,image:widget.image,description:widget.description,datesend:widget.datesend,timesend:widget.timesend,id:widget.id,phone:widget.phoneworker,date:widget.date,namefirst: widget.namefirst,namelast:widget.namelast,time:widget.time,),);
        });
  }

}

class eaccept_order extends StatefulWidget {
  @override
  final orderimage;
  final id;
  final phone;
  final time;
  final image;
  final country;
  final city;
  final namefirst;
  final namelast;
  final phoneuser;
  final phoneworker;
  final description;
  final date;
  final datesend;
  final timesend;
  final timestart;
  final timeend;
  final ChooseDate;
  final name;
  final workername;
  final lat;
  final lng;
  final latuser;
  final lnguser;
  eaccept_order({this.latuser,this.lnguser,this.lng,this.lat,this.orderimage,this.city,this.workername,this.name,this.ChooseDate,this.timeend,this.timestart,this.id,this.phone,this.time,this.date,this.phoneworker,this.phoneuser,this.timesend,this.datesend,this.namelast,this.namefirst,this.description,this.image,this.country});
  _eaccept_order createState() => new _eaccept_order();

}
class _eaccept_order extends State<eaccept_order> {
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      actionsPadding: EdgeInsets.zero,
      content: new SingleChildScrollView(
        child: new ListBody(
          children: <Widget>[
            Column(
              children: [

                Container(
                  margin: EdgeInsets.only(right: 0,top:10),
                  child: Text('هل أنت متأكد من أنك تريد قبول هذا الطلب ؟',
                    style: TextStyle(
                      fontFamily: 'Changa',
                      color: Colors.black45,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),),
                ),
                SizedBox(height: 50,),
                Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        print(widget.phoneworker);
                        print(widget.workername);
                        print('phoneeeeeeeeeeeeeeeeeeeeeeeeeeee');
                        DateTime date=DateTime.now();
                        var formattedDate = DateFormat('yyyy-MM-dd').format(date);
                        var formattedTime = DateFormat('HH:mm:ss').format(date);
                        accept_Order(formattedDate,formattedTime);
                        print(widget.orderimage);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => State_order_accept(lat:widget.lat,lng:widget.lng,latuser:widget.latuser,lnguser:widget.lnguser,orderimage:widget.orderimage,time:widget.timestart+" - "+widget.timeend,country:widget.country,city:widget.city,workername:widget.workername,name:widget.name,timesend:widget.timesend,timeaccept:formattedTime,dateaccept:formattedDate,datesend:widget.datesend,date:widget.date,phoneworker:widget.phoneworker,description:widget.description,namefirst: widget.namefirst,namelast: widget.namelast,phoneuser: widget.phone,image: widget.image,ChooseDate:widget.ChooseDate,),),);
                        // Navigator.pop(context);
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => not_conferm__order(time: widget.time,phone: widget.phone,)),);
                      },
                      child: Container(
                          margin: EdgeInsets.only(right: 170),
                          child:Text('حسنا',
                            style: TextStyle(
                              fontFamily: 'Changa',
                              color: Y,
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                          margin: EdgeInsets.only(right: 48),
                          child:Text('إلغاء',
                            style: TextStyle(
                              fontFamily: 'Changa',
                              color:Y,
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                      ),
                    ),
                  ],
                ),
                // SizedBox(width: 10,),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future accept_Order(String formattedDate,String formattedTime) async {
    var url = 'http://' + IP4 + '/testlocalhost/acceptorder.php';
    var ressponse = await http.post(url, body: {
      "id": widget.id,
      "timeaccept":formattedTime,
      "dateaccept":formattedDate,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
}


class delete_order extends StatefulWidget {
  @override
  final city;
  final id;
  final phone;
  final time;
  final image;
  final country;
  final namefirst;
  final namelast;
  final phoneuser;
  final phoneworker;
  final description;
  final date;
  final datesend;
  final timesend;
  final timestart;
  final timeend;
  final chooseDate;
  final name;
  final Experiance;
  final work;
  final Information;
  delete_order({this.city,this.name,this.Information,this.Experiance,this.work,this.chooseDate,this.timeend,this.timestart,this.id,this.phone,this.time,this.date,this.phoneworker,this.phoneuser,this.timesend,this.datesend,this.namelast,this.namefirst,this.description,this.image,this.country});
  _delete_order createState() => new _delete_order();

}
class _delete_order extends State<delete_order> {
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      actionsPadding: EdgeInsets.zero,
      content: new SingleChildScrollView(
        child: new ListBody(
          children: <Widget>[
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 0,top: 10),
                  child: Text('هل أنت متأكد من أنك تريد حذف هذا الطلب ؟',
                    style: TextStyle(
                      fontFamily: 'Changa',
                      color: Colors.black45,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),),
                ),
                SizedBox(height:50,),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async{
                        await delete_Order();
                        DateTime date_d =DateTime.now();
                        print(widget.phoneworker);
                        print('=========================================================================');

                        // Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => not_conferm_order(name:widget.name,time:_selectedDay,phone: widget.phoneworker,namelast:widget.namelast,namefirst:widget.namefirst,)),);
                      },
                      child: Container(
                          margin: EdgeInsets.only(right: 170),
                          child:Text('حسنا',
                            style: TextStyle(
                              fontFamily: 'Changa',
                              color: Y,
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                          margin: EdgeInsets.only(right: 48),
                          child:Text('إلغاء',
                            style: TextStyle(
                              fontFamily: 'Changa',
                              color: Y,
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                      ),
                    ),
                  ],
                ),
                // SizedBox(width: 10,),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future delete_Order() async {
    DateTime date=DateTime.now();
    var formattedDate = DateFormat('yyyy-MM-dd').format(date);
    var formattedTime = DateFormat('HH:mm:ss').format(date);
    print(widget.id);
    var url = 'http://' + IP4 + '/testlocalhost/delete_order.php';
    var ressponse = await http.post(url, body: {
      "id": widget.id,
      "who":'worker',
    });
    // ignore: deprecated_member_use
    //return json.decode(ressponse.body);
  }
}
class view extends StatefulWidget {
  final lat;
  final lng;
  final latuser;
  final lnguser;
  final orderimage;
  final phoneuser;
  final name;
  final describes;
  final namefirst;
  final namelast;
  final image;
  final type;
  final workerphone;
  final nameofwork;
  final start;
  final end;
  final id;
  final city;
  final country;
  final namefirstworker;
  final namelastworker;
  final imageworker;
  final tokenworker;
  final Information;
  final Experiance;
  final work;
  final from;
  final to;
  view({this.name,this.from,this.to,this.work,this.namefirstworker,this.namelastworker,this.imageworker,this.tokenworker,this.Experiance,this.Information,this.orderimage,this.latuser,this.lnguser,this.lng,this.lat,this.country,this.city,this.start,this.id,this.end,this.image,this.type,this.namelast,this.workerphone,this.namefirst,this.phoneuser,this.nameofwork,this.describes});
  @override
  _viewState createState() => _viewState();
}

class _viewState extends State<view> {
  @override
  bool datepicher=false;
  Widget build(BuildContext context) {
    return Column(

      children:[
        card(widget.namefirst,widget.namelast,widget.describes,widget.phoneuser,widget.workerphone,widget.nameofwork,widget.image,widget.type),

      ],);
  }
  Widget card(String namefirst , String namelast,String describes,String phoneuser,String workerphone,String nameofwork,String image,String type)
  { print("tafaseel talab "+workerphone);

  return GestureDetector(
    onTap: (){
      // Navigator.push(context, MaterialPageRoute(builder: (context) => State_warshe_accept(name:widget.name,type:widget.type,from:widget.from,to:widget.to,tokenworker:widget.tokenworker,imageworker:widget.imageworker,namelastworker:widget.namelastworker,namefirstworker:widget.namefirstworker,Information:widget.Information,Experiance:widget.Experiance,work:widget.work,country:widget.country,city:widget.city,description:widget.describes,latuser:widget.latuser,lnguser:widget.lnguser,lat:widget.lat,lng:widget.lng,orderimage:widget.orderimage,workername:widget.nameofwork,id:widget.id,namefirst: widget.namefirst,namelast: widget.namelast,phoneuser: widget.phoneuser,image: widget.image,phoneworker:widget.workerphone),),);
    },
    child:Container (
      height:105,
      width: 380,
      transform: Matrix4.translationValues(0.0, -20.0, 0.0),
      // margin: EdgeInsets.only(top:5,bottom: 20),
      padding: EdgeInsets.all(5),
      alignment: Alignment.topRight,
      decoration: BoxDecoration(
        color:Colors.grey[50],
        borderRadius: BorderRadius.circular(5),
      ),
      clipBehavior: Clip.hardEdge,
      child:Row(
        children: [
          Container(
            // print(_image[index].id+"");
            width: 75,
            height: 75,
            margin: EdgeInsets.only(right:10,top:0),
            decoration: BoxDecoration(
              color:Colors.white,
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(image: NetworkImage('http://'+IP4+'/testlocalhost/upload/'+widget.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: 270,
            child:Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top:3,right: 10),
                  child:  Row(
                    children: [
                      // Container(
                      //   width:90,
                      //   child:Text('اسم العميل ', style: TextStyle(
                      //     fontSize: 14,
                      //     fontWeight: FontWeight.w700,
                      //     color: Colors.black87,
                      //     fontFamily: 'Changa',
                      //   ),
                      //   ),
                      // ),
                      Container(
                        width:170,
                        child:Text(namefirst + " " +namelast, style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                          fontFamily: 'Changa',
                        ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top:0,right: 10),
                  child:  Row(
                    children: [
                      // Container(
                      //   width:90,
                      //   child:Text('تفاصيل الطلب', style: TextStyle(
                      //     fontSize: 14,
                      //     fontWeight: FontWeight.w700,
                      //     color: Colors.black87,
                      //     fontFamily: 'Changa',
                      //   ),
                      //   ),
                      // ),
                      Container(
                        width:170,
                        child:Text(describes, style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black54,
                          fontFamily: 'Changa',
                        ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   alignment:Alignment.topRight,
                //   margin:EdgeInsets.only(right:15,top:3),
                //   child:Row(
                //    children: [
                //      Text('مدة الورشة ',
                //        style: TextStyle(
                //          fontSize: 13,
                //          fontWeight: FontWeight.w700,
                //          color: Colors.black87,
                //          fontFamily: 'Changa',
                //        ),),
                //      SizedBox(width: 20,),
                //      Text('من '+"  "+widget.start,
                //        style: TextStyle(
                //          fontSize: 13,
                //          fontWeight: FontWeight.w700,
                //          color: Colors.black54,
                //          fontFamily: 'Changa',
                //        ),),
                //    ],
                //   )
                //
                // ),
                // Container(
                //   child: Row(
                //     children: [
                //       SizedBox(width: 100,),
                //       Text('إلى '+ " "+widget.end,
                //         style: TextStyle(
                //           fontSize: 13,
                //           fontWeight: FontWeight.w700,
                //           color: Colors.black54,
                //           fontFamily: 'Changa',
                //         ),),
                //     ],
                //   ),
                // ),
                Container(
                  width: 280,
                  height: 30,
                  margin: EdgeInsets.only(right: 15,top:10),
                  child: Row(
                    children: [
                      SizedBox(width:148,),
                      GestureDetector(
                        onTap: () async{
                          await _showMyDialogo1();
                          // await _showDialog();
                        },
                        child: Container(
                          child: Row(
                            children: [
                              Text('تسعير الطلب',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Y,
                                  fontFamily: 'Changa',
                                ),),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width:20,),
                      GestureDetector(
                        onTap: () async{
                          await delete();
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => taasser(name: widget.name,phone: widget.workerphone,Information:widget.Information,Experiance:widget.Experiance,Work:widget.work,namelast:widget.namelast,image:widget.image,token:widget.tokenworker,namefirst:widget.namefirst)));
                        },
                        child: Container(
                          child: Row(
                            children: [
                              Text('حذف',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Y,
                                  fontFamily: 'Changa',
                                ),),
                              // Icon(Icons.delete)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Image.asset('assets/card-sample-image.jpg'),
                // Image.asset('assets/card-sample-image-2.jpg'),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  }
  Future<void> delete() async {
    int i = 0;
    var url ='http://'+IP4+'/testlocalhost/deletetasser.php';
    var ressponse = await http.post(url, body: {
      "id": widget.id,

    });
  }

  Future<void> addlongtimework(final List<DateTime> picked) async {
    // int i = 0;
    // print(widget.workerphoned);
    // var flag=true;
    // //  DateTime fromDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(widget.fromdate);
    // if(widget.fromdate ==null||widget.Todate==null){
    //   print('hi hi hi');
    //   // print(widget.nameofwork);
    //   //print(widget.namefirst);
    //   var url ='http://'+IP4+'/testlocalhost/reservations.php';
    //   var ressponse = await http.post(url, body: {
    //     "nameofwork": widget.nameofworkd,
    //     "namefirst": widget.namefirstd,
    //     "namelast": widget.namelastd,
    //     "phoneuser": widget.phoneuserd,
    //     "workerphone": widget.workerphoned,
    //     //"id": widget.id,
    //     "Fromdate": picked.first.toString(),
    //     "Todate": picked.last.toString(),
    //   });
    // }
    // else{ bool flag=false;
    // print("I am checking for overlapping");
    // print(widget.fromdate.length-1);
    // print(widget.Todate.length-1);
    // for(int p=0;p<widget.fromdate.length-1;p++){
    //   if(flag==true)break;
    //   DateTime from = DateTime.parse(widget.fromdate[p]);
    //   print(from);
    //   DateTime to = DateTime.parse(widget.Todate[p]);
    //   print(to);
    //   DateTime start = picked.first;
    //   DateTime end = picked.last;
    //
    //   if (start == from || start == to ||(start.isBefore(to) && start.isAfter(from))){
    //     flag=true;_showMyDialogo();break;
    //
    //     print("overlap");}
    //   else
    //   if (end == from || end == to || (end.isBefore(to) && end.isAfter(from))) {
    //     print("overlap");flag=true;_showMyDialogo();break;
    //   }
    // }
    // if(flag==true) _showMyDialogo();
    // if(flag==false) {
    //   widget.ifpicked=true;
    //   //print(from); // 2020-01-02 03:04:05.000
    //   //row["name"].contains(value)
    //   //if(picked.first [i]>= dt)
    //   var mesaage;
    //   print('hi hi hi');
    //   var url = 'http://'+IP4+'/testlocalhost/reservations.php';
    //   var ressponse = await http.post(url, body: {
    //     "nameofwork": widget.nameofworkd,
    //     "namefirst": widget.namefirstd,
    //     "namelast": widget.namelastd,
    //     "phoneuser": widget.phoneuserd,
    //     "workerphone": widget.workerphoned,
    //     //"id": widget.id,
    //     "Fromdate": picked.first.toString(),
    //     "Todate": picked.last.toString(),
    //   });
    //
    //   // mesaage = json.decode(ressponse.body);
    // }
    // }
  }
  Future<void> _showMyDialogo( ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('تضارب في المواعيد'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("يوجد لديك حجز في التاريخ المختار"),
                Text('اختر موعدا اخر'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

          ],
        );
      },
    );
  }
  int _n=0;
  void minus() {
    setState(() {
      if (_n != 0)
        _n--;
      f=true;
    });
  }
  void add() {
    setState(() {
      _n++;
      f=true;
    });
  }
  bool f=false;
  TextEditingController count =TextEditingController();
  TextEditingController description =TextEditingController();

  Future<void> _showMyDialogo1( ) async {
    count.text='0';
    return showDialog<void>(
      context: context,
      builder: (context) {
        String contentText = "Content of Dialog";
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              actions: <Widget>[
                SizedBox(height:10,),
                Container(
                  width: 300,
                  margin: EdgeInsets.only(top:5),
                  child:  Row(
                    children: [
                      Container(
                        width: 150,
                        height:35,
                        margin: EdgeInsets.only(left:5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          // color: Colors.black87,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              color:Y,
                              child:GestureDetector(
                                onTap: (){
                                  _n++;
                                  setState(() {
                                    count.text=_n.toString();
                                    // contentText = "Changed Content of Dialog";
                                  });
                                },
                                child: Icon(Icons.add),
                              ),
                            ),

                            Container(
                              width:70,
                              height: 30,
                              color:Colors.grey[100],
                              padding: EdgeInsets.only(top:5),
                              // alignment:Alignment.center,
                              child: TextFormField(
                                cursorColor:Colors.grey[600],
                                textAlign: TextAlign.center,
                                //controller: text_post,
                                controller: count,
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 15.0,
                                  fontFamily: 'Changa',
                                  fontWeight: FontWeight.bold,
                                ),
                                onEditingComplete: (){
                                  _n=int.parse(count.text);
                                  print("ASDASDASDASDASDASD");
                                  print(_n.toString());
                                },
                                onChanged: (content) {
                                  _n=int.parse(count.text);
                                  print("ASDASDASDASDASDASD");
                                  print(_n.toString());
                                  setState(() {

                                  });
                                },
                                //o: Desc(),
                                decoration: InputDecoration(
                                  hoverColor:Colors.black54,
                                  contentPadding: EdgeInsets.only(top:0),
                                  enabledBorder: new OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(30.0),
                                    borderSide:  BorderSide(color: Colors.grey[100]),

                                  ),
                                  focusedBorder: new OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(30.0),
                                    borderSide:  BorderSide(color:Colors.grey[100]),

                                  ),
                                  // hintText: 'أضف تفصيل لطلبك لتسعيره',
                                  focusColor:Colors.black54,
                                  hintStyle: TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: 'Changa',
                                    color: Colors.grey.withOpacity(0.8),
                                  ),
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                ),
                              ),
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              color:Y,
                              // alignment:Alignment.center,
                              child:GestureDetector(
                                onTap: (){
                                  _n--;
                                  setState(() {
                                    count.text=_n.toString();
                                    // contentText = "Changed Content of Dialog";
                                  });
                                },
                                child: Icon(Icons.remove,),
                                // child: Text('_',
                                //   style: TextStyle(
                                //     fontSize: 20,
                                //     fontWeight: FontWeight.w700,
                                //     color: Colors.black87,
                                //     fontFamily: 'Changa',
                                //   ),
                                // ),
                              ),
                            ),

                          ],
                        ),
                      ),
                      SizedBox(width: 50,),
                      Container(
                        width:90,
                        child:Text('السعر بالدولار', style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                          fontFamily: 'Changa',
                        ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 35,),
                Container(
                  width:280,
                  height: 70,
                  margin: EdgeInsets.only(right:20),
                  child: TextFormField(
                    cursorColor:Colors.grey[600],
                    textAlign: TextAlign.right,
                    //controller: text_post,
                    maxLines: 20,
                    controller: description,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14.0,
                      fontFamily: 'Changa',
                      fontWeight: FontWeight.bold,
                    ),
                    //o: Desc(),
                    decoration: InputDecoration(
                      // filled:true,
                      // fillColor:Colors.grey[100],
                      hoverColor:Colors.black54,
                      contentPadding: EdgeInsets.all(1.0),
                      enabledBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(7.0),
                        borderSide:  BorderSide(color:Colors.white),

                      ),
                      focusedBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(7.0),
                        borderSide:  BorderSide(color:Colors.white),

                      ),
                      hintText: 'إضافة ملاحظة إذا أردت ',
                      focusColor:Colors.black54,
                      hintStyle: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'Changa',
                        color: Colors.black54,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
                Container(
                  width: 400,
                  child:Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                            margin: EdgeInsets.only(left:20,right:25),
                            child:Text('إلغاء',
                              style: TextStyle(
                                fontFamily: 'Changa',
                                color:Y,
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                        ),
                      ),
                      GestureDetector(
                        onTap: ()async{
                          await price();
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => taasser(name: widget.name,phone: widget.workerphone,Information:widget.Information,Experiance:widget.Experiance,Work:widget.work,namelast:widget.namelast,image:widget.image,token:widget.tokenworker,namefirst:widget.namefirst)));
                        },
                        child: Container(
                            margin: EdgeInsets.only(right: 50),
                            child:Text('حسنا',
                              style: TextStyle(
                                fontFamily: 'Changa',
                                color: Y,
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                        ),
                      ),
                    ],
                  ),),
              ],
            );
          },
        );
      },
    );
  }
  Future<void> price() async {
    int i = 0;
    // if(description.text.isEmpty){
    //   description.text='no';
    // }
    var url ='http://'+IP4+'/testlocalhost/accepttaseer.php';
    var ressponse = await http.post(url, body: {
      "id": widget.id,
      "price":count.text,
      "note":description.text,
    });
  }
  _showDialog() async{
    await showDialog<String>(
      context: context,
      builder: (BuildContext context){
        return new CupertinoAlertDialog(
          title: new Text('Please select'),
          actions: <Widget>[
            new CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: (){Navigator.of(context).pop('Cancel');},
              child: new Text('Cancel'),
            ),
            new CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: (){Navigator.of(context).pop('Accept');},
              child: new Text('Accept'),
            ),
          ],
          content: new SingleChildScrollView(
            child: new Material(
              child: new MyDialogContent(countries: countries),
            ),
          ),
        );
      },
      barrierDismissible: false,
    );
  }
  List<String> countries = <String>['Belgium','France','Italy','Germany','Spain','Portugal'];


}