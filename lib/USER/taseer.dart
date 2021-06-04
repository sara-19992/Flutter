import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterphone/ChatUuser/chatListUser.dart';
import 'package:flutterphone/USER/pricetaaseer.dart';
import 'package:flutterphone/USER/user_Profile.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'delete_userstate2.dart';
import 'warshat_current_state.dart';
import 'warshat_finished_state.dart';
import 'warshat_wait_state.dart';
import 'package:flutterphone/constants.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../buttom_bar.dart';
import '../constants.dart';
import '../database.dart';
import 'Rate_Me.dart';
import 'current_user_states.dart';
import 'daycancel_user_state.dart';
import 'delete_user_state.dart';
import 'favarate.dart';
import 'finish_user_stste.dart';
import 'menue_Page.dart';
import 'not_conferm_user_state.dart';

String  name_Me="";
String  name="";
String  phone="";
String  image="";
String namefirst="";
String namelast="";
String Country="";
String  token="";

String IP4="192.168.1.8:8080";

class user_taseer_order extends StatefulWidget {
  final phoneuser;
  final username;
  final country;
  final namelast;
  final namefirst;
  final token;
  final image;
  final index;
  List<dynamic>Lsist_Post;
  user_taseer_order({this.index,this.Lsist_Post,this.token,this.image,this.namefirst,this.namelast,this.country,this.username,this.phoneuser,});

  _user_taseer_order createState() => _user_taseer_order();
}
class  _user_taseer_order extends State<user_taseer_order> {
  // AnimationController _animationController;
  int _page = 0;
  final List1 = [];
  var ListDate1 = [];
  final List2 = [];
  var ListDate2 = [];
  var ListBlock=["8.00 - 9.00","9.00 - 10.00","","","",];
  var Listsearch=[];
  bool button1=false;
  bool button2=false;
  bool button3=false;
  bool button4=false;
  bool step3=false;

