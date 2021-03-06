import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterphone/ChatUuser/chatListUser.dart';
import 'package:flutterphone/USER/user_Profile.dart';
import 'package:flutterphone/USER/user_reserve_order.dart';
import 'package:flutterphone/screens/login_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

import '../database.dart';
import 'favarate.dart';

String IP4="192.168.1.8:8080";
//import 'edit_profile.dart';
//import 'changePassword.dart';
FocusNode myFocusNode = new FocusNode();
bool Pass_Null=true;
bool Pass_R=true;
bool Pass_Mismatch=true;
bool Pass_S=true;
bool Pass_old=true;
bool Pass_old_notC=true;
String pass="";

bool _showPassword1 = false;
bool _showPassword2 = false;
bool _showPassword3 = false;

class MenuePage extends StatefulWidget {

  final  name;
  final  phone;
  final  image;
  final  token;
  final namefirst;
  final namelast;
  List<dynamic>Lsist_Post;

  MenuePage({this.Lsist_Post,this.namefirst,this.namelast,this.name, this.phone, this.image,this.token});

  @override
  _MenuePage createState() => _MenuePage();

}
class _MenuePage extends State<MenuePage> {
  @override
  bool isSwitched1 = false;
  bool isSwitched2 = false;
  bool setting=true;
  bool change_pass=false;
  TextEditingController password = TextEditingController();
  TextEditingController newpass = TextEditingController();
  TextEditingController confirmpass = TextEditingController();
  bool showPassword = false;
  DatabaseMethods databaseMethods=new DatabaseMethods();

  getChat(){
    databaseMethods.getChatsMe(widget.name).then((val){
      setState(() {
        print(val.toString());
        chatsRoom=val;
      });
    });
  }
  @override
  void _togglevisibility1() {
    setState(() {
      _showPassword1 = !_showPassword1;
    });
  }

  void _togglevisibility2() {
    setState(() {
      _showPassword2 = !_showPassword2;
    });
  }

