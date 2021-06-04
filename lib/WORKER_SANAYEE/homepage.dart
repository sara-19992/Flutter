import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import "dart:io";
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import '../database.dart';
import 'Profile.dart';
import 'homepage.dart';
import 'menue_Page.dart';
import 'odersperson_day.dart';
import 'orders_workers.dart';
import 'package:flutterphone/Chatworker/chatListworker.dart';
import 'package:flutterphone/Chatworker/Conversation.dart';

String IP4="192.168.1.8:8080";
bool showmap=true;
String  name="";
String  phone="";
String  image="";
String  Work="";
String  Experiance="";
String  Information="";
String  token="";
String namefirst="";
String namelast="";
String lat="";
String lng="";

// var url = "http://maps.google.com/mapfiles/ms/icons/";
// url + = "blue";
int count =0;
List<dynamic>Worker;
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}


class orderpperson_map extends StatefulWidget {
  final work;
  final name_Me;
  final namefirst_Me;
  final nameLast_Me;
  final phone_Me;
  final image_Me;
  final token_Me;
  final country;
  final Information;
  final Experiance;
  final lat;
  final lng;
  final int countorder;
  orderpperson_map({this.countorder,this.Information,this.Experiance,this.lat,this.lng,this.country,this.token_Me,this.image_Me,this.namefirst_Me,this.nameLast_Me,this.phone_Me,this.work,this.name_Me});
  // final location;
  //   final work;
  //  final name_Me;
  //MyApp1({this.location,this.work,this.name_Me});
  _mState createState() => _mState();
}

class _mState extends State<orderpperson_map> {