  Future getrequest()async{
    var url='http://'+IP4+'/testlocalhost/userrequesettaseer.php';
    var ressponse=await http.post(url,body: {
      "phoneuser": widget.phoneuser,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  Future getwarshate()async{
    var url='http://'+IP4+'/testlocalhost/user_current_warshat.php';
    var ressponse=await http.post(url,body: {
      "phone": widget.phoneuser,
    });
    print("PHONE"+widget.phoneuser);
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  Future getMyorder()async{
    var url='http://'+IP4+'/testlocalhost/user_current_order.php';
    var ressponse=await http.post(url,body: {
      "username": widget.username,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  Future getallorders()async{
    var url='http://'+IP4+'/testlocalhost/user_current_order_not_conferm.php';
    var ressponse=await http.post(url,body: {
      "username": widget.username,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  Future get_delete_current()async{
    var url='http://'+IP4+'/testlocalhost/user_current_delete_order.php';
    var ressponse=await http.post(url,body: {
      "username": widget.username,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  double roundDouble(double value, int places){
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }
  getChat(){
    databaseMethods.getChatsMe(widget.username).then((val){
      setState(() {
        print(val.toString());
        chatsRoom=val;
      });
    });
  }
  @override
  void initState() {
    super.initState();
    if(widget.index=='0')button2=true;
    if(widget.index=='1')button3=true;
    if(widget.index=='2')button4=true;
    getChat();
  }
  int _selectedItem = 1;
  PageController _pageController;
  DatabaseMethods databaseMethods=new DatabaseMethods();
  Stream chatsRoom;
  @override
  Widget build(BuildContext context) {
    print(Listsearch.toString());
    return Directionality(textDirection: ui.TextDirection.rtl,
      child:Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.white,
            // appBar: new AppBar(
            //   elevation: 0.0,
            //   backgroundColor: Y,
            //   leading:GestureDetector(
            //     onTap: (){
            //       Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => U_PROFILE(name_Me: widget.username,)));
            //     },
            //     child:Icon(Icons.arrow_back,color: Colors.white,),
            //   ),
            //   title: new Text('جميع طلباتي',
            //     style: TextStyle(
            //       fontSize: 16.0,
            //       fontWeight: FontWeight.bold,
            //       fontFamily: 'Changa',
            //       color: Colors.white,
            //     ),
            //   ),
            // ),
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
            //               icon: Icons.favorite_border,
            //               text: 'المفضلة',
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
            //               if(index==0){
            //                 Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => U_PROFILE(name_Me: widget.username,)));
            //               }
            //               if(index==1){
            //                 Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => user_reserve_order(username: widget.username,phoneuser: widget.phoneuser,namelast:widget.namelast,image:widget.image,token:widget.token,namefirst:widget.namefirst)));
            //               }
            //               if(index==2){
            //                 Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Chat(name_Me:widget.username,chatsRoomList: chatsRoom,phone:widget.phoneuser,namelast:widget.namelast,image:widget.image,token:widget.token,namefirst:widget.namefirst)));
            //               }
            //               if(index==3){
            //                 Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => favarate(username: widget.username,phoneuser: widget.phoneuser,namelast:widget.namelast,image:widget.image,token:widget.token,namefirst:widget.namefirst)));
            //               }
            //               if(index==4){
            //                 Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MenuePage(namelast:widget.namelast,name:widget.username,phone:widget.phoneuser,image:widget.image,token:widget.token,namefirst:widget.namefirst)));
            //               }
            //             });
            //           }
            //       ),
            //     ),
            //   ),),
            body: Form(
              // child:SingleChildScrollView(
              child: Stack(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 170,
                    width: 500,
                    decoration: BoxDecoration(
                      color: Colors.black87.withOpacity(0.9),
                      image: new DecorationImage(
                        fit: BoxFit.cover,
                        colorFilter:
                        ColorFilter.mode(Colors.black87.withOpacity(0.4),
                            BlendMode.dstATop),
                        image: new AssetImage('assets/work/cvtop.jpg',),
                      ),),
                    child: Container(
                      margin:EdgeInsets.only(top:109),
                      child:SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          // child:Row(
                          //   children: [
                          //     // GestureDetector(
                          //     //   child: Container(
                          //     //     alignment: Alignment.center,
                          //     //     margin: EdgeInsets.only(left: 10,right: 20),
                          //     //     height: 60,
                          //     //     width: 110,
                          //     //     decoration: BoxDecoration(
                          //     //       //color: Colors.white,
                          //     //       // border: Border.all(
                          //     //       //   color: Colors.white,
                          //     //       // ),
                          //     //       border:button1? Border(
                          //     //         bottom: BorderSide( //
                          //     //           color: Colors.black,
                          //     //           width: 3.0,
                          //     //         ),
                          //     //       ):Border(),
                          //     //       // borderRadius: BorderRadius.circular(10),
                          //     //       color: Colors.transparent,
                          //     //     ),
                          //     //     child: Text('ورشاتي',
                          //     //       style: TextStyle(
                          //     //         color: button1==true?Colors.black:Colors.white,
                          //     //         fontSize: 14,
                          //     //         fontFamily: 'Changa',
                          //     //         fontWeight: FontWeight.bold,),
                          //     //     ),
                          //     //   ),
                          //     //   onTap: (){
                          //     //     button1=true;
                          //     //     button2=false;
                          //     //     button3=false;
                          //     //     button4=false;
                          //     //     setState(() {
                          //     //
                          //     //     });
                          //     //   },
                          //     // ),
                          //     GestureDetector(
                          //       child: Container(
                          //
                          //         alignment: Alignment.center,
                          //         margin: EdgeInsets.only(left: 10,right: 10),
                          //         height: 60,
                          //         width: 110,
                          //         decoration: BoxDecoration(
                          //           //color: Colors.white,
                          //           // border: Border.all(
                          //           //   color: Colors.white,
                          //           // ),
                          //           border:button2? Border(
                          //             bottom: BorderSide( //
                          //               color: Y,
                          //               width: 3.0,
                          //             ),
                          //           ):Border(),
                          //           // borderRadius: BorderRadius.circular(10),
                          //           color: Colors.transparent,
                          //         ),
                          //         child: Text('ورشاتي',
                          //           style: TextStyle(
                          //             color: button2==true?Y:Colors.white,
                          //             fontSize: 14,
                          //             fontFamily: 'Changa',
                          //             fontWeight: FontWeight.bold,),
                          //         ),
                          //       ),
                          //       onTap: (){
                          //         button1=false;
                          //         button2=true;
                          //         button3=false;
                          //         button4=false;
                          //         setState(() {
                          //
                          //         });
                          //       },
                          //     ),
                          //     GestureDetector(
                          //       child: Container(
                          //
                          //         alignment: Alignment.center,
                          //         margin: EdgeInsets.only(left: 10,right: 15),
                          //         height: 60,
                          //         width: 110,
                          //         decoration: BoxDecoration(
                          //           //color: Colors.white,
                          //           // border: Border.all(
                          //           //   color: Colors.white,
                          //           // ),
                          //           border:button3? Border(
                          //             bottom: BorderSide( //
                          //               color: Y,
                          //               width: 3.0,
                          //             ),
                          //           ):Border(),
                          //           // borderRadius: BorderRadius.circular(10),
                          //           color: Colors.transparent,
                          //         ),
                          //         child: Text('طقاتي الحالية',
                          //           style: TextStyle(
                          //             color: button3==true?Y:Colors.white,
                          //             fontSize: 14,
                          //             fontFamily: 'Changa',
                          //             fontWeight: FontWeight.bold,),
                          //         ),
                          //       ),
                          //       onTap: (){
                          //         button1=false;
                          //         button2=false;
                          //         button3=true;
                          //         button4=false;
                          //         setState(() {
                          //
                          //         });
                          //       },
                          //     ),
                          //     GestureDetector(
                          //       child: Container(
                          //         alignment: Alignment.center,
                          //         margin: EdgeInsets.only(left: 10,right: 20),
                          //         height: 60,
                          //         width: 116,
                          //         decoration: BoxDecoration(
                          //           //color: Colors.white,
                          //           // border: Border.all(
                          //           //   color: Colors.white,
                          //           // ),
                          //           border:button4? Border(
                          //             bottom: BorderSide( //
                          //               color: Y,
                          //               width: 3.0,
                          //             ),
                          //           ):Border(),
                          //           // borderRadius: BorderRadius.circular(10),
                          //           color: Colors.transparent,
                          //         ),
                          //         child: Text('تم إنهاؤها',
                          //           style: TextStyle(
                          //             color: button4==true?Y:Colors.white,
                          //             fontSize: 14,
                          //             fontFamily: 'Changa',
                          //             fontWeight: FontWeight.bold,),
                          //         ),
                          //       ),
                          //       onTap: (){
                          //         button1=false;
                          //         button2=false;
                          //         button3=false;
                          //         button4=true;
                          //         setState(() {
                          //
                          //         });
                          //
                          //       },
                          //     ),
                          //
                          //   ],
                          // )
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap:(){
                      // Navigator.pop(context,);
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => U_PROFILE(name_Me: widget.username,Lsist_Post:widget.Lsist_Post,)));
                      // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => U_PROFILE(name_Me: widget.name_Me,)));
                    },
                    child:Container(
                      margin: EdgeInsets.only(top:60,left: 10,right: 10),
                      child:Icon(Icons.arrow_back,color: Colors.white,),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    height: 520,
                    margin: EdgeInsets.only(top:200),
                    child: FutureBuilder(
                      future: getrequest(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              // return Container(height: 200,color:Colors.yellow,);
                             return order(work:snapshot.data[index]['work'],id_g:snapshot.data[index]['id_g'],description:snapshot.data[index]['descr'],image:snapshot.data[index]['image'],username:snapshot.data[index]['name'],id:snapshot.data[index]['id'],namefirst: snapshot.data[index]['namefirst'], namelast: snapshot.data[index]['namelast'],phone: snapshot.data[index]['phoneuser']);
                            },
                          );
                        }
                        return Container();
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      _dialogCall();
                    },
                    child:Container(
                      width: 110,
                      height: 30,
                      margin: EdgeInsets.only(right:280,top:740),
                      decoration: BoxDecoration(
                        color: Y,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child:Text('طلب تسعير جديد',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 13.0,
                            fontFamily: 'Changa',
                            fontWeight: FontWeight.bold,),),
                      ),
                    ),
                  ),
                  // button1==true?  Container(
                  //   height: 600,
                  //   width: 500,
                  //   // color:  Color(0xFFF3D657),
                  //   margin: EdgeInsets.only(top:180),
                  //   //padding:EdgeInsets.only(right:25,left: 25),
                  //   decoration: BoxDecoration(
                  //     // color:Color(0xFF1C1C1C),
                  //     // borderRadius: BorderRadius.only(
                  //     //   topLeft: Radius.circular(50),
                  //     //   topRight: Radius.circular(50),
                  //     // ),
                  //   ),
                  //   child:FutureBuilder(
                  //     future: getMyorder(),
                  //     builder: (BuildContext context, AsyncSnapshot snapshot) {
                  //       if(snapshot.hasData){
                  //         return ListView.builder(
                  //           itemCount:snapshot.data.length,
                  //           itemBuilder: (context, index) {
                  //             var Listslot=snapshot.data;
                  //             bool dayend=false;
                  //             DateTime now=DateTime.now();
                  //             DateTime date=DateTime.parse(snapshot.data[index]['dateaccept']);
                  //             if(date.compareTo(now)<0 && snapshot.data[index]['states']=='notfinished'){
                  //               print('ooooooooooops date finished');
                  //               dayend=true;
                  //             }
                  //             bool cancelpermition=true;
                  //             final birthday = DateTime.parse(snapshot.data[index]['dateaccept']);
                  //             final date2 = DateTime.now();
                  //             final difference = date2.difference(birthday).inHours;
                  //             if(difference>=24){
                  //               cancelpermition=false;
                  //               print('more than 24 hour');
                  //             }
                  //             if(dayend==true || snapshot.data[index]['states']=='finished'){
                  //               return Dismissible(
                  //                 background: Container(
                  //
                  //                 ),
                  //                 secondaryBackground: Container(
                  //                   color: Colors.red,
                  //                   child: Padding(
                  //                     padding: EdgeInsets.only(right: 20,top: 20,bottom: 30,left:20),
                  //                     child: Row(
                  //                       mainAxisAlignment: MainAxisAlignment.end,
                  //                       children: <Widget>[
                  //                         Text('إزالة من قائمتك', style: TextStyle(color: Colors.white,
                  //                           fontFamily: 'Changa',
                  //                           fontSize: 14,
                  //                           fontWeight: FontWeight.bold,
                  //                         )),
                  //                         SizedBox(width: 5,),
                  //                         Icon(Icons.delete, color: Colors.white),
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 key: ObjectKey(snapshot.data[index]),
                  //                 child: Container(
                  //                   padding: EdgeInsets.only(right: 20,left:20),
                  //                   child:end_order(workername:snapshot.data[index]['name'],token:snapshot.data[index]['token'],country:widget.country,cancelpermition:cancelpermition,dayend:dayend,Rate:snapshot.data[index]['Rate'],username:widget.username,ststes:snapshot.data[index]['states'],id:snapshot.data[index]['id'],timeaccept:snapshot.data[index]['timeaccept'],timesend:snapshot.data[index]['timesend'],dateaccept:snapshot.data[index]['dateaccept'],datesend:snapshot.data[index]['datesend'],description:snapshot.data[index]['description'],phone:snapshot.data[index]['phoneuser'],phoneworker:snapshot.data[index]['phone'],work:snapshot.data[index]['Work'],image:snapshot.data[index]['image'],namefirst:snapshot.data[index]['namefirst'],namelast:snapshot.data[index]['namelast'],date:snapshot.data[index]['date'],timestart:snapshot.data[index]['timestart'] ,timeend:['timeend'],),
                  //
                  //                 ),
                  //                 onDismissed: (direction) {
                  //
                  //                 },
                  //               );
                  //               return end_order(workername:snapshot.data[index]['name'],token:snapshot.data[index]['token'],country:widget.country,cancelpermition:cancelpermition,dayend:dayend,Rate:snapshot.data[index]['Rate'],username:widget.username,ststes:snapshot.data[index]['states'],id:snapshot.data[index]['id'],timeaccept:snapshot.data[index]['timeaccept'],timesend:snapshot.data[index]['timesend'],dateaccept:snapshot.data[index]['dateaccept'],datesend:snapshot.data[index]['datesend'],description:snapshot.data[index]['description'],phone:snapshot.data[index]['phoneuser'],phoneworker:snapshot.data[index]['phone'],work:snapshot.data[index]['Work'],image:snapshot.data[index]['image'],namefirst:snapshot.data[index]['namefirst'],namelast:snapshot.data[index]['namelast'],date:snapshot.data[index]['date'],timestart:snapshot.data[index]['timestart'] ,timeend:['timeend'],);
                  //             }
                  //             return Container(height:0,);
                  //           },
                  //         );
                  //       }
                  //       return Center(child: CircularProgressIndicator());
                  //     },
                  //   ),
                  // ):Container(),

                ],),),
          ),],),);
  }
  Widget stackBehindDismiss() {
    return Container(
      height: 50,
      alignment: Alignment.centerRight,
      padding: EdgeInsets.all(100),
      color: Colors.red,
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }
// Future<void> _dialogCall() {
//   return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//        // return Directionality(textDirection: ui.TextDirection.rtl,
//         //  child:eaccept_order(image:widget.image,description:widget.description,datesend:widget.datesend,timesend:widget.timesend,id:widget.id,phone:widget.phoneworker,date:widget.date,namefirst: widget.namefirst,namelast:widget.namelast,time:widget.time,),);
//       });
// }
  Future<void> _dialogCall() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return MyDialog(username:widget.username,token:widget.token,country:widget.country,image:widget.image,namefirst:widget.namefirst,namelast:widget.namelast,phone:widget.phoneuser,);
        });
  }
}

class order  extends StatefulWidget {
  final username;
  final id;
  final id_g;
  final phone;
  final namefirst;
  final namelast;
  final image;
  final country;
  final description;
  final work;
  //
  order({this.work,this.id_g,this.username,this.description,this.id,this.country,this.image,this.namefirst,this.namelast,this.phone});

  @override
  _order createState() => _order();
}
class _order extends State<order> {
  var List=[];
  var DateList=[];
  @override
  Future getrequest()async{
    var url='http://'+IP4+'/testlocalhost/requestusercount.php';
    var ressponse=await http.post(url,body: {
      "id_g": widget.id_g,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  Widget build(BuildContext context) {

    return Column(
      children:[
        Container(
          child:card(),

        ),
      ],
    );
  }
  GestureDetector card()
  {
    return GestureDetector(
      child:Container(
        width: 380,
        height: 135,
        alignment: Alignment.topRight,
        transform: Matrix4.translationValues(0.0, -50.0, 0.0),
        decoration: BoxDecoration(
          color:Colors.grey[50],
          borderRadius: BorderRadius.circular(5),
        ),
        margin: EdgeInsets.only(bottom: 20,),
        padding: EdgeInsets.only(right: 20,top: 15,bottom: 10),
        child:Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Container(
                      width: 340,
                      height: 30,
                      alignment: Alignment.topRight,
                      child:Row(
                        children: [
                          Text('تسعير طلب لمهنة ', style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                            fontFamily: 'Changa',
                          ),
                          ),
                          Text(widget.work, style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                            fontFamily: 'Changa',
                          ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 340,
                      height: 50,
                      alignment: Alignment.topRight,
                      child:Row(
                        children: [
                        Container(
                          height: 50,
                          child:Text("تفاصيل الطلب ", style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.black54,
                            fontFamily: 'Changa',
                          ),
                          ),),
                          Container(
                            width: 250,
                            height: 50,
                            child:Text(widget.description, style: TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                              fontFamily: 'Changa',
                            ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 0,),
                    Container(
                      width: 340,
                      height: 30,
                      child: FutureBuilder(
                          future: getrequest(),
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              print("fffffffffffffffffffffffffffff");
                              print("SARAHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHhhhhhhhhh");
                              //_MyHomePageState c= new _MyHomePageState();
                              return ListView.builder(
                                itemCount:snapshot.data.length,
                                itemBuilder: (context, index) {
                                  print(snapshot.data.length.toString());
                                 print(snapshot.data['count'].toString());
                                 print(snapshot.data['accornot'].toString());
                                 print("fffffffffffffffffffffffffffff");
                                 print("SARAHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHhhhhhhhhh");
                                  return yesornot(snapshot.data['accornot'].toString(),snapshot.data['count'].toString());
                                },);
                            }
                            return Container(
                              height: 10,
                            );

                          }
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),),
    );
  }
  Container yesornot(String acc,String count){
    return Container(
           height: 40,
           alignment: Alignment.topLeft,
          // color: Colors.red,
          child:acc=="no"?Container(
            child: Text('لم يتم تسعير الطلب ',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color:Y,
                fontFamily: 'Changa',
              ),
            ),
          ):Container(
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>price_taseer_order(desc:widget.description,id_g:widget.id_g,country:widget.country,username: widget.username,namefirst:widget.namefirst,namelast:widget.namelast,phoneuser: widget.phone,image: widget.image,),),);
                },
              child:Text('تم تسعير الطلب من قبل '+count,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color:Y,
                  fontFamily: 'Changa',
                ),
            ),
            ),
          ),

    );
  }
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      //this means the user must tap a button to exit the Alert Dialog
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.only(right: 50,left:10,top: 30),
          titlePadding: EdgeInsets.only(right: 50,left:50,top: 30),
          content: Text('هل تريد حذف هذا الطلب ',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
              fontFamily: 'Changa',
            ),),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10,bottom: 20,top: 30),
              child:FlatButton(
                child: Text('نعم',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                    fontFamily: 'Changa',
                  ),),
                onPressed: () {
                  //h(context,MaterialPageRoute(builder: (BuildContext context) =>work_order(phone: widget.phone,List1: List,ListDate:DateList,)));
                },
              ),),
            Container(
              margin: EdgeInsets.only(left: 10,bottom: 20,top: 30),
              child:FlatButton(
                child: Text('لا',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                    fontFamily: 'Changa',
                  ),),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),),
          ],
        );
      },
    );
  }
  Future<void> _showMyAccept() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      //this means the user must tap a button to exit the Alert Dialog
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.only(right: 50,left:10,top: 30),
          titlePadding: EdgeInsets.only(right: 50,left:50,top: 30),
          content: Text('هل تريد قبول هذا الطلب ',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
              fontFamily: 'Changa',
            ),),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10,bottom: 20,top: 30),
              child:FlatButton(
                child: Text('نعم',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                    fontFamily: 'Changa',
                  ),),
                onPressed: () {
                  //sh(context,MaterialPageRoute(builder: (BuildContext context) =>work_order(phone: widget.phone,List1: List,ListDate:DateList,)));
                },
              ),),
            Container(
              margin: EdgeInsets.only(left: 10,bottom: 20,top: 30),
              child:FlatButton(
                child: Text('لا',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                    fontFamily: 'Changa',
                  ),),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),),
          ],
        );
      },
    );
  }
  Future delete (final id)async{
    var url = 'http://'+IP4+'/testlocalhost/deleteorder.php';
    var response = await http.post(url, body: {
      "id":id,
    });
    String massage = json.decode(response.body);
    print(massage);
    setState(() {

    });
  }
  Future accept (final id)async{
    var url = 'http://'+IP4+'/testlocalhost/acceptorder.php';
    var response = await http.post(url, body: {
      "id":id,
    });
    // String massage = json.decode(response.body);
    // print(massage);
  }

}


