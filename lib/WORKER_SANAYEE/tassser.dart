import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutterphone/constants.dart';
import '../constants.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'State_warshe_accept.dart';
import 'orders_workers.dart';

String  name="";
String  phone="";
String  image="";
String  Work="";
String  Experiance="";
String  Information="";
String  token="";
String IP4="192.168.1.8:8080";
bool press=true;
double hight=150;
class taasser extends StatefulWidget {
  final name;
  final phone;
  final  image;
  final  Work;
  final  Experiance;
  final  Information;
  final  token;
  final namefirst;
  final namelast;
  final lat;
  final lng;
  taasser({this.image,this.lng,this.lat,this.namelast,this.namefirst,this.token,this.Experiance,this.Information,this.Work,this.phone,this.name});

  @override
  _taasser createState() => _taasser();
}

class _taasser extends State<taasser> {
  @override
  void initState() {
    super.initState();
    press=true;
    setState(() {});
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future getrequest()async{
    var url='http://'+IP4+'/testlocalhost/gettasserrequest.php';
    var ressponse=await http.post(url,body: {
      "phoneworker": widget.phone,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  Widget build(BuildContext context) {
    print("ddddddddddddddddddddd"); print(widget.phone); print(widget.name);
    return Directionality(textDirection: ui.TextDirection.rtl,
      child: Scaffold(
        backgroundColor:Colors.white,
        key: _scaffoldKey,
        body:Form(
          child:Stack(
            children: [
              Container(
                width: 500,
                height: 110,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top:60,right: 10),
                      child:GestureDetector(
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => order_worker(lat:widget.lat,lng:widget.lng,Information:widget.Information,Experiance:widget.Experiance,Work:widget.Work,namelast:widget.namelast,name:widget.name,phone:widget.phone,image:widget.image,token:widget.token,namefirst:widget.namefirst)));},

                        child:Icon(Icons.arrow_back,color: Colors.black,),
                      ),
                    ),
                    // Container(
                    //   margin: EdgeInsets.only(top:60,right: 11),
                    //   child:Text('ورشاتي',
                    //     style: TextStyle(
                    //       fontSize: 18,
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.white,
                    //       fontFamily: 'Changa',
                    //       //fontStyle: FontStyle.italic,
                    //     ),),
                    // ),

                  ],
                ),
              ),
              // Container(
              //     margin: EdgeInsets.only(top:70,right: 10),
              //     child: GestureDetector(
              //       onTap: (){
              //         Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => order_worker(lat:widget.lat,lng:widget.lng,Information:widget.Information,Experiance:widget.Experiance,Work:widget.Work,namelast:widget.namelast,name:widget.name,phone:widget.phone,image:widget.image,token:widget.token,namefirst:widget.namefirst)));},
              //
              //       child:Icon(Icons.arrow_back,color: Colors.grey[600],),
              //     )
              // ),
              // Container(
              //     height: 50,
              //     color: Colors.white,
              //     margin: EdgeInsets.only(top:100,right:0),
              //     alignment: Alignment.center,
              //     // transform: Matrix4.translationValues(0, -120.0, 0),
              //     child:Text('ورشاتي',
              //       style: TextStyle(
              //         fontSize: 30,
              //         fontWeight: FontWeight.w400,
              //         color: Colors.black,
              //         fontFamily: 'vibes',
              //         //fontStyle: FontStyle.italic,
              //       ),)
              // ),
              // Container(
              //   color: Colors.white,
              //   height: 647.5,
              //   margin: EdgeInsets.only(top:100),
              //   child: FutureBuilder(
              //     future: getrequest(),
              //     builder: (BuildContext context, AsyncSnapshot snapshot) {
              //        if (snapshot.hasData) {
              //         return ListView.builder(
              //           itemCount: snapshot.data.length,
              //           itemBuilder: (context, index) {
              //             print(snapshot.data[index]['workerphone']);
              //             // return Container(height: 200,);
              //            return view (image:snapshot.data[index]['image'],name:snapshot.data[index]['name'],Information:widget.Information,Experiance:widget.Information,tokenworker:widget.token,work:widget.Work,imageworker:widget.image,namelastworker:widget.namelast,namefirstworker:widget.namefirst,id:snapshot.data[index]['id'],describes:snapshot.data[index]['descr'],nameofwork :widget.name,workerphone : widget.phone, namefirst: snapshot.data[index]['namefirst'], namelast: snapshot.data[index]['namelast'], phoneuser: snapshot.data[index]['phoneuser']);
              //
              //           },
              //         );
              //        }else{
              //          return Container(
              //            margin: EdgeInsets.only(top:200),
              //            height: 100,
              //            color: Colors.red,
              //            child: Text('ASDASDASDASDASD'),
              //          );
              //        }
              //       // return Container();
              //     },
              //   ),
              // ),
              //this
              Container(
                height: 500,
                margin:EdgeInsets.only(top:100),
                child: Container(
                  child:FutureBuilder(
                    future: getrequest(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if(snapshot.hasData){
                        print(snapshot.data.length);
                        if(snapshot.data.length==0) {
                          print(widget.name);
                          print('EMPTEY');
                          return Center(child: Container(
                            height: 500,
                            margin:EdgeInsets.only(top:2000),
                          ));
                          // return Empty();
                        }
                        else{
                          print(snapshot.data.length);
                          print('NOT EMPTEY');
                          return ListView.builder(
                            itemCount:snapshot.data.length,
                            itemBuilder: (context, index) {
                              print(snapshot.data.length);
                              print(widget.name);
                              print('ASDASDASD');
                              return view (image:snapshot.data[index]['image'],name:snapshot.data[index]['name'],Information:widget.Information,Experiance:widget.Information,tokenworker:widget.token,work:widget.Work,imageworker:widget.image,namelastworker:widget.namelast,namefirstworker:widget.namefirst,id:snapshot.data[index]['id'],describes:snapshot.data[index]['descr'],nameofwork :widget.name,workerphone : widget.phone, namefirst: snapshot.data[index]['namefirst'], namelast: snapshot.data[index]['namelast'], phoneuser: snapshot.data[index]['phoneuser']);
                            },
                          );
                        }
                      }
                      return Center(child: Container(
                        height: 500,
                        margin:EdgeInsets.only(top:2000),
                      ));
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
              // Container(
              //   height: 100,
              //   margin: EdgeInsets.only(top: 260,right: 150),
              //   color: Colors.yellowAccent,
              //   child:FutureBuilder(
              //     future: getWorker(),
              //     builder: (BuildContext context, AsyncSnapshot snapshot) {
              //       if(snapshot.hasData){
              //         return ListView.builder(
              //             itemCount:1,
              //             itemBuilder: (context, index) {
              //
              //               return Center(child: Text('YAHHHHHHHHHHHHHHHHH'));
              //             }
              //         );
              //       }
              //       return Center(child: Text('NO'));
              //     },
              //   ),
              // ),

            ],
          ) ,

        ),),);
  }

  Future getlongtimeorder() async {

    var url = 'http://'+IP4+'/testlocalhost/seereservations.php';
    print("ssssssssssssssssssssssssssssssssssssssssssssssssssssssssss"+widget.phone);
    var ressponse = await http.post(url, body: {
      "phone": widget.phone,

    });
    return json.decode(ressponse.body);
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
       margin: EdgeInsets.only(top:5,bottom: 20),
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
                        width:260,
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
class MyDialogContent extends StatefulWidget {
  MyDialogContent({
    Key key,
    this.countries,
  }): super(key: key);

  final List<String> countries;

  @override
  _MyDialogContentState createState() => new _MyDialogContentState();
}

class _MyDialogContentState extends State<MyDialogContent> {
  int _selectedIndex = 0;

  @override
  void initState(){
    super.initState();
  }

  _getContent(){
    if (widget.countries.length == 0){
      return new Container();
    }

    return new Column(
        children: new List<RadioListTile<int>>.generate(
            widget.countries.length,
                (int index){
              return new RadioListTile<int>(
                value: index,
                groupValue: _selectedIndex,
                title: new Text(widget.countries[index]),
                onChanged: (int value) {
                  setState((){
                    _selectedIndex = value;
                  });
                },
              );
            }
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return _getContent();
  }
}