  getChat(){
    print(widget.name_Me);
    databaseMethods.getChatsMe(widget.name_Me).then((val){
      setState(() {
        print(val.toString());
        chatsRoom=val;
      });
    });
  }
  bool rt=false;
  Future getWorker() async {
    var url = 'http://' + IP4 + '/testlocalhost/getworker.php';
    var ressponse = await http.post(url, body: {
      "name": widget.name_Me,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  void initState() {
    super.initState();
    getChat();

  }
  today() async {
    DateTime date=DateTime.now();
    var formattedDate = DateFormat('yyyy-MM-dd').format(date);
    var url = 'http://' + IP4 + '/testlocalhost/userlocation.php';
    // for(int i=0;i<list_.length;i++){
    var ressponse = await http.post(url, body: {
      //"phone":list_ [i],
      "phoneworker": widget.phone_Me,
      "date":formattedDate,

    });
    return json.decode(ressponse.body);
  }
  todaywar() async {
    DateTime date=DateTime.now();
    var formattedDate = DateFormat('yyyy-MM-dd').format(date);
    var url = 'http://' + IP4 + '/testlocalhost/todaywarshat.php';
    // for(int i=0;i<list_.length;i++){
    var ressponse = await http.post(url, body: {
      //"phone":list_ [i],
      "phoneworker": widget.phone_Me,
      "date":formattedDate,

    });
    return json.decode(ressponse.body);
  }
  int _selectedItem=0;
  DatabaseMethods databaseMethods=new DatabaseMethods();
  Stream chatsRoom;
  int length=5;
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return  Directionality( textDirection: ui.TextDirection.rtl,
      child:Scaffold(
        key: _scaffoldKey,
        // bottomNavigationBar:Container(
        //   decoration: BoxDecoration(color: Colors.white, boxShadow: [
        //     BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        //   ]),
        //   child: SafeArea(
        //     child: Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
        //       child: GNav(
        //           rippleColor: Colors.grey[300],
        //           hoverColor: Colors.grey[100],
        //           gap: 8,
        //           activeColor: Colors.black,
        //           iconSize: 24,
        //           padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        //           duration: Duration(milliseconds: 400),
        //           tabBackgroundColor: Colors.grey[100],
        //           tabs: [
        //             GButton(
        //               icon: Icons.home,
        //               text: 'الرئيسية',
        //               textStyle:TextStyle(
        //                 fontFamily: 'Changa',
        //                 color: Colors.black,
        //                 fontSize: 14.5,
        //                 fontWeight: FontWeight.bold,
        //               ),
        //             ),
        //             GButton(
        //               onPressed: (){
        //               },
        //               icon: Icons.calendar_today,
        //               text: 'طلباتي',
        //               textStyle:TextStyle(
        //                 fontFamily: 'Changa',
        //                 color: Colors.black,
        //                 fontSize: 14.5,
        //                 fontWeight: FontWeight.bold,
        //               ),
        //             ),
        //             GButton(
        //               onPressed: (){
        //
        //               },
        //               icon: Icons.mark_chat_unread,
        //               text: 'شات',
        //               textStyle:TextStyle(
        //                 fontFamily: 'Changa',
        //                 color: Colors.black,
        //                 fontSize: 14.5,
        //                 fontWeight: FontWeight.bold,
        //               ),
        //             ),
        //             GButton(
        //               icon: Icons.person,
        //               text: 'حسابي',
        //               textStyle:TextStyle(
        //                 fontFamily: 'Changa',
        //                 color: Colors.black,
        //                 fontSize: 14.5,
        //                 fontWeight: FontWeight.bold,
        //               ),
        //             ),
        //             GButton(
        //               icon: Icons.menu,
        //               text: 'القائمة',
        //               textStyle:TextStyle(
        //                 fontFamily: 'Changa',
        //                 color: Colors.black,
        //                 fontSize: 14.5,
        //                 fontWeight: FontWeight.bold,
        //               ),
        //             ),
        //           ],
        //           selectedIndex: _selectedIndex,
        //           onTabChange: (index) {
        //             setState(() {
        //               _selectedIndex = index;
        //               // if(index==0){
        //               //   Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Home_Page(name: widget.name_Me)));
        //               // }
        //
        //               if(index==1){
        //                 Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => order_worker(lat:lat,lng:lng,Information:Information,Experiance:Experiance,Work:Work,namelast:namelast,name:widget.name_Me,phone:phone,image:image,token:token,namefirst:namefirst,)));
        //               }
        //               if(index==2){
        //                 Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Chat(name_Me:name,chatsRoomList: chatsRoom,Information:Information,Experiance:Experiance,Work:Work,namelast:namelast,phone:phone,image:image,token:token,namefirst:namefirst,)));
        //               }
        //               if(index==3){
        //                 Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => PROFILE(name:name,phone:phone,)));
        //               }
        //               if(index==4){
        //                 DateTime date=DateTime.now();
        //                 Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MenuePage(Information:Information,Experiance:Experiance,Work:Work,namelast:namelast,name:name,phone:phone,image:image,token:token,namefirst:namefirst,)));
        //               }
        //             });
        //           }
        //       ),
        //     ),
        //   ),),
        bottomNavigationBar: CustomBottomNavigationBar(
          iconList: [
            Icons.home,
            Icons.calendar_today,
            Icons.mark_chat_unread,
            Icons.person,
            Icons.menu,
          ],
          onChange: (val) {
            setState(() {
              _selectedItem = val;
            });
            if(_selectedItem==1){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => order_worker(lat:lat,lng:lng,Information:Information,Experiance:Experiance,Work:Work,namelast:namelast,name:widget.name_Me,phone:phone,image:image,token:token,namefirst:namefirst,)));
            }
            if(_selectedItem==2){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Chat(lat:lat,lng:lng,name_Me:name,chatsRoomList: chatsRoom,Information:Information,Experiance:Experiance,Work:Work,namelast:namelast,phone:phone,image:image,token:token,namefirst:namefirst,)));
            }
            if(_selectedItem==3){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => PROFILE(lat:lat,lng:lng,name:name,phone:phone,)));
            }
            if(_selectedItem==4){
              DateTime date=DateTime.now();
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MenuePage(lat:lat,lng:lng,Information:Information,Experiance:Experiance,Work:Work,namelast:namelast,name:name,phone:phone,image:image,token:token,namefirst:namefirst,)));
            }
          },
          defaultSelectedIndex: _selectedItem,
        ),
        backgroundColor: Colors.white,
        body:Column(
          children: [
            Container(
              height: 0,
              // color:  Color(0xFFF3D657),
              margin: EdgeInsets.only(top:0),
              decoration: BoxDecoration(
              ),
              child:FutureBuilder(
                future: getWorker(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if(snapshot.hasData){
                    return ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        name = snapshot.data[index]['name'];
                        namefirst = snapshot.data[index]['namefirst'];
                        namelast = snapshot.data[index]['namelast'];
                        phone = snapshot.data[index]['phone'];
                        image = snapshot.data[index]['image'];
                        Work = snapshot.data[index]['Work'];
                        Information = snapshot.data[index]['Information'];
                        Experiance = snapshot.data[index]['Experiance'];
                        token = snapshot.data[index]['token'];
                        lat=snapshot.data[index]['lat'];
                        lng=snapshot.data[index]['lng'];
                        return Container(height: 0.0,);
                      },
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
            Container(
              height: 737,
              margin: EdgeInsets.only(top: 0,),
              decoration: BoxDecoration(
              ),
              child: FutureBuilder(
                future: todaywar(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                      print(snapshot.data.length);
                      length=snapshot.data.length;
                      return w(length:length,phone_Me: phone,name_Me:widget.name_Me,);
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),),);
  }
}
class w extends StatefulWidget {
  List<dynamic>Location;
  final work;
  final name_Me;
  final namefirst_Me;
  final nameLast_Me;
  final phone_Me;
  final image_Me;
  final token_Me;
  final lat;
  final lng;
  final country;
  final int length;
  w({this.length,this.lat,this.lng,this.country,this.token_Me,this.image_Me,this.namefirst_Me,this.nameLast_Me,this.phone_Me,this.work,this.name_Me,this.Location});
  //w({this.Location,this.work});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<w> {
  PermissionStatus _permissionGranted;
  bool serviceEnabled;
  int i = 0;
  var List_Worker = [];
  var list_ = [];
  var list_distance = [];
  var List_button=[];
  List<Marker> markers = [];
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  get url => null;

  @override
  void initState() {
    super.initState();
  }

  Set<Circle> circles;
  bool S = false;
  today() async {
    DateTime date=DateTime.now();
    var formattedDate = DateFormat('yyyy-MM-dd').format(date);
    var url = 'http://' + IP4 + '/testlocalhost/userlocation.php';
    // for(int i=0;i<list_.length;i++){
    var ressponse = await http.post(url, body: {
      //"phone":list_ [i],
      "phoneworker": widget.phone_Me,
      "date":formattedDate,

    });
    return json.decode(ressponse.body);
  }
  todaywar() async {
    DateTime date=DateTime.now();
    var formattedDate = DateFormat('yyyy-MM-dd').format(date);
    var url = 'http://' + IP4 + '/testlocalhost/todaywarshat.php';
    // for(int i=0;i<list_.length;i++){
    var ressponse = await http.post(url, body: {
      //"phone":list_ [i],
      "phoneworker": widget.phone_Me,
      "date":formattedDate,

    });
    return json.decode(ressponse.body);
  }
  finished_order(String id) async {
    print(id);
    DateTime date=DateTime.now();
    var formattedDate = DateFormat('yyyy-MM-dd').format(date);
    var formattedTime = DateFormat('HH:mm:ss').format(date);
    var url = 'http://' + IP4 + '/testlocalhost/finishedorder.php';
    var ressponse = await http.post(url, body: {
      //"phone":list_ [i],
      "id":id,
      "datefinished":formattedDate,
      "timefinished":formattedTime,

    });
    return json.decode(ressponse.body);
  }
  delete_order(String id) async {
    DateTime date=DateTime.now();
    var formattedDate = DateFormat('yyyy-MM-dd').format(date);
    var formattedTime = DateFormat('HH:mm:ss').format(date);
    var url = 'http://' + IP4 + '/testlocalhost/delete_accept_order.php';
    var ressponse = await http.post(url, body: {
      "id": id,
      "datecancel":formattedDate,
      "timecancel":formattedTime,
      "who":'worker',
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }

  Container order_user(int index,String namefirst,String namelast,String image,String timestart,String timeend,String Am_Pm,String phone,String id){
    return Container(
      height: 85,
      transform: Matrix4.translationValues(0.0, -30.0, 0.0),
      margin: EdgeInsets.only(bottom:20),
      decoration: BoxDecoration(
        color:Colors.grey[50],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child:Row(
              children: [
                SizedBox(width: 10,),
                Container(
                  // print(_image[index].id+"");
                  width: 55,
                  height: 55,
                  transform: Matrix4.translationValues(0.0, -0.0, 0.0),
                  margin: EdgeInsets.only(right: 5,top:2),
                  decoration: BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(image: NetworkImage('http://'+IP4+'/testlocalhost/upload/'+image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: 240,
                  height: 80,
                  margin: EdgeInsets.only(right:0,top:0),
                  child:  Column(
                    children: [
                      SizedBox(height:5,),
                      Container(
                        width: 200,
                        height: 30,
                        //color: Colors.green,
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(top: 5,bottom: 0,left: 50,right:10),
                        child: Text(namefirst + " " + namelast,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14.0,
                            fontFamily: 'Changa',
                            fontWeight: FontWeight.bold,),
                        ),),
                      SizedBox(height:5,),
                      Container(
                        height:30,
                        child:Row(
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width:10,),
                                    Text("الوقت   ", style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87,
                                      fontFamily: 'Changa',
                                    ),),
                                    Text(timestart +" - " +timeend, style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black54,
                                      fontFamily: 'Changa',
                                    ),),
                                    Text(" "),
                                    Text(Am_Pm=="am"?"صباحا":"مساء", style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black54,
                                      fontFamily: 'Changa',
                                    ),),
                                    SizedBox(width: 5,),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 30,),
                Container(
                  width: 55,
                  // margin: EdgeInsets.only(top:10),
                  transform: Matrix4.translationValues(0.0,0.0, 0.0),
                  child: FlatButton(
                    onPressed: () {
                      String phonen=phone.substring(3);
                      UrlLauncher.launch("tel://"+phonen);
                    },
                    child: new Icon(
                      Icons.phone,
                      color: Colors.white,
                      size: 23.0,
                    ),
                    shape: new CircleBorder(),
                    color: Y,
                  ),
                ),

                SizedBox(width:30,),
                GestureDetector(
                  onTap: () async{
                    await finished_order(id);
                    widget.Location.removeAt(index);
                    setState(() {

                    });
                  },
                 child:Container(
                      height: 50,
                      width: 104,
                      transform: Matrix4.translationValues(0.0, 0.0, 0.0),
                      child:FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.transparent)
                          ),
                          // padding: EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                          color:Colors.green,
                          onPressed: (){
                            _dialogCall(id);
                          },
                          child:Row(
                            children: [
                              Text('انتهاء الطلب',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: 'Changa',
                                  //fontStyle: FontStyle.italic,
                                ),),
                              // SizedBox(width:5,),
                              // Icon(Icons.check,color:Colors.white,size:24,),
                            ],
                          )
                      ),
                    ),
                  ),
                SizedBox(width:15,),
              ],
            ),),
        ],),
    );
  }
  Future<void> _dialogCall(String id) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Directionality(textDirection: ui.TextDirection.rtl,
              child:finishorder(id:id,name: widget.name_Me,phone: widget.phone_Me,));
        });
  }

  Container order_warshat(int index,String namefirst,String namelast,String image,String type,String phone,String id){
    return Container(
      height: 85,
      transform: Matrix4.translationValues(0.0, -50.0, 0.0),
      margin: EdgeInsets.only(bottom:20),
      decoration: BoxDecoration(
        color:Colors.grey[50],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child:Row(
              children: [
                SizedBox(width: 10,),
                Container(
                  // print(_image[index].id+"");
                  width: 55,
                  height: 55,
                  transform: Matrix4.translationValues(0.0, -0.0, 0.0),
                  margin: EdgeInsets.only(right: 5,top:2),
                  decoration: BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(image: NetworkImage('http://'+IP4+'/testlocalhost/upload/'+image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: 240,
                  height: 80,
                  margin: EdgeInsets.only(right:0,top:0),
                  child:  Column(
                    children: [
                      SizedBox(height:5,),
                      Container(
                        width: 200,
                        height: 30,
                        //color: Colors.green,
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(top: 5,bottom: 0,left: 50,right:10),
                        child: Text(namefirst + " " + namelast,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14.0,
                            fontFamily: 'Changa',
                            fontWeight: FontWeight.bold,),
                        ),),
                      SizedBox(height:5,),
                      Container(
                        height:30,
                        child:Row(
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width:10,),
                                    Text("نوع الورشة   ", style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87,
                                      fontFamily: 'Changa',
                                    ),),
                                    Text(type,style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black54,
                                      fontFamily: 'Changa',
                                    ),),
                                    SizedBox(width: 5,),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 30,),
                Container(
                  width: 55,
                  // margin: EdgeInsets.only(top:10),
                  transform: Matrix4.translationValues(0.0,0.0, 0.0),
                  child: FlatButton(
                    onPressed: () {
                      String phonen=phone.substring(3);
                      UrlLauncher.launch("tel://"+phonen);
                    },
                    child: new Icon(
                      Icons.phone,
                      color: Colors.white,
                      size: 23.0,
                    ),
                    shape: new CircleBorder(),
                    color: Y,
                  ),
                ),

                SizedBox(width:30,),
                GestureDetector(
                  onTap: () async{
                    await finished_order(id);
                    widget.Location.removeAt(index);
                    setState(() {

                    });
                  },
                  child:Container(
                    height: 50,
                    width: 104,
                    transform: Matrix4.translationValues(0.0, 0.0, 0.0),
                    child:FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.transparent)
                        ),
                        // padding: EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                        color:Colors.green,
                        onPressed: (){
                        },
                        child:Row(
                          children: [
                            Text('تم الانتهاء',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'Changa',
                                //fontStyle: FontStyle.italic,
                              ),),
                          ],
                        )
                    ),
                  ),
                ),
                SizedBox(width:15,),
              ],
            ),),
        ],),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
     child:Container(
      height: 800,
      width: 500,
       color: Colors.white,
         transform: Matrix4.translationValues(0.0, -40.0, 0.0),
       child:Column(
         children: [
           widget.length!=0?Container(
             height:800,
             child:Column(
               children: [
                 SizedBox(height:40,),
                 Container(
                   height: 125,
                   width: 500,
                   // transform: Matrix4.translationValues(0.0, -42.0, 0.0),
                   decoration: BoxDecoration(
                     color: Colors.black87.withOpacity(0.9),
                     image: new DecorationImage(
                       fit: BoxFit.cover,
                       colorFilter:
                       ColorFilter.mode(Colors.black87.withOpacity(0.4),
                           BlendMode.dstATop),
                       image: new AssetImage('assets/work/cvtop.jpg',),
                     ),),),
                 Container(
                   height: 50,
                   //width: 50,
                   //alignment: Alignment.topLeft,
                  // margin: EdgeInsets.only(right: 320,top:0),
                   margin: EdgeInsets.only(top:5,left:0,right:345),
                   padding: EdgeInsets.symmetric(horizontal: 3),
                   child: GestureDetector(
                     onTap: () {
                       Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Home_Page(name: widget.name_Me,phone:widget.phone_Me)));
                       // UrlLauncher.launch("tel://0595320479");
                     },
                     child: Row(
                       children: [
                         Image.asset('assets/work/map.png',width:40,height: 40,fit:BoxFit.contain,),
                       ],
                     ),
                   ),
                 ),
                 Container(
                   height:40,
                   width: 200,
                   margin: EdgeInsets.only(top:15,right:15,left:180),
                   alignment: Alignment.topRight,
                   child:Text('ورشات اليوم ',
                     style: TextStyle(
                       fontSize: 15,
                       fontWeight: FontWeight.w400,
                       color: Colors.black87,
                       fontFamily: 'Changa',
                       //fontStyle: FontStyle.italic,
                     ),),
                 ),
                 Container(
                   height: 175,
                   margin: EdgeInsets.only(top: 0,),
                   decoration: BoxDecoration(
                   ),
                   child: FutureBuilder(
                     future: todaywar(),
                     builder: (BuildContext context, AsyncSnapshot snapshot) {
                       if (snapshot.hasData) {
                         return ListView.builder(
                           itemCount: snapshot.data.length,
                           itemBuilder: (context, index) {
                             print("Fromdate");
                             print(snapshot.data[index]['Fromdate']);
                             print(snapshot.data[index]['Todate']);
                             print(snapshot.data[index]['id']);
                             DateTime date = DateTime.now();
                             DateTime date1 =  DateTime.parse(snapshot.data[index]['Fromdate']);
                             DateTime date2 = DateTime.parse(snapshot.data[index]['Todate']);
                             if(date.isBefore(date2) && date.isAfter(date1)){
                               return order_warshat(index,snapshot.data[index]['namefirst'],snapshot.data[index]['namelast'],snapshot.data[index]['image'],snapshot.data[index]['type'],snapshot.data[index]['phone'],snapshot.data[index]['id']);
                             }
                             else{
                               return Container(height: 0.0,);
                             }},);
                       }
                       return Center(child: CircularProgressIndicator());
                     },
                   ),
                 ),
                 Container(
                   height:40,
                   width: 200,
                   margin: EdgeInsets.only(top:15,right:15,left:180),
                   alignment: Alignment.topRight,
                       child:Text('طقات اليوم ',
                         style: TextStyle(
                           fontSize: 15,
                           fontWeight: FontWeight.w400,
                           color: Colors.black87,
                           fontFamily: 'Changa',
                           //fontStyle: FontStyle.italic,
                         ),),
                 ),
                  Container(
                    height: 200,
                    transform: Matrix4.translationValues(0.0,-20.0, 0.0),
                   decoration: BoxDecoration(
                   ),
                   child: FutureBuilder(
                     future: today(),
                     builder: (BuildContext context, AsyncSnapshot snapshot) {
                       if (snapshot.hasData) {
                         return ListView.builder(
                           itemCount: snapshot.data.length,
                           itemBuilder: (context, index) {
                             print(snapshot.data[index]['id']);
                             return order_user(index,snapshot.data[index]['namefirst'],snapshot.data[index]['namelast'],snapshot.data[index]['image'],snapshot.data[index]['timestart'],snapshot.data[index]['timeend'],snapshot.data[index]['Am_Pm'],snapshot.data[index]['phone'],snapshot.data[index]['id']);
                           },);
                       }
                       return Center(child: CircularProgressIndicator());
                     },
                   ),
                 ),
               ],
             ),
           ):
           Container(
             margin: EdgeInsets.only(top:160),
             transform: Matrix4.translationValues(0.0, -0.0, 0.0),
             child:Center(
               child:Column(
                 children: [
                   SizedBox(height:170,),
                   Image.asset('assets/work/dayoff.png',width:150,height:150,),
                   Container(
                     width:400,
                     alignment: Alignment.center,
                     transform: Matrix4.translationValues(0.0, -15.0, 0.0),
                     margin: EdgeInsets.only(top:0),
                     child: Text('لا توجد طلبات يوم إجازة لك',
                       style: TextStyle(
                         color: Colors.black87,
                         fontSize: 15.0,
                         fontFamily: 'Changa',
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                   ),
                 ],
               ),
             ),
           ),
         ],
       )));

    //  child:FutureBuilder(
    //    future: checkLocationServicesInDevice(),
    //      builder: (BuildContext context, AsyncSnapshot <double>snapshot) {
    //        if (snapshot.hasData) {
    //          print("================================================111111");
    //              return Container(child:Text(snapshot.data.toString()),);
    //        }
    //        return Center(child: CircularProgressIndicator());
    //
    //      }
    //
    // ),
  }

  // @override
}
//}
class CustomBottomNavigationBar extends StatefulWidget {
  final int defaultSelectedIndex;
  final Function(int) onChange;
  final List<IconData> iconList;