  void _togglevisibility3() {
    setState(() {
      _showPassword3 = !_showPassword3;
    });
  }
  @override
  void initState() {
    super.initState();
    getChat();
  }
  Stream chatsRoom;
  int _selectedItem=4;
  final formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {
    return  Directionality(textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
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
        //                 Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => U_PROFILE(name_Me: widget.name,)));
        //               }
        //               if(index==1){
        //                 Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => user_reserve_order(username: widget.name,phoneuser: widget.phone,namelast:widget.namelast,image:widget.image,token:widget.token,namefirst:widget.namefirst)));
        //               }
        //               if(index==2){
        //                 Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Chat(name_Me:widget.name,chatsRoomList: chatsRoom,phone:widget.phone,namelast:widget.namelast,image:widget.image,token:widget.token,namefirst:widget.namefirst)));
        //               }
        //               if(index==3){
        //                 Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => favarate(username: widget.name,phoneuser: widget.phone,namelast:widget.namelast,image:widget.image,token:widget.token,namefirst:widget.namefirst)));
        //               }
        //               if(index==4){
        //                 Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MenuePage(namelast:widget.namelast,name:widget.name,phone:widget.phone,image:widget.image,token:widget.token,namefirst:widget.namefirst)));
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
            Icons.favorite_border,
            Icons.menu,
          ],
          onChange: (val) {
            setState(() {
              _selectedItem = val;
            });
            if(_selectedItem==0){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => U_PROFILE(name_Me: widget.name,Lsist_Post:widget.Lsist_Post,)));
            }
            if(_selectedItem==1){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => user_reserve_order(index:'0',Lsist_Post:widget.Lsist_Post,username: widget.name,phoneuser: widget.phone,namelast:widget.namelast,image:widget.image,token:widget.token,namefirst:widget.namefirst)));
            }
            if(_selectedItem==2){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Chat(Lsist_Post:widget.Lsist_Post,name_Me:widget.name,chatsRoomList: chatsRoom,phone:widget.phone,namelast:widget.namelast,image:widget.image,token:widget.token,namefirst:widget.namefirst)));
            }
            if(_selectedItem==3){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => favarate(Lsist_Post:widget.Lsist_Post,username: widget.name,phoneuser: widget.phone,namelast:widget.namelast,image:widget.image,token:widget.token,namefirst:widget.namefirst)));
            }
            if(_selectedItem==4){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MenuePage(Lsist_Post:widget.Lsist_Post,namelast:widget.namelast,name:widget.name,phone:widget.phone,image:widget.image,token:widget.token,namefirst:widget.namefirst)));
            }
          },
          defaultSelectedIndex: _selectedItem,
        ),
        body: Form(
          // child:SingleChildScrollView(
          child: Column(
            children: [
              Container(
              margin: EdgeInsets.only(top: 0),
              height: 250,
              color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top:100),
                      child: Center(
                        child: CircleAvatar(backgroundImage: NetworkImage(
                            'http://' + IP4 + '/testlocalhost/upload/' + widget.image),
                          radius: 30.0,),),
                    ),
                    Container(
                      // transform: Matrix4.translationValues(0, -27.0, 0),
                      margin: EdgeInsets.only(top: 5),
                      child: Center(
                        child: Text(widget.namefirst + " " + widget.namelast,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16.0,
                            fontFamily: 'Changa',
                            fontWeight: FontWeight.bold,),),
                      ),),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              todayorder(context,'طلباتي'),
              faverat_me(context,'قائمة المفضلة'),
              chat(context,'الشات'),
              SizedBox(height: 20,),
              SizedBox(height: 10,),
              // Container(
              //   child: Divider(
              //     thickness: 1.0,
              //     color: Colors.black54.withOpacity(0.2),
              //   ),
              // ),
              _notification(context,'الإشعارات'),
              // Container(
              //   child: Divider(
              //     thickness: 1.0,
              //     color: Colors.black54.withOpacity(0.2),
              //   ),
              // ),
              SizedBox(height: 30,),
              logout(context, 'تسجيل الخروج'),

            ],
          ),

        ),),);
  }
  GestureDetector chat(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(left: 307,right: 30,top: 10,bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.mark_chat_unread,
              color: Colors.grey,
              size: 21,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.grey[600],
                fontFamily: 'Changa',
              ),
            ),
          ],
        ),
      ),
    );
  }
  GestureDetector faverat_me(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(left: 255,right: 30,top: 10,bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.favorite_border,
              color: Colors.grey,
              size: 21,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.grey[600],
                fontFamily: 'Changa',
              ),
            ),
          ],
        ),
      ),
    );
  }
  GestureDetector followo(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(left: 285,right: 30,top: 10,bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.people_sharp,
              color: Colors.grey,
              size: 24,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.grey[600],
                fontFamily: 'Changa',
              ),
            ),
          ],
        ),
      ),
    );
  }
  GestureDetector todayorder(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
      },

      child: Padding(
        padding: const EdgeInsets.only(left: 305,right: 30,top: 5,bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.list,
              color: Colors.grey,
              size: 21,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.grey[600],
                fontFamily: 'Changa',
              ),
            ),
          ],
        ),
      ),
    );
  }
  GestureDetector logout(BuildContext context, String title){
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Loginscreen()));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 260,right: 30,top: 50,),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.logout,
              color: Colors.grey,
              size: 21,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.grey[600],
                fontFamily: 'Changa',
              ),
            ),
          ],
        ),),
    );
  }
  Directionality _notification(BuildContext context, String title){
    return Directionality(textDirection: TextDirection.ltr,
      child:GestureDetector(
        child: Padding(
          padding: const EdgeInsets.only(left: 15,right: 40,top:0,),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Switch(
                value: isSwitched2,
                onChanged: (value) {
                  setState(() {
                    isSwitched2 = value;
                  });
                },
                activeTrackColor:Colors.green,
                activeColor:Colors.white,
                inactiveTrackColor: Colors.grey.withOpacity(0.3),
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[600],
                  fontFamily: 'Changa',
                ),
              ),
            ],
          ),),
      ),);
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

