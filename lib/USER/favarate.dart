import 'dart:math';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterphone/ChatUuser/chatListUser.dart';
import 'package:flutterphone/USER/user_Profile.dart';
import 'package:flutterphone/USER/user_reserve_order.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutterphone/constants.dart';
import '../buttom_bar.dart';
import '../constants.dart';
import '../database.dart';
import 'menue_Page.dart';

String  name_Me="";
String  name="";
String  phone="";
String  image="";
String namefirst="";
String namelast="";
String Country="";
String  token="";
String IP4="192.168.1.8:8080";

class favarate extends StatefulWidget {
  final phoneuser;
  final username;
  final namelast;
  final namefirst;
  final image;
  final token;
  List<dynamic>Lsist_Post;
  favarate({this.Lsist_Post,this.username,this.phoneuser,this.namefirst,this.namelast,this.image,this.token});
  _favarate createState() =>  _favarate();
}
class  _favarate extends State<favarate> {
  // AnimationController _animationController;
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  final List1 = [];
  var ListDate1 = [];
  final List2 = [];
  var ListDate2 = [];
  var ListBlock=["8.00 - 9.00","9.00 - 10.00","","","",];
  var Listsearch=[];
  bool button1=true;
  bool button2=false;
  bool button3=false;
  bool step3=false;

  Future getMyfaverate()async{
    var url='http://'+IP4+'/testlocalhost/faverate.php';
    var ressponse=await http.post(url,body: {
      "phoneuser": widget.phoneuser,
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
     getChat();
  }

  int _selectedItem = 3;
  PageController _pageController;
  DatabaseMethods databaseMethods=new DatabaseMethods();
  Stream chatsRoom;
  @override
  Widget build(BuildContext context) {
    print(Listsearch.toString());
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Directionality(textDirection: ui.TextDirection.rtl,
      child:Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.white,
            key: _scaffoldKey,
            // appBar: new AppBar(
            //   backgroundColor: Y2,
            //   leading:GestureDetector(
            //     onTap: (){
            //       Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => U_PROFILE(name_Me: widget.username,)));
            //     },
            //     child:Icon(Icons.arrow_back,color: Colors.white,),
            //   ),
            //   title: new Text('المفضلة',
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
            //
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
                Icons.favorite_border,
                Icons.menu,
              ],
              onChange: (val) {
                setState(() {
                  _selectedItem = val;
                });
                if(_selectedItem==0){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => U_PROFILE(name_Me: widget.username,Lsist_Post:widget.Lsist_Post,)));
                }
                if(_selectedItem==1){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => user_reserve_order(index:'0',Lsist_Post:widget.Lsist_Post,username: widget.username,phoneuser: widget.phoneuser,namelast:widget.namelast,image:widget.image,token:widget.token,namefirst:widget.namefirst)));
                }
                if(_selectedItem==2){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Chat(Lsist_Post:widget.Lsist_Post,name_Me:widget.username,chatsRoomList: chatsRoom,phone:widget.phoneuser,namelast:widget.namelast,image:widget.image,token:widget.token,namefirst:widget.namefirst)));
                }
                if(_selectedItem==3){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => favarate(Lsist_Post:widget.Lsist_Post,username: widget.username,phoneuser: widget.phoneuser,namelast:widget.namelast,image:widget.image,token:widget.token,namefirst:widget.namefirst)));
                }
                if(_selectedItem==4){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MenuePage(Lsist_Post:widget.Lsist_Post,namelast:widget.namelast,name:widget.username,phone:widget.phoneuser,image:widget.image,token:widget.token,namefirst:widget.namefirst)));
                }
              },
              defaultSelectedIndex: _selectedItem,
            ),
            body: Form(
              // child:SingleChildScrollView(
              child: Stack(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Container(
                  //   width: 500,
                  //   height: 110,
                  //   color: Colors.white,
                  //   child:  Container(
                  //     width: 300,
                  //     height: 60,
                  //     margin: EdgeInsets.only(top:60,right: 10),
                  //     // transform: Matrix4.translationValues(0, -120.0, 0),
                  //     child:Row(
                  //       children: [
                  //          SizedBox(width: 20,),
                  //         Text('مفضلتي',
                  //           style: TextStyle(
                  //             fontSize: 18,
                  //             fontWeight: FontWeight.bold,
                  //             color: Colors.black,
                  //             fontFamily: 'Changa',
                  //             //fontStyle: FontStyle.italic,
                  //           ),),
                  //         Icon(Icons.favorite_border,size: 21,color: Colors.black,),
                  //       ],
                  //     ),
                  //   ),
                  // ),

                 Container(
                    height: 700,
                    width: 500,
                    // color:  Color(0xFFF3D657),
                    margin: EdgeInsets.only(top:50),
                    //padding:EdgeInsets.only(right:25,left: 25),
                    decoration: BoxDecoration(
                      // color:Color(0xFF1C1C1C),
                      // borderRadius: BorderRadius.only(
                      //   topLeft: Radius.circular(50),
                      //   topRight: Radius.circular(50),
                      // ),
                    ),
                    child:FutureBuilder(
                      future: getMyfaverate(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if(snapshot.hasData){
                          return ListView.builder(
                            itemCount:snapshot.data.length,
                            itemBuilder: (context, index) {
                              return f(usertoken:widget.token,userimage:widget.image,usernamelast:widget.namelast,usernamefirst:widget.namefirst,index:index,phoneuser:widget.phoneuser,username:widget.username,phone:snapshot.data[index]['phone'],image:snapshot.data[index]['image'],work:snapshot.data[index]['Work'],namefirst:snapshot.data[index]['namefirst'],namelast:snapshot.data[index]['namelast'],name:snapshot.data[index]['name'],);
                              return Container(child: Text('bggngn'),);
                            },
                          );
                        }
                        return Center(child: Container(height: 0,));
                      },
                    ),
                  ),
                ],),),
          ),],),);
  }