  CustomBottomNavigationBar(
      {this.defaultSelectedIndex = 0,
        @required this.iconList,
        @required this.onChange});

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;
  List<IconData> _iconList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _selectedIndex = widget.defaultSelectedIndex;
    _iconList = widget.iconList;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _navBarItemList = [];

    for (var i = 0; i < _iconList.length; i++) {
      _navBarItemList.add(buildNavBarItem(_iconList[i], i));
    }

    return Row(
      children: _navBarItemList,
    );
  }

  Widget buildNavBarItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        widget.onChange(index);
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        height: 60,

        width: MediaQuery.of(context).size.width / _iconList.length,
        decoration: index == _selectedIndex
            ? BoxDecoration(
          color: Colors.white,
          // color: index == _selectedItemIndex ? Colors.green : Colors.white,
        )
            : BoxDecoration(
          color: Colors.white,
        ),
        child: Icon(
          icon,
          color: index == _selectedIndex ? Y : Colors.black,
        ),
      ),
    );
  }



}



class finishorder extends StatefulWidget {
  @override
  final id;
  final name;
  final phone;
  finishorder({this.name,this.id,this.phone});
  _finishorder createState() => new _finishorder();

}
class _finishorder extends State<finishorder> {
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
                  margin: EdgeInsets.only(left:110,top:10),
                  child: Text('هل تم إنهاء هذا الطلب ؟',
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
                      onTap: ()async{
                        await delete(widget.id);
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => orderpperson_map(name_Me:widget.name,phone_Me:widget.phone,)));
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
  Future<void> delete(String id) async {
    int i = 0;
    var url ='http://'+IP4+'/testlocalhost/finished.php';
    var ressponse = await http.post(url, body: {
      "id": id,
    });
  }
}