class MyDialog extends StatefulWidget {
  @override
  final phone;
  final AVG;
  final id;
  final token;
  final tokenworker;
  final phoneworker;
  final username;
  final namefirst;
  final namelast;
  final image;
  final work;
  final date;
  final time;
  final country;
  MyDialog({this.country,this.date,this.time,this.AVG,this.work,this.namelast,this.namefirst,this.image,this.phone,this.id,this.username,this.token,this.phoneworker,this.tokenworker});
  _MyDialogState createState() => new _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {

  TextEditingController description =TextEditingController();
  String imagePath;
  Image image;
  File image_file;
  bool desc=true;
  OverlayEntry floatingDropdown;
  bool isDropdownOpened=false;
  String country_id="اختيار المنطقة";
  String work_id="اختيار";
  String hint="اختيار المنطقة";
  List<String>country=["جنين","نابلس","طولكرم","رام الله","طوباس","حيفا","يافا","عكا","الخليل","قلقيلية"];
  OverlayEntry _createFloatingDropdown() {
    return OverlayEntry(builder: (context) {
      return Positioned(
        left: 65,
        top: 365,
        height: 500,
        child: Drop_Work(

        ),
      );
    });
  }
  Widget Drop_Work(){
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Material(
          elevation: 5,
          //shape: ArrowShape(),
          child: Container(
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child:SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  DropDownItem("نجار"),
                  DropDownItem("حدّاد"),
                  DropDownItem("سباك"),
                  DropDownItem("ميكانيكي"),
                  DropDownItem("كهربائي"),
                  DropDownItem("تصليح أجهزة"),
                  DropDownItem("دهان"),
                  DropDownItem("فني تكييف"),
                  DropDownItem("بلييط"),
                ],
              ),
            ),
          ),
        ),],
    );
  }
  Widget DropDownItem(String text) {

    return Directionality(textDirection: ui.TextDirection.rtl,
      child:Container(
        width:120,
        height: 50,
        alignment: Alignment.topRight,
        decoration: BoxDecoration(
          color:Colors.white,
        ),
        //margin: EdgeInsets.only(right: 16,),
        padding: EdgeInsets.only(top: 8,bottom: 8,right: 0),
        child: Container(
          width: 120,
          margin: EdgeInsets.only(right: 5,),
          padding: EdgeInsets.only(right: 5,),
          alignment: Alignment.topRight,
          child:FlatButton(
            onPressed: (){
              print(text);
              setState(() {
                isDropdownOpened=false;
                floatingDropdown.remove();
                work_id=text;
              });
            },
            child: Text(text,
              style: TextStyle(
                fontSize: 15.0,
                fontFamily: 'Changa',
                color: Color(0xFF666360),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),),);
  }
  @override
  Widget build(BuildContext context){
    print(widget.phoneworker);   print(widget.phone);   print(widget.token); print(widget.username);   print(widget.tokenworker); print("nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn");
    return AlertDialog(
      backgroundColor: Colors.white,
      //insetPadding: EdgeInsets.all(10),
      actionsPadding: EdgeInsets.zero,
      content: new SingleChildScrollView(
        child: new ListBody(
          children: <Widget>[
            SizedBox(height:10,),
            Container(
              width: 500,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isDropdownOpened) {
                          floatingDropdown.remove();
                        } else {
                          //findDropdownData();
                          floatingDropdown = _createFloatingDropdown();
                          Overlay.of(context).insert(floatingDropdown);
                        }
                        isDropdownOpened = !isDropdownOpened;
                      });
                    },
                    child: Container(
                      height:35,
                      width:120,
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black87.withOpacity(0.03),
                    ),
                      alignment: Alignment.topRight,
                      padding: const EdgeInsets.symmetric(horizontal:2,vertical: 2),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.arrow_drop_down,
                            color: Color(0xFF666360),
                            size: 27,
                          ),
                          Container(
                            width:89,
                            padding:EdgeInsets.only(right:2),
                            alignment:Alignment.topRight,
                            child:Text(
                              work_id,
                              style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: 'Changa',
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),),
                  SizedBox(width:48,),

                  Text('اختيار مهنة لطلبك',
                    style:TextStyle(
                      fontSize: 15.0,
                      fontFamily: 'Changa',
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
              width:120,
              height: 70,
              child: TextFormField(
                cursorColor:Colors.grey[600],
                textAlign: TextAlign.right,
                //controller: text_post,
                maxLines: 20,
                controller: description,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15.0,
                  fontFamily: 'Changa',
                  fontWeight: FontWeight.bold,
                ),
                //o: Desc(),
                decoration: InputDecoration(
                  hoverColor:Colors.black54,
                  contentPadding: EdgeInsets.all(1.0),
                  enabledBorder: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    borderSide:  BorderSide(color:Colors.white),

                  ),
                  focusedBorder: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    borderSide:  BorderSide(color:Colors.white),

                  ),
                  hintText: 'أضف تفصيل لطلبك لتسعيره',
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
            desc?Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Text('',textAlign:TextAlign.end,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Changa',
                  color: Colors.red,

                ),),
            ): Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Text('يجب إرسال تفاصيل عن الطلب ',textAlign:TextAlign.end,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Changa',
                  color: Colors.red,

                ),),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
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
                  GestureDetector(
                    onTap: ()async{
                      if(description.text.isEmpty){
                        desc=false;
                      }

                      else{
                        await reserve();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => user_taseer_order(country:widget.country,token:widget.token,username: widget.username,namefirst:widget.namefirst,namelast:widget.namelast,phoneuser: widget.phone,image: widget.image,),),);
                        Fluttertoast.showToast(timeInSecForIos:10,msg: " تم إرسال طلبك بنجاح ",fontSize: 16,textColor:Colors.black87,);
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => not_conferm_user_statues(name_Me:widget.username,id:widget.id,AVG:widget.AVG,work:widget.work,timesend:formattedTime,datesend:formattedDate,date:widget.date,time:widget.time,phoneworker:widget.phoneworker,description:description.text,namefirst: widget.namefirst,namelast: widget.namelast,phoneuser: widget.phone,image: widget.image,),),);

                      }
                      setState(() {
                      });
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
                ],
              ),),
          ],
        ),
      ),
    );
  }
  void Desc(){
    desc=true;
    setState(() {

    });
  }
  Future reserve()async{

    DateTime date=DateTime.now();
    print(work_id);
    print("''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''");
    var url = 'http://'+IP4+'/testlocalhost/newtasser.php';
    var ressponse = await http.post(url, body: {
      "phoneuser": widget.phone,
      "desc": description.text,
      "work":work_id,
    });
    String massage= json.decode(ressponse.body);
    // print(massage);
  }

}