// Future<void> _dialogCall() {
//   return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//        // return Directionality(textDirection: ui.TextDirection.rtl,
//         //  child:eaccept_order(image:widget.image,description:widget.description,datesend:widget.datesend,timesend:widget.timesend,id:widget.id,phone:widget.phoneworker,date:widget.date,namefirst: widget.namefirst,namelast:widget.namelast,time:widget.time,),);
//       });
// }
}
class f  extends StatefulWidget {
  final name;
  final phone;
  final namefirst;
  final namelast;
  final image;
  final work;
  final country;
  final username;
  final phoneuser;
  final index;
  final usernamelast;
  final usernamefirst;
  final userimage;
  final usertoken;
  //
  f({this.username,this.usernamefirst,this.usernamelast,this.usertoken,this.index,this.phoneuser,this.country,this.work,this.image,this.namefirst,this.namelast,this.name,this.phone,this.userimage});

  @override
  _f createState() => _f();
}
class _f extends State<f> {
  var List=[];
  var DateList=[];
  void _showSnackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(content:
     Text(text,
      style: TextStyle(
      fontFamily: 'Changa',
      color: Colors.white,
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
    ),)));
  }
  @override
  Widget build(BuildContext context) {

    return Column(
      children:[
        GestureDetector(
          onTap: (){
          },
          child:Container(
            width: 360,
            height: 90,
            alignment: Alignment.topRight,
            decoration: BoxDecoration(
              color:Colors.grey[50],
              borderRadius: BorderRadius.circular(5),
            ),
            margin: EdgeInsets.only(bottom: 20,),
            padding: EdgeInsets.only(right: 10,top: 5,bottom: 10),
            child:Row(
              children: [

                Container(
                  margin: EdgeInsets.only(top: 5, right: 5),
                  child: CircleAvatar(backgroundImage: NetworkImage(
                      'http://' + IP4 + '/testlocalhost/upload/' + widget.image),
                    radius: 30.0,),),
                Container(
                  child: Column(
                    children: [
                      Container(
                        width: 200,
                        alignment: Alignment.topRight,
                        margin: EdgeInsets.only(top: 10, right: 10),
                        child: Text(widget.namefirst+" "+widget.namelast, style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontFamily: 'Changa',
                        ),
                        ),
                      ),
                      Container(
                        width: 200,
                        alignment: Alignment.topRight,
                        margin: EdgeInsets.only(right: 10),
                        child:  Text(widget.work, style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.black54,
                          fontFamily: 'Changa',
                        ),
                        ),
                      ),
                    ],
                ),),
               SizedBox(width: 25,),
               GestureDetector(
                 onTap: ()async{
                   await delete_faverate();
                    Fluttertoast.showToast(timeInSecForIos:10,msg: " تم الحذف من مفضلتك  ",fontSize: 16,textColor:Colors.black87,);
                   //_showSnackBar(context, 'تمت الإزالة من قائمة المفضلة لديك');
                   Navigator.push(context, MaterialPageRoute(builder: (context) => favarate(phoneuser:widget.phoneuser,username:widget.username,namelast:widget.usernamelast,image:widget.userimage,token:widget.usertoken,namefirst:widget.usernamefirst),),);
                 },
                 child:Container(
                   child: Icon(Icons.favorite,size: 25,color: Colors.red,),
                 ),
               ),
            ],),
          // Container(
          //   padding: EdgeInsets.all(20),
          //   width: MediaQuery.of(context).size.width*0.2,
          //   child: Text(date, style: TextStyle(
          //     color: Colors.black,
          //     fontWeight: FontWeight.w700,
          //   ), textAlign: TextAlign.right,),
          // ),
        ),),],
    );

  }

  Future delete_faverate() async {
    DateTime date=DateTime.now();
    var formattedDate = DateFormat('yyyy-MM-dd').format(date);
    var formattedTime = DateFormat('HH:mm:ss').format(date);
    var url = 'http://' + IP4 + '/testlocalhost/delete_faverate.php';
    var ressponse = await http.post(url, body: {
      "phoneuser":widget.phoneuser,
      "phoneworker":widget.phone,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
}
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




