import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterphone/screens/login_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet.dart';
import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'df.dart';
import 'getComment.dart';
import '../database.dart';
import 'GET_IMGS.dart';
import 'Profile.dart';
import 'all_post.dart';
import 'change.dart';
import 'edit.dart';
import 'homepage.dart';
import 'odersperson_day.dart';
import 'orders_workers.dart';
import 'package:flutterphone/Chatworker/chatListworker.dart';
import 'package:flutterphone/Chatworker/Conversation.dart';
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
  var image;
  final  Work;
  final  Experiance;
  final  Information;
  final  token;
  final namefirst;
  final namelast;
  final lat;
  final lng;

  MenuePage({this.lat,this.lng,this.namefirst,this.namelast,this.name, this.phone, this.image, this.Work, this.Experiance, this.Information, this.token});

  get username => null;

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
  Future<void> _showMyDialogo1( ) async {
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
                  margin: EdgeInsets.only(left: 260),
                  alignment: Alignment.topRight,
                  child: Row(
                    children: [
                      Text('ورشاتك',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Y,
                          fontFamily: 'Changa',
                        ),),
                    ],
                  ),
                ),
                Container(
                  transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                  child:MultiSelectChipField(
                    items: _items,
                    initialValue: [_animals[1], _animals[3], _animals[5]],
                    title: Text(""),
                    headerColor: Colors.transparent,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent, width: 1.8),
                    ),
                    selectedChipColor: Y,
                    selectedTextStyle: TextStyle(color: Colors.black, fontFamily: 'Changa', fontSize: 13,),
                    onTap: (values) {
                      //_selectedAnimals4 = values;
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () async{
                   Navigator.pop(context);
                    // await _showDialog();
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Text('حسنا',
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
              ],
            );
          },
        );
      },
    );
  }
  static List<Animal> _animals = [
    Animal(id: 1, name: "ورشة تصميم مطبخ"),
    Animal(id: 2, name: "ورشة تفصيل أبواب"),
    Animal(id: 3, name: "ورشة تقصيل خزانة"),
    Animal(id: 4, name: "Horse"),
    Animal(id: 5, name: "Tiger"),
    Animal(id: 6, name: "Penguin"),
    Animal(id: 7, name: "Spider"),
    Animal(id: 8, name: "Snake"),
    Animal(id: 9, name: "Bear"),
    Animal(id: 10, name: "Beaver"),
  ];
  final _items = _animals
      .map((animal) => MultiSelectItem<Animal>(animal, animal.name))
      .toList();
  PickedFile image_file;
  File _file;
  final ImagePicker image_picker =ImagePicker();

  DatabaseMethods databaseMethods=new DatabaseMethods();
  Stream chatsRoom;
  @override
  getChat(){
    print(widget.name);
    databaseMethods.getChatsMe(widget.name).then((val){
      setState(() {
        print(val.toString());
        chatsRoom=val;
      });
    });
  }
  void initState() {
    super.initState();
    getChat();

  }
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
  int _selectedItem=4;
  final formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {
    print("Menueeeeeeeeeeeeee");
    print(widget.image);
    return  Directionality(textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
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
        //               if(index==0){
        //                 Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Home_Page(name: widget.name)));
        //               }
        //               if(index==1){
        //                 Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => order_worker(Information:widget.Information,Experiance:widget.Experiance,Work:widget.Work,namelast:widget.namelast,name:widget.name,phone:widget.phone,image:widget.image,token:widget.token,namefirst:widget.namefirst,)));
        //               }
        //               if(index==2){
        //                 Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Chat(name_Me:widget.name,chatsRoomList: chatsRoom,Information:widget.Information,Experiance:widget.Experiance,Work:widget.Work,namelast:widget.namelast,phone:widget.phone,image:widget.image,token:widget.token,namefirst:widget.namefirst)));
        //               }
        //               if(index==3){
        //                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => PROFILE(name:widget.name,phone: widget.phone,)));
        //               }
        //               if(index==4){
        //                 DateTime date=DateTime.now();
        //                 Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MenuePage(Information:widget.Information,Experiance:widget.Experiance,Work:widget.Work,namelast:widget.namelast,name:widget.name,phone:widget.phone,image:widget.image,token:widget.token,namefirst:widget.namefirst,)));
        //               }
        //
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
            Icons.person,
            Icons.menu,
          ],
          onChange: (val) {
            setState(() {
              _selectedItem = val;
            });
            if(_selectedItem==0){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => orderpperson_map(lat:widget.lat,lng:widget.lng,phone_Me:widget.phone,name_Me:widget.name)));
            }
            if(_selectedItem==1){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => order_worker(lat:widget.lat,lng:widget.lng,Information:widget.Information,Experiance:widget.Experiance,Work:widget.Work,namelast:widget.namelast,name:widget.name,phone:widget.phone,image:widget.image,token:widget.token,namefirst:widget.namefirst,)));
            }
            if(_selectedItem==2){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Chat(lat:widget.lat,lng:widget.lng,name_Me:widget.name,chatsRoomList: chatsRoom,Information:widget.Information,Experiance:widget.Experiance,Work:widget.Work,namelast:widget.namelast,phone:widget.phone,image:widget.image,token:widget.token,namefirst:widget.namefirst)));
            }
            if(_selectedItem==3){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => PROFILE(lat:widget.lat,lng:widget.lng,name:widget.name,phone: widget.phone,)));
            }
            if(_selectedItem==4){
              DateTime date=DateTime.now();
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MenuePage(lat:widget.lat,lng:widget.lng,Information:widget.Information,Experiance:widget.Experiance,Work:widget.Work,namelast:widget.namelast,name:widget.name,phone:widget.phone,image:widget.image,token:widget.token,namefirst:widget.namefirst,)));
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
              color: Colors.grey[50],
                child: Column(
                  children: [
                    Center(
                      child: Container(margin:EdgeInsets.only(top:100),child: image_profile(),),),
                    // Container(
                    //   margin: EdgeInsets.only(top:100),
                    //   child: Center(
                    //     child: CircleAvatar(backgroundImage: NetworkImage(
                    //         'http://' + IP4 + '/testlocalhost/upload/' + widget.image),
                    //       radius: 45.0,),),
                    // ),
                    Container(
                      // transform: Matrix4.translationValues(0, -27.0, 0),
                      margin: EdgeInsets.only(top: 0),
                      child: Center(
                        child: Text(widget.namefirst + " " + widget.namelast,
                          style: TextStyle(
                            color: Colors.black87.withOpacity(0.6),
                            fontSize: 17.0,
                            fontFamily: 'Changa',
                            fontWeight: FontWeight.bold,),),
                      ),),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Gallery(context,'معرض الصور'),
              update(context,'تعديل المعلومات الشخصية'),
              change(context,'تغيير كلمة السر'),
              comment(context,'التعليقات'),
              SizedBox(height: 10,),
              // Container(
              //   child: Divider(
              //     thickness: 1.0,
              //     color: Colors.black54.withOpacity(0.2),
              //   ),
              // ),
              SizedBox(height: 10,),
              statues(context,'الحالة'),
              _notification(context,'الإشعارات'),
              // Container(
              //   child: Divider(
              //     thickness: 1.0,
              //     color: Colors.black54.withOpacity(0.2),
              //   ),
              // ),
              SizedBox(height: 50,),
              logout(context, 'تسجيل الخروج'),

            ],
          ),

        ),),);
  }
  GestureDetector Gallery(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Get_Images(phone: widget.phone, name: widget.name)));
      },

      child: Padding(
        padding: const EdgeInsets.only(left: 262,right: 30,top: 10,bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.image,
              color: Colors.grey,
              size: 24,
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
        ),
      ),
    );
  }
  GestureDetector warshat(BuildContext context, String title) {
    return GestureDetector(
      onTap: () async{
        await _showMyDialogo1();
      },

      child: Padding(
        padding: const EdgeInsets.only(left: 295,right: 30,top: 10,bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.list_alt,
              color: Colors.grey,
              size: 24,
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
        ),
      ),
    );
  }
  GestureDetector Post_Me(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Post(namelast:widget.namelast,image:widget.image,namefirst:widget.namefirst,phone: widget.phone, name: widget.name)));
      },

      child: Padding(
        padding: const EdgeInsets.only(left: 300,right: 30,top: 10,bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.list_alt,
              color: Colors.grey,
              size: 24,
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
        ),
      ),
    );
  }
  GestureDetector todayorder(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          change_pass=true;
          setting=false;
        });
      },

      child: Padding(
        padding: const EdgeInsets.only(left: 240,right: 30,top: 5,bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.lock,
              color: Colors.grey,
              size: 25,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 17,
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

  GestureDetector comment(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => getMyComment(phone: widget.phone,name:widget.name,)));
      },

      child: Padding(
        padding: const EdgeInsets.only(left: 290,right: 30,top: 5,bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.comment,
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

  Directionality notification(BuildContext context, String title){
    return Directionality(textDirection: TextDirection.ltr,
      child:GestureDetector(
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 40,top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 0),
                margin: EdgeInsets.symmetric(horizontal: 0),
                width: 95,
                height: 40,
                child:LiteRollingSwitch(
                  //initial value
                  value: false,
                  // textOn: 'disponible',
                  // textOff: 'ocupado',
                  colorOn: Colors.green,
                  colorOff: Colors.grey.withOpacity(0.3),
                  iconOn: Icons.done,
                  iconOff: Icons.notifications_off_rounded,
                  onChanged: (bool state) {
                  },
                ),),
              Text(
                title,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[600],
                  fontFamily: 'Changa',
                ),
              ),
            ],
          ),),
      ),);
  }
  Directionality Dark(BuildContext context, String title) {
    return Directionality(textDirection: TextDirection.ltr,
      child:GestureDetector(
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 30,top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 0),
                margin: EdgeInsets.symmetric(horizontal: 0),
                width: 95,
                height: 40,
                child:LiteRollingSwitch(
                  //initial value
                  value: false,
                  // textOn: 'disponible',
                  // textOff: 'ocupado',
                  colorOn: MY_YELLOW,
                  colorOff: Colors.grey.withOpacity(0.3),
                  iconOn: Icons.wb_sunny_outlined,
                  iconOff: Icons.brightness_2_rounded,
                  onChanged: (bool state) {
                  },
                ),),
              Text(
                title,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[600],
                  fontFamily: 'Changa',
                ),
              ),
            ],
          ),),
      ),);

  }
  GestureDetector logout(BuildContext context, String title){
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Loginscreen()));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 265,right: 30,top: 10,),
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
                fontSize: 14,
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
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[600],
                  fontFamily: 'Changa',
                ),
              ),
            ],
          ),),
      ),);
  }
  Directionality statues(BuildContext context, String title){
    return Directionality(textDirection: TextDirection.ltr,
      child:GestureDetector(
        child: Padding(
          padding: const EdgeInsets.only(left: 15,right: 30,top:10,),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Switch(
                value: isSwitched1,
                onChanged: (value) async{
                  print(value);
                  isSwitched1 = value;
                  await updatestate();
                  setState(() {
                  });
                },
                activeTrackColor:Colors.green,
                activeColor:Colors.white,
                inactiveTrackColor: Colors.grey.withOpacity(0.3),
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
      ),);
  }
  Directionality argent(BuildContext context, String title){
    return Directionality(textDirection: TextDirection.ltr,
      child:GestureDetector(
        child: Padding(
          padding: const EdgeInsets.only(left: 15,right: 40,top: 10,),
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
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[600],
                  fontFamily: 'Changa',
                ),
              ),
            ],
          ),),
      ),
    );
  }
  GestureDetector update(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage(namefirst:widget.namefirst,namelast:widget.namelast,name:widget.name,phone:widget.phone,image:widget.image,Work:widget.Work,Experiance:widget.Experiance,Information:widget.Information,token:widget.token)),
      );},
      child: Padding(
        padding: const EdgeInsets.only(left: 175,right: 30,top: 10,bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.person,
              color: Colors.grey,
              size: 24,
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
        ),
      ),
    );
  }
  GestureDetector change(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePass(name:widget.name,phone:widget.phone,image:widget.image,Work:widget.Work,Experiance:widget.Experiance,Information:widget.Information,token:widget.token)));
      },

      child: Padding(
        padding: const EdgeInsets.only(left: 245,right: 30,top:10,bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.lock,
              color: Colors.grey,
              size: 24,
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
        ),
      ),
    );
  }

  Future editpassword() async {
    print(widget.name);
    print(password.text);
    print(newpass.text);
    var url = 'http://'+IP4+'/testlocalhost/edit_pass.php';
    var response = await http.post(url, body: {
      "name":widget.name,
      "pass":password.text,
      "newpass": newpass.text,
    });
    //print(response);
    String massage= json.decode(response.body);
    print(massage);
    if(massage=='old pass not correct'){
      setState(() {
        Pass_old_notC=false;
        Pass_old=true;
      });
    }
    else{
      Pass_old_notC=true;
    }
  }
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      //this means the user must tap a button to exit the Alert Dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(""),
          actions: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(100, 40, 1, 100),
                        child: IconButton(
                          alignment: Alignment.topRight,
                          onPressed: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        PROFILE(name:widget.name)));

                          },
                          icon: Icon(
                            Icons.cancel,
                            color: Colors.white,
                            size: 30.0,
                          ),
                        ),
                      ),


                      Container(
                        margin: EdgeInsets.fromLTRB(80, 130, 10, 1),

                      ),
                      Container(
                        height: 627.5,
                        margin: EdgeInsets.only(top:170),
                        decoration: BoxDecoration(
                          color: Color(0xFF1C1C1C),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                        ),
                        child:Column(
                          children:[
                            Container(
                              margin: EdgeInsets.only(top: 140,left: 40,right: 40),
                              height: 60,
                              child:TextFormField(
                                // textDirection: TextDirection.rtl,
                                controller: password,
                                obscureText: !_showPassword1,
                                validator: (value) {
                                  pass=value;
                                  if (value.isEmpty) {
                                    Pass_old=false;
                                    Pass_old_notC=true;
                                    return null;
                                  } else {
                                    Pass_old=true;
                                    return null;
                                  }
                                },
                                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600,fontFamily: 'Changa',color: Colors.grey[600],),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey.withOpacity(0.1),
                                  enabledBorder: new OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(30.0),
                                    borderSide:  BorderSide(color:Colors.grey.withOpacity(0.1)),

                                  ),
                                  focusedBorder: new OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(30.0),
                                    borderSide:  BorderSide(color:Colors.grey.withOpacity(0.1)),
                                  ),
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  labelText: "كلمة السر القديمة",
                                  labelStyle:  TextStyle(fontSize: 22.0,fontFamily: 'Changa',color: myFocusNode.hasFocus ? Colors.grey[600] : Colors.grey[600],),
                                  suffixIcon: IconButton(
                                    icon: Icon(_showPassword1 ? Icons.visibility : Icons.visibility_off, color: Colors.grey[600],),
                                    color: Colors.cyan,
                                    onPressed:_togglevisibility1,
                                  ),//
                                ),
                                cursorColor:Colors.grey[600],
                              ),),
                            Pass_old ? Container(
                              margin: EdgeInsets.fromLTRB(255, 0, 0, 0),
                              child: Text('',textAlign:TextAlign.end,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Changa',
                                  color: Colors.red,

                                ),),
                            ): Container(
                              margin: EdgeInsets.fromLTRB(230, 0, 0, 0),
                              child: Text('هذا الحقل مطلوب !',textAlign:TextAlign.end,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Changa',
                                  color: Colors.red,

                                ),),
                            ),

                            Container(margin: EdgeInsets.symmetric(vertical: 5)),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 40),
                              height: 60,
                              child:TextFormField(
                                validator: (value) {
                                  pass=value;
                                  if (value.isEmpty) {
                                    Pass_Null=false;
                                    Pass_S=true;
                                    return null;
                                  } else if (value.length < 8) {
                                    Pass_S=false;
                                    Pass_Null=true;
                                    return null;
                                  }
                                  Pass_Null=true;
                                  Pass_S=true;
                                  return null;
                                },
                                // textDirection: TextDirection.rtl,
                                controller: newpass,
                                obscureText: !_showPassword2,
                                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600,fontFamily: 'Changa',color: Colors.grey[600],),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey.withOpacity(0.1),
                                  enabledBorder: new OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(30.0),
                                    borderSide:  BorderSide(color:Colors.grey.withOpacity(0.1)),

                                  ),
                                  focusedBorder: new OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(30.0),
                                    borderSide:  BorderSide(color:Colors.grey.withOpacity(0.1)),
                                  ),
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  labelText: "كلمة السر الجديدة",
                                  labelStyle:  TextStyle(fontSize: 22.0,fontFamily: 'Changa',color: myFocusNode.hasFocus ? Colors.grey[600] : Colors.grey[600],),
                                  suffixIcon: IconButton(
                                    icon: Icon(_showPassword2 ? Icons.visibility : Icons.visibility_off, color:Colors.grey[600],),
                                    color: Colors.cyan,
                                    onPressed:_togglevisibility2,
                                  ),//

                                ),
                                cursorColor:Colors.grey[600],
                              ),),
                            Pass_Null ? Container(
                              margin: EdgeInsets.fromLTRB(255, 0, 0, 0),
                              child: Text('',textAlign:TextAlign.end,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Changa',
                                  color: Colors.red,

                                ),),
                            ): Container(
                              margin: EdgeInsets.fromLTRB(230, 0, 0, 0),
                              child: Text(' هذا الحقل مطلوب !',textAlign:TextAlign.end,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Changa',
                                  color: Colors.red,

                                ),),
                            ),
                            Container(margin: EdgeInsets.symmetric(vertical: 5.0),),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 40),
                              height: 60,
                              child:TextFormField(
                                obscureText: !_showPassword3,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    Pass_R=false;
                                    Pass_Mismatch=true;
                                    return null;
                                  }else if (value==pass) {
                                    Pass_Mismatch=true;
                                    Pass_R=true;
                                    return null;
                                  } else {
                                    Pass_R=true;
                                    Pass_Mismatch=false;
                                    return null;
                                  }
                                  Pass_Null=true;
                                  return null;
                                },
                                // textDirection: TextDirection.rtl,
                                controller: confirmpass,
                                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600,fontFamily: 'Changa',color: Colors.grey[600],),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey.withOpacity(0.1),
                                  enabledBorder: new OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(30.0),
                                    borderSide:  BorderSide(color:Colors.grey.withOpacity(0.1)),

                                  ),
                                  focusedBorder: new OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(30.0),
                                    borderSide:  BorderSide(color:Colors.grey.withOpacity(0.1)),
                                  ),
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  labelText: "تأكيد كلمة السر",
                                  labelStyle:  TextStyle(fontSize: 22.0,fontFamily: 'Changa',color: myFocusNode.hasFocus ? Colors.grey[600] : Colors.grey[600],),
                                  suffixIcon: IconButton(
                                    icon: Icon(_showPassword3 ? Icons.visibility : Icons.visibility_off, color: Colors.grey[600],),
                                    color: Colors.cyan,
                                    onPressed:_togglevisibility3,
                                  ),//
                                ),
                                cursorColor:Colors.grey[600],
                              ),),
                            Pass_R ? Container(
                              margin: EdgeInsets.fromLTRB(135, 0, 0, 0),
                              child: Text('',textAlign:TextAlign.end,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Changa',
                                  color: Colors.red,

                                ),),
                            ): Container(
                              margin: EdgeInsets.fromLTRB(230, 0, 0, 0),
                              child: Text(' هذا الحقل مطلوب !',textAlign:TextAlign.end,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Changa',
                                  color: Colors.red,

                                ),),
                            ),Container(height: 1,),
                            Pass_old_notC ? Container(
                              margin: EdgeInsets.fromLTRB(255, 0, 0, 0),
                              child: Text('',textAlign:TextAlign.end,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Changa',
                                  color: Colors.red,

                                ),),
                            ): Container(
                              margin: EdgeInsets.fromLTRB(175, 0, 0, 0),
                              child: Text('* كلمة السر القديمة غير صحيحة'
                                ,textAlign:TextAlign.end,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Changa',
                                  color: Colors.red,

                                ),),
                            ),
                            Pass_S ? Container(
                              margin: EdgeInsets.fromLTRB(135, 0, 0, 0),
                              child: Text('',textAlign:TextAlign.end,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Changa',
                                  color: Colors.red,

                                ),),
                            ): Container(
                              margin: EdgeInsets.fromLTRB(110, 0, 0, 0),
                              child: Text('* يجب أن تحتوي كلمة السر 8 أحرف على الأقل',textAlign:TextAlign.end,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Changa',
                                  color: Colors.red,

                                ),),
                            ),
                            Pass_Mismatch ? Container(
                              margin: EdgeInsets.fromLTRB(120, 0, 0, 0),
                              child: Text('',textAlign:TextAlign.end,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Changa',
                                  color: Colors.red,

                                ),),
                            ): Container(
                              margin: EdgeInsets.fromLTRB(210, 0,0, 0),
                              child: Text('* كلمة السر غير متطابقة',textAlign:TextAlign.end,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Changa',
                                  color: Colors.red,

                                ),),
                            ),


                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 130),
                                  width: 150,
                                  child:RaisedButton(
                                    onPressed: () {
                                      setState(() {});
                                      if( Pass_Null &&  Pass_Mismatch && Pass_S &&  Pass_old){
                                        editpassword();
                                      }
                                      if (formKey.currentState.validate()) {print('validate');}
                                      else{print('not validate');}
                                    },
                                    color:Color(0xFFECCB45),
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25)),
                                    child: Text(
                                      "حفظ التعديل",
                                      style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600,fontFamily: 'Changa',color: Colors.white,),
                                    ),
                                  ),),
                                // OutlineButton(
                                //   padding: EdgeInsets.symmetric(horizontal: 50),
                                //   shape: RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.circular(20)),
                                //   onPressed: () {
                                //
                                //
                                //   },
                                //   child: Text("الغاء",
                                //       style: TextStyle(
                                //           fontSize: 14,
                                //           letterSpacing: 2.2,
                                //           color: Colors.purple)),
                                // ),

                              ],
                            )

                          ],), ), ],
                  ),),
              ],),],
        );
      },
    );
  }

  Widget image_profile(){
    return Center(
      child:Stack (children: <Widget>[
        CircleAvatar(
          backgroundImage: image_file==null? NetworkImage('http://'+IP4+'/testlocalhost/upload/'+widget.image):FileImage(File(image_file.path)),
          radius: 35.0,
        ),
        Positioned(
          bottom:-3.0,
          right:-3,
          child: InkWell(
            onTap:(){
              showModalBottomSheet(context: context, builder: (builder) => buttom_camera(),);
            },
            child:Icon(Icons.camera_alt,color:Colors.black45,size: 35.0,),),),
      ],
      ),);
  }
  Widget buttom_camera(){
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
      child: Column(children: <Widget>[
        Text('Choose Profile Photo'),
        SizedBox(height: 20.0,),
        Row(mainAxisAlignment:MainAxisAlignment.center,children: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.camera_alt),
            onPressed: (){
              takePhoto(ImageSource.camera);
            },
            label: Text("Camera"),),
          FlatButton.icon(
            icon: Icon(Icons.image),
            onPressed: (){
              takePhoto(ImageSource.gallery);
            },
            label: Text("Gallery"),),
        ],),
      ],),
    );
  }
  void takePhoto(ImageSource source)async{
    final file =await image_picker.getImage(
      source:source,
    );
    setState((){
      if(file==null){image_file=Image.asset("assets/icons/signup.png") as PickedFile;}
      else{
        image_file=file;
      }
    });
    if(file!=null){
      await editimage();
    }
  }
  Future updatestate()async{
    var url='http://'+IP4+'/testlocalhost/updatestate.php';
    var ressponse=await http.post(url,body: {
      "state": isSwitched1.toString(),
      "phoneworker":widget.phone,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  Future editimage()async {
    _file = File(image_file.path);
    String base64 = base64Encode(_file.readAsBytesSync());
    String imagename = _file.path.split('/').last;
    var url = 'http://' + IP4 + '/testlocalhost/editimage.php';
    var response = await http.post(url, body: {
      "phone":widget.phone,
      "imagename": imagename,
      "image64": base64,
    });
    widget.image=imagename;
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
