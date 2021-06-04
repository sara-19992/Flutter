import 'dart:math';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterphone/WORKER_SANAYEE/Worker_conferm_order.dart';
import 'package:flutterphone/WORKER_SANAYEE/GET_IMGS.dart';
import 'Setting.dart';
import 'package:flutterphone/screens/login_screen.dart';
import 'package:flutterphone/screens/welcome.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutterphone/constants.dart';
import '../constants.dart';
import '../database.dart';
import 'package:flutterphone/Chatworker/chatListworker.dart';

import 'all_post.dart';
import 'homepage.dart';
import 'menue_Page.dart';
import 'odersperson_day.dart';
import 'orders_workers.dart';

String  name="";
String  phone="";
String lat= "";
String lng= "";
String  image="";
String  Work="";
String  Experiance="";
String  Information="";
String  token="";
String namefirst="";
String namelast="";
String IP4="192.168.1.8:8080";

class PROFILE extends StatefulWidget {
  final name;
  final phone;
  final lat;
  final lng;

  PROFILE({this.lat,this.lng,this.name,this.phone});
  _PROFILE createState() =>  _PROFILE();
}
class  _PROFILE extends State< PROFILE> {
  // AnimationController _animationController;
  int _page = 0;
  Future getRate() async {
    var url = 'http://'+IP4+'/testlocalhost/show_Rate.php';
    var ressponse = await http.post(url, body: {
      "phoneworker": widget.phone,
    });
    return json.decode(ressponse.body);
  }
  GlobalKey _bottomNavigationKey = GlobalKey();
  final List1=[];
  var ListDate1=[];
  final List2=[];
  var ListDate2=[];
  List<dynamic>L;
  File _file;
  bool uploading = false;
  double val = 0;
  File uploadimage;
  var path_image="";
  // File _file;
  List<File> _image = []; //هاي هي
  int counter = 0;
  final picker = ImagePicker();
  var mytoken ;
  var commentnumber;
  var postnumber;
  bool AVG1;
  bool AVG2;
  bool AVG3;
  bool AVG4;
  bool AVG5;
  bool AVG6;
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
    name=widget.name;
    lat=widget.lat;
    lng=widget.lng;
    phone=widget.phone;
    getChat();

  }
  Future getWorker()async{
    var url='http://'+IP4+'/testlocalhost/getworker.php';
    var ressponse=await http.post(url,body: {
      "name": widget.name,
    });
    // ignore: deprecated_member_use
      return json.decode(ressponse.body);
    }
  Future getComment() async {
    var url = 'http://' + IP4 + '/testlocalhost/getcomment.php';
    var ressponse = await http.post(url, body: {
      "phone": widget.phone,
    });
    // ignore: deprecated_member_use
    // var responsebody = json.decode(ressponse.body);
    // print(responsebody);

    return json.decode(ressponse.body);
  }
  double roundDouble(double value, int places){
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }
  Future getpost()async{
    var url='http://'+IP4+'/testlocalhost/getpost.php';
    var ressponse=await http.post(url,body: {
      "phone": widget.phone,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  var List_Post=[];
  int _selectedItem = 3;
  @override
  DatabaseMethods databaseMethods=new DatabaseMethods();
  Stream chatsRoom;
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
        //           rippleColor: Colors.grey[100],
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
        //                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => order_worker(Information:Information,Experiance:Experiance,Work:Work,namelast:namelast,name:widget.name,phone:phone,image:image,token:token,namefirst:namefirst,)));
        //               }
        //               if(index==2){
        //                 Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Chat(name_Me:widget.name,chatsRoomList: chatsRoom,Information:Information,Experiance:Experiance,Work:Work,namelast:namelast,phone:phone,image:image,token:token,namefirst:namefirst)));
        //               }
        //               if(index==4){
        //                 DateTime date=DateTime.now();
        //                 Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MenuePage(Information:Information,Experiance:Experiance,Work:Work,namelast:namelast,name:widget.name,phone:phone,image:image,token:token,namefirst:namefirst,)));
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
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => orderpperson_map(name_Me:widget.name,phone_Me:widget.phone,)));
            }
            if(_selectedItem==1){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => order_worker(lat:widget.lat,lng:widget.lng,Information:Information,Experiance:Experiance,Work:Work,namelast:namelast,name:widget.name,phone:phone,image:image,token:token,namefirst:namefirst,)));
            }
            if(_selectedItem==2){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Chat(lat:widget.lat,lng:widget.lng,name_Me:widget.name,chatsRoomList: chatsRoom,Information:Information,Experiance:Experiance,Work:Work,namelast:namelast,phone:phone,image:image,token:token,namefirst:namefirst)));
            }
            if(_selectedItem==4){
              DateTime date=DateTime.now();
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MenuePage(lat:widget.lat,lng:widget.lng,Information:Information,Experiance:Experiance,Work:Work,namelast:namelast,name:widget.name,phone:phone,image:image,token:token,namefirst:namefirst,)));
            }
          },
          defaultSelectedIndex: _selectedItem,
        ),
        backgroundColor:Colors.transparent,
        // appBar: PreferredSize(
        //     preferredSize: Size.fromHeight(40.0), // here the desired height
        //     child: AppBar(
        //       backgroundColor: Color(0xFFECCB45),
        //       elevation: 0.0,
        //       //leading: I,
        //     )
        // ),
        body: Form(
          child:SingleChildScrollView(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 0,
                child:FutureBuilder(
                  future: getpost(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if(snapshot.hasData){
                      return ListView.builder(
                          itemCount:1,
                          itemBuilder: (context, index) {
                            List_Post=snapshot.data;
                            postnumber=snapshot.data.length;
                            return Container(height:0.0,);
                          }
                      );
                    }
                    return Center(child: Text(''));
                  },
                ),
              ),
              Container(
                height: 0,
                margin: EdgeInsets.only(top: 0),
                color: Colors.white,
                child:FutureBuilder(
                  future: getComment(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if(snapshot.hasData){
                      return ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            commentnumber=snapshot.data[index]['count'];
                            return Container();
                          }
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
              Container(
                height: 0,
                color: Colors.transparent,
                child:FutureBuilder(
                  future: getRate(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if(snapshot.hasData){
                      print('MMMMMMMMAAAAAAAAAAAAAAAAAMMMMMMMMMMMOOOOOOOOOOOOOOOO');
                      return ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) {
                           AVG1=double.parse(snapshot.data[index]['AVG1'])>=4?true:false;
                           AVG2=double.parse(snapshot.data[index]['AVG2'])>=4?true:false;
                           AVG3=double.parse(snapshot.data[index]['AVG3'])>=4?true:false;
                           AVG4=double.parse(snapshot.data[index]['AVG4'])>=4?true:false;
                           AVG5=double.parse(snapshot.data[index]['AVG5'])>=4?true:false;
                           AVG6=double.parse(snapshot.data[index]['AVG6'])>=4?true:false;
                          return Container(height:0,);
                        },
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),


              Container(
                height:737,
                margin: EdgeInsets.only(top:0),
                decoration: BoxDecoration(
                  color:Colors.grey[50],
                ),
                child:FutureBuilder(
                  future: getWorker(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if(snapshot.hasData){
                      return ListView.builder(
                        itemCount: 1,
                          itemBuilder: (context, index) {
                          name=snapshot.data[index]['name'];
                          namefirst=snapshot.data[index]['namefirst'];
                          namelast=snapshot.data[index]['namelast'];
                          phone=snapshot.data[index]['phone'];
                          image=snapshot.data[index]['image'];
                          Work=snapshot.data[index]['Work'];
                          Information=snapshot.data[index]['Information'];
                          Experiance=snapshot.data[index]['Experiance'];
                          token=snapshot.data[index]['token'];
                          double Rate=0.0;
                          if(snapshot.data[index]['AVG']!=null){Rate =roundDouble(double.parse(snapshot.data[index]['AVG']),1);}
                         return Profile_worker(AVG6:AVG6,AVG1:AVG1,AVG2:AVG2,AVG3:AVG3,AVG4:AVG4,AVG5:AVG5,List_Post:List_Post,postnumber:List_Post.length,commentnumber:commentnumber,client_num:snapshot.data[index]['Client'],Rate:Rate,name:snapshot.data[index]['name'],namefirst:snapshot.data[index]['namefirst'],namelast:snapshot.data[index]['namelast'],phone:snapshot.data[index]['phone'],image:snapshot.data[index]['image'],Work:snapshot.data[index]['Work'],Experiance:snapshot.data[index]['Experiance'],Information:snapshot.data[index]['Information'],token:snapshot.data[index]['token']);

                          return Container();
                        },
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),],),),),),);



  }}

class Profile_worker  extends StatefulWidget {
  final  name;
  final  namefirst;
  final  namelast;
  final  phone;
  final  image;
  final  Work;
  final  Experiance;
  final  Information;
  final  token;
  final Rate;
  final client_num;
  final commentnumber;
  final postnumber;
  List<dynamic>List_Post;
  final bool AVG1;
  final bool AVG2;
  final bool AVG3;
  final bool AVG4;
  final bool AVG5;
  final bool AVG6;
  Profile_worker({this.AVG1,this.AVG2,this.AVG3,this.AVG4,this.AVG5,this.AVG6,this.List_Post,this.postnumber,this.commentnumber,this.client_num,this.Rate,this.name,this.namelast,this.namefirst, this.phone, this.image, this.Work, this.Experiance, this.Information, this.token,});

  @override
  _Profile_woeker createState() => _Profile_woeker();
}

class _Profile_woeker extends State<Profile_worker> {

  bool image=false;
  bool info=true;
  bool comment=false;
  bool post=false;

  bool uploading = false;
  double val = 0;
  int Post_num=0;
  bool image_post = false;
  File uploadimage;
  var ListPost=[];
  // File _file;
  List<File> _image = []; //هاي هي
  int counter = 0;
  File _file;
  final picker = ImagePicker();
  PickedFile image_file;
  final ImagePicker image_picker = ImagePicker();
  int Length_Post;
  var List_Postanother=[];
  @override
  void initState() {
    super.initState();
  }
   bool zeropost=false;
   bool zeroimage=false;
  bool Show_anatherPost=false;
  bool Show_firstPost=true;
  var List_Another_Post=[];
  Future getImages() async {
    var url = 'http://' + IP4 + '/testlocalhost/Show_EXP.php';
    var ressponse = await http.post(url, body: {
      "phone": widget.phone,
    });
    // ignore: deprecated_member_use
    // var responsebody = json.decode(ressponse.body);
    // print(responsebody);
    return json.decode(ressponse.body);
  }
  Future getComment() async {
    var url = 'http://' + IP4 + '/testlocalhost/getcomment.php';
    var ressponse = await http.post(url, body: {
      "phone": widget.phone,
    });
    // ignore: deprecated_member_use
    // var responsebody = json.decode(ressponse.body);
    // print(responsebody);

    return json.decode(ressponse.body);
  }
  Future getpost()async{
    var url='http://'+IP4+'/testlocalhost/getpost.php';
    var ressponse=await http.post(url,body: {
      "phone": widget.phone,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  Future client()async{
    var url='http://'+IP4+'/testlocalhost/getcountclient.php';
    var ressponse=await http.post(url,body: {
      "phone": widget.phone,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  var ma;
  @override
  Widget build(BuildContext context) {
    // getChat();
    List_Postanother=widget.List_Post;
    print(widget.List_Post.toString());
    return SingleChildScrollView(
      child:Container(
      height: 1500,
      
      color: Colors.white,
      child:Column(
      children:<Widget>[

        // Container(
        //   height: 170,
        //   width: 500,
        //   decoration: BoxDecoration(
        //     color: Colors.black87.withOpacity(0.9),
        //     image: new DecorationImage(
        //       fit: BoxFit.cover,
        //       colorFilter:
        //       ColorFilter.mode(Colors.black87.withOpacity(0.4),
        //           BlendMode.dstATop),
        //       image: new AssetImage('assets/work/cvtop.jpg',),
        //     ),),),
        Container(
          transform: Matrix4.translationValues(0.0, -50.0, 0.0),
          height: 240,
          width: 420,
          child:Image(image:NetworkImage('http://'+IP4+'/testlocalhost/upload/'+widget.image,),fit: BoxFit.cover,),
        ),

        SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top:20),
            height: 1200,
            width: 410,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child:Column(
              children: [
                // Container(
                //   transform: Matrix4.translationValues(0, -60.0, 0),
                //   //transform: Matrix4.translationValues(0, -40.0, 0),
                //   child: Center(
                //     child: CircleAvatar(backgroundImage: NetworkImage(
                //         'http://' + IP4 + '/testlocalhost/upload/' + widget.image),
                //       radius: 45.0,),),
                // ),
                Container(
                  transform: Matrix4.translationValues(0, -55.0, 0),
                  margin: EdgeInsets.only(right: 30),
                  alignment: Alignment.topRight,
                  child: Row(
                    children: [
                      Container(
                        child: Text(widget.namefirst + " " + widget.namelast,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 17.0,
                            fontFamily: 'Changa',
                            fontWeight: FontWeight.bold,),),
                      ),],
                  ),),

                Container(
                  transform: Matrix4.translationValues(0, -60.0, 0),
                  margin: EdgeInsets.only(right: 30),
                  alignment: Alignment.topRight,
                  child:Container(
                    child:Text(widget.Work,style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontFamily: 'Changa',
                      fontWeight: FontWeight.bold,),),
                  ),
                ),
                Container(
                  height:70,
                  transform: Matrix4.translationValues(0, -60.0, 0),
                  child: FutureBuilder(
                      future: client(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          print(
                              "SARAHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHhhhhhhhhh");
                          //_MyHomePageState c= new _MyHomePageState();
                          return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              ma = snapshot.data['count'].toString();
                              return Container_number();
                            },);
                        }
                        return Container(
                          child: Text(''),
                        );
                      }
                  ),
                ),
                Container(
                  width: 370,
                  transform: Matrix4.translationValues(0, -50.0, 0),
                  margin: EdgeInsets.only(right:15,),
                  child:Text(widget.Information + ', ' + widget.Experiance +'.',style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Changa',
                    fontWeight: FontWeight.bold,),),
                ),
                widget.AVG1&&widget.AVG2&&widget.AVG3&&widget.AVG4&&widget.AVG5?Container(
                  height: 70,
                  width: 400,
                  transform: Matrix4.translationValues(0, -20.0, 0),
                  margin: EdgeInsets.only(top: 5,right: 20),
                  child:Wrap(children:[
                    _MyButton(name:'جودة',IS: widget.AVG1,),
                    _MyButton(name:'سرعة وإتقان',IS: widget.AVG2,),
                    _MyButton(name:'احترام',IS: widget.AVG3,),
                    _MyButton(name:'سعر جيد',IS: widget.AVG4,),
                    _MyButton(name:'التزام بالوقت',IS: widget.AVG5,),
                  ]),
                ):Container(height:0.0,),
                widget.AVG1||widget.AVG2||widget.AVG3||widget.AVG4||widget.AVG5?Container(
                  height: 40,
                  width: 400,
                  transform: Matrix4.translationValues(0, -20.0, 0),
                  margin: EdgeInsets.only(top: 5,right: 20),
                  child:Wrap(children:[
                    _MyButton(name:'جودة',IS: widget.AVG1,),
                    _MyButton(name:'سرعة وإتقان',IS: widget.AVG2,),
                    _MyButton(name:'احترام',IS: widget.AVG3,),
                    _MyButton(name:'سعر جيد',IS: widget.AVG4,),
                    _MyButton(name:'التزام بالوقت',IS: widget.AVG5,),
                  ]),
                ):Container(height:0.0,),
                Container(
                  width: 350,
                  height: 5,
                  margin: EdgeInsets.only(top:10),
                  child: Divider(
                    thickness: 1.0,
                    color: Colors.black26.withOpacity(0.1),
                  ),
                ),
                GestureDetector(
                    onTap: ()async{
                      await _dialogCall(context);
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: 120,left: 10,top:15),
                      child:Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 180,left: 3,top:0),
                          child:Text("إضافة منشور",
                            style: TextStyle(
                              color: Y,
                              fontSize: 13.0,
                              fontFamily: 'Changa',
                              fontWeight: FontWeight.bold,
                            ),

                          ),),

                        Container(
                          margin: EdgeInsets.only(left: 5,top:0),
                          child:Icon(Icons.add,size: 18,color: Y,),
                        ),
                      ],)),),

                Container(
                        height: 150,
                        margin:EdgeInsets.only(top:20),
                        child:FutureBuilder(
                          future: getImages(),
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            if(snapshot.hasData){
                              return ListView.builder(
                                  itemCount: 1,
                                  itemBuilder: (context, index) {
                                    int num =snapshot.data.length-4;
                                     var List=[];
                                     List=snapshot.data;
                                     return Images(List);
                                     }

                              );
                            }
                            return Center(child: CircularProgressIndicator());
                          },
                        ),
                      ),


                widget.List_Post.length==0?Container(height:0.0,):Container(height:0.0,),
                widget.List_Post.length==1 && widget.List_Post[0]['image']=='null'? myPosttext(widget.List_Post[0]['text'],widget.List_Post[0]['date']):Container(height:0.0,),
                widget.List_Post.length==1 && widget.List_Post[0]['image']!='null'? myPost(widget.List_Post[0]['text'],widget.List_Post[0]['image'],widget.List_Post[0]['date']):Container(height:0.0,),
                widget.List_Post.length >=2?myPost2():Container(height:0.0,),
                Show_anatherPost?
                Container(
                  // margin: EdgeInsets.only(top: 200),
                  // color: Colors.yellowAccent,
                  child:myPost2another(),
                ):Container(height:0.0,),
                Post_num<=widget.List_Post.length-1?
                GestureDetector(
                  onTap: (){
                    Show_anatherPost=true;
                    Show_firstPost=true;
                    Post_num=0;
                    setState(() {});
                  },
                  child: Container(
                    child: Row(
                      children: [
                        SizedBox(width: 170,),
                        Text('عرض المزيد',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontSize: 13,
                            fontFamily: 'Changa',
                            fontWeight: FontWeight.bold,),),
                        SizedBox(width: 10,),
                        Icon(Icons.refresh,color:Colors.black.withOpacity(0.7),),
                      ],
                    ),
                  ),
                ):Container(),
                //             Container(
                //            margin:EdgeInsets.only(left: 5,right: 200),
                //            decoration: BoxDecoration(
                //             color: Colors.white,),
                //            child:Column(
                //               children: [
                //           GestureDetector(
                //             onTap: (){
                //               Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Post(namelast:widget.namelast,image:widget.image,namefirst:widget.namefirst,phone: widget.phone, name: widget.name)));
                //             },
                //           child: Container(
                //             child: Column(
                //               children: [
                //                 Text('عرض المزيد',
                //                   style: TextStyle(
                //                     color: Colors.black87,
                //                     fontSize: 15.0,
                //                     fontFamily: 'Changa',
                //                     fontWeight: FontWeight.bold,
                //                   ),),
                //               ],
                //             ),
                //           ),
                //         )
                //       ],
                //     )
                // ),

              ],),
                         ),),],
                    ),
                  ),);
  }
  Widget Container_number(){
    return  Center(
      child:Container(
        height: 60,
        width: 410,
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.only(top: 5,left: 0),
        decoration: BoxDecoration(
          //color: Colors.white,
          // border: Border.all(
          //   color: Colors.white,
          // ),
        ),
        child: Row (
          children: [
            SizedBox(width: 30,),
            GestureDetector(
              child:Column(
                children: [
                  Text('منشورات ',style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    fontFamily: 'Changa',
                    fontWeight: FontWeight.bold,),),
                  Text(widget.postnumber.toString()+'   ',style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14.0,
                    fontFamily: 'Changa',
                    fontWeight: FontWeight.bold,),),

                ],
              ),
            ),
            SizedBox(width: 50,),
            GestureDetector(
              child:Column(
                children: [
                  Text('   تعليقات',style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    fontFamily: 'Changa',
                    fontWeight: FontWeight.bold,),),
                  Text('   '+widget.commentnumber,style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14.0,
                    fontFamily: 'Changa',
                    fontWeight: FontWeight.bold,),),

                ],
              ),
            ),
            SizedBox(width: 50,),
            GestureDetector(
              child:Column(
                children: [
                  Text('   عملاء',style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    fontFamily: 'Changa',
                    fontWeight: FontWeight.bold,),),
                  Text('   '+ma.toString(),style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14.0,
                    fontFamily: 'Changa',
                    fontWeight: FontWeight.bold,),),

                ],
              ),
            ),
            SizedBox(width: 50,),
            GestureDetector(
              child:Column(
                children: [
                  Text('  الريت',style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    fontFamily: 'Changa',
                    fontWeight: FontWeight.bold,),),
                  Container(
                    //margin: EdgeInsets.only(top:320,left: 290),
                    child:Row(
                      children: [
                        Text('   '+widget.Rate.toString(),
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14.0,
                            fontFamily: 'Changa',
                            fontWeight: FontWeight.bold,),),
                        Icon(Icons.star,color: Colors.yellow,size: 25.0,),
                      ],
                    ),),

                ],
              ),
            ),

          ],
        ),
      ),);
  }
  Container Images(List<dynamic>Images){
    return Container(
        height:Images.length==0?0:140,
        padding: EdgeInsets.only(top: 10),
        child:Column(
          children: [
            Images.length==1?myAlbum1('http://'+IP4+'/testlocalhost/upload/'+ Images[0]['images']):Container(height: 0.0,),
            Images.length==2?myAlbum2('http://'+IP4+'/testlocalhost/upload/'+ Images[0]['images'],'http://'+IP4+'/testlocalhost/upload/'+ Images[1]['images']):Container(height: 0.0,),
            Images.length>=3?worker_Images('http://'+IP4+'/testlocalhost/upload/'+ Images[0]['images'],'http://'+IP4+'/testlocalhost/upload/'+ Images[1]['images'],'http://'+IP4+'/testlocalhost/upload/'+ Images[2]['images']):Container(height: 0.0,),
          ],
        )
    );
  }
  worker_Images(String Image1,String Image2,String Image3){
    return Container(
      child:SingleChildScrollView(
        child: Row(
          children: [

            Container(
              margin: EdgeInsets.only(left: 10,right: 30),
              child:ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image.network(
                  Image1, height: 100,
                  width: 110,
                  fit: BoxFit.cover,),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5,right: 5),
              child:ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image.network(
                  Image2, height: 100,
                  width: 110,
                  fit: BoxFit.cover,),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>Get_Images(phone:widget.phone,name:widget.name)));
              },
              child: Container(
                margin: EdgeInsets.only(left: 5,right: 5),
                child: Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        Image3, height: 100,
                        width: 110,
                        fit: BoxFit.cover,),
                    ),
                    Positioned(
                      child: Container(
                        height: 100,
                        width: 110,
                        decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: Center(
                          child: Text("عرض كل الصور", style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Changa',
                            fontWeight: FontWeight.bold,
                          ),),
                        ),
                      ),
                    )
                  ],
                ),
                // child:ClipRRect(
                //   borderRadius: BorderRadius.circular(5.0),
                //   child: Image.network(
                //     Image3, height: 120,
                //     width: 160,
                //     fit: BoxFit.cover,),
                // ),
              ),
            ),
          ],
        ),
      ),);
  }
  Widget image_profile() {
    return Center(
      child: Stack(children: <Widget>[

        image_file != null ? Container(
          decoration: BoxDecoration(
            color: Colors.red,
            image: DecorationImage(image: FileImage(File(image_file.path)),
            ),),) : Container(),
        // Container(
        //   child:Backgroundimage_file==null?AssetImage('assets/icons/signup.jpg'):FileImage(File(image_file.path)),
        //    ),
        // CircleAvatar(
        //   backgroundImage: image_file==null? AssetImage('assets/icons/signup.jpg'):FileImage(File(image_file.path)),
        //   //radius: 60.0,
        // ),
        Positioned(
          child: InkWell(
            onTap: () {
              setState(() {
                showModalBottomSheet(
                  context: context, builder: (builder) => buttom_camera(),);
                // showMyDialogPost();
              });
            },
            child: Icon(Icons.camera_alt, color: Colors.grey, size: 35.0,),),),
      ],
      ),);
  }

  Widget buttom_camera() {
    return Container(
      height: 100.0,
      width: MediaQuery
          .of(context)
          .size
          .width,
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(children: <Widget>[
        Text('Choose Profile Photo'),
        SizedBox(height: 20.0,),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.camera_alt),
            onPressed: () {
              takePhoto(ImageSource.camera);
            },
            label: Text("Camera"),),
          FlatButton.icon(
            icon: Icon(Icons.image),
            onPressed: () {
              setState(() {
                takePhoto(ImageSource.gallery);
              });
            },
            label: Text("Gallery"),),
        ],),
      ],),
    );
  }

  void takePhoto(ImageSource source) async {
    final file = await image_picker.getImage(
      source: source,
    );
    setState(() {
      if (file == Null) {
        image_file = Image.asset("assets/icons/signup.png") as PickedFile;
      }
      else {
        image_file = file;
      }
      print(image_file.path);
      //showMyDialogPost();

      //image_profile();
    });
  }

  chooseImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      print(pickedFile.path);
      _image.add(File(pickedFile?.path));

      // uploadFile();
    });
    if (pickedFile.path == null) retrieveLostData();
    image_post = true;
    // uploadFile();
  }

  Future<void> retrieveLostData() async {
    final LostData response = await picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image.add(File(response.file.path));
      });
    } else {
      print(response.file);
    }
  }

  Future uploadFile() async {
    print("hiiii");
    _file = File(_image[counter].path);
    print("hiiii");
    counter++;
    // print(image_file.path);
    if (_file == Null) {
      return;
    }
    print("hiiii");
    String base64 = base64Encode(_file.readAsBytesSync());
    String imagename = _file.path
        .split('/')
        .last;
    print("hiiii");
    print(imagename);
    var url = 'http://' + IP4 + '/testlocalhost/EXP_Image.php';
    // final uri=Uri.parse("http://192.168.2.111/testlocalhost/signup.php");
    var response = await http.post(url, body: {

      "phone": widget.phone,
      "imagename": imagename,
      "image64": base64,
    });
    String massage = json.decode(response.body);
    print(massage);
  }
  myAlbummore(String asset1, String asset2, String asset3, String asset4,
      String more) {
    return Container(
      margin: EdgeInsets.fromLTRB(30,0, 30, 20),
      // padding:EdgeInsets.fromLTRB(5, 0, 5, 0),
      height: 290,
      width: 370,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40.0),
        //border: Border.all(color: MY_BLACK, width: 1.2)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // margin: EdgeInsets.only(top:5,right: 30,),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 10, bottom: 10, top: 10),
                  // margin:  EdgeInsets.only(left:15,right: 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      asset2, height: 110,
                      width: 159,
                      fit: BoxFit.cover,),
                  ),),
                Container(
                  margin: EdgeInsets.all(10),
                  // margin:  EdgeInsets.only(left:10,),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      asset1, height: 110,
                      width: 159,
                      fit: BoxFit.cover,),
                  ),),
              ],
            ),),
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 0, right: 10, bottom: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      asset3, height: 110,
                      width: 110,
                      fit: BoxFit.cover,),
                  ),),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (BuildContext context) =>
                            Get_Images(
                                phone: widget.phone, name: widget.name)));
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 10, bottom: 10),
                    child: Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            asset4, height: 110,
                            width: 209,
                            fit: BoxFit.cover,),
                        ),
                        Positioned(
                          child: Container(
                            height: 110,
                            width: 209,
                            decoration: BoxDecoration(
                                color: Colors.black38,
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: Center(
                              child: Text(more, style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),),
                            ),
                          ),
                        )
                      ],
                    ),),),
              ],),
          ),
        ],),);
  }
  myAlbum4(String asset1, String asset2, String asset3, String asset4) {
    return Container(
      margin: EdgeInsets.fromLTRB(30,0, 30, 20),
      // padding:EdgeInsets.fromLTRB(5, 0, 5, 0),
      height: 250,
      width: 370,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40.0),
          //border: Border.all(color: MY_BLACK, width: 1.2)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // margin: EdgeInsets.only(top:5,right: 30,),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 10, bottom: 10, top: 10),
                  // margin:  EdgeInsets.only(left:15,right: 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      asset2, height: 110,
                      width: 159,
                      fit: BoxFit.cover,),
                  ),),
                Container(
                  margin: EdgeInsets.all(10),
                  // margin:  EdgeInsets.only(left:10,),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      asset1, height: 110,
                      width: 159,
                      fit: BoxFit.cover,),
                  ),),
              ],
            ),),
          Container(
            child: Row(
              children: <Widget>[
                 Container(
                    margin: EdgeInsets.only(right: 10, bottom: 10),
                        child:ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            asset3, height: 110,
                            width: 110,
                            fit: BoxFit.cover,),
                        ),),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      asset4, height: 110,
                      width: 209,
                      fit: BoxFit.cover,),
                  ),),
                      ],
                    ),
          ),
              ],),
        );
  }

  myAlbum3(String asset1, String asset2, String asset3) {
    return Container(
      margin: EdgeInsets.fromLTRB(30,0, 30, 20),
      // padding:EdgeInsets.fromLTRB(5, 0, 5, 0),
      height: 290,
      width: 370,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40.0),
        //border: Border.all(color: MY_BLACK, width: 1.2)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // margin: EdgeInsets.only(top:5,right: 30,),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 10, bottom: 10, top:10),
                  // margin:  EdgeInsets.only(left:15,right: 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      asset2, height: 110,
                      width: 159,
                      fit: BoxFit.cover,),
                  ),),
                Container(
                  margin: EdgeInsets.all(10),
                  // margin:  EdgeInsets.only(left:10,),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      asset1, height: 110,
                      width: 159,
                      fit: BoxFit.cover,),
                  ),),
              ],
            ),),
          Container(
            child: Row(
              children: <Widget>[
                 Container(
                    margin: EdgeInsets.only(right: 10, bottom: 10),
                    child: Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            asset3, height: 110,
                            width: 209,
                            fit: BoxFit.cover,),
                        ),
                      ],
                    ),),
              ],),
          ),
        ],),);
  }
  myAlbum2(String asset1, String asset2) {
    return Container(
      margin: EdgeInsets.fromLTRB(30,0, 30, 20),
      // padding:EdgeInsets.fromLTRB(5, 0, 5, 0),
      height: 180,
      width: 370,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40.0),
        //border: Border.all(color: MY_BLACK, width: 1.2)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // margin: EdgeInsets.only(top:5,right: 30,),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 10, bottom: 10, top: 0),
                  // margin:  EdgeInsets.only(left:15,right: 15),
                  child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          asset1, height: 110,
                          width: 110,
                          fit: BoxFit.cover,),
                      ),),
                Container(
                  margin: EdgeInsets.only(right: 10, bottom: 10, top: 0),
                  child:ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      asset2, height: 110,
                      width: 209,
                      fit: BoxFit.cover,),
                  ),
                ),
                    ],
                  ),
                ),
              ],
      ),);
  }

  myAlbum1(String asset1) {
    return Container(
      margin: EdgeInsets.fromLTRB(30,0, 30, 20),
      // padding:EdgeInsets.fromLTRB(5, 0, 5, 0),
      height: 180,
      width: 370,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40.0),
        //border: Border.all(color: MY_BLACK, width: 1.2)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // margin: EdgeInsets.only(top:5,right: 30,),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 10, bottom: 10, top: 0),
                  // margin:  EdgeInsets.only(left:15,right: 15),
                  child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          asset1, height: 110,
                          width: 159,
                          fit: BoxFit.cover,),
                      ),
                    ),
                  ],),
                ),
              ],
            ),);
  }
  myAlbum0() {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      height: 100,
      width: 400,
      child: Center(child: Text("لا يوجد لديك صور لعرضها",
        style: TextStyle(
          color: Colors.black54,
          fontSize: 17.0,
          fontFamily: 'Changa',
          fontWeight: FontWeight.bold,
        ),),),
     );
  }

  myAlb(String asset) {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      height: 130,
      width: 400,
      child: Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(vertical: 0),
        color: Colors.yellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),),
        shadowColor: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Container(
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context) =>
                              Get_Images(
                                  phone: widget.phone, name: widget.name)));
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 190, bottom: 10, top: 10),
                      child: Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              asset, height: 110,
                              width: 150,
                              fit: BoxFit.cover,),
                          ),
                          Positioned(
                            child: Container(
                              height: 110,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Colors.black38,
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                              child: Center(
                                child: Text("+0", style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),),
                              ),
                            ),
                          )
                        ],
                      ),),),
                ],),
            ),
            // Container(
            //  child:Text("ألبومي "),
            // ),
          ],),),);
  }
  myPosttext(String text,String date){
    return Container(
      width: 360, height: 150,
      margin:EdgeInsets.only(left: 30,right: 30,bottom: 20,top: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 1.0,
            spreadRadius: 1.0,
            offset: Offset(1,1), // shadow direction: bottom right
          )
        ],

      ),
      child:Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top:10,left:10,right: 20),
                //transform: Matrix4.translationValues(0, -40.0, 0),
                child: Center(
                  child: CircleAvatar(backgroundImage: NetworkImage(
                      'http://' + IP4 + '/testlocalhost/upload/' + widget.image),
                    radius: 18.0,),),
              ),
              Column(
                children: [
                  Container(
                    height: 22,
                    margin: EdgeInsets.only(top:10,left: 150),
                    child: Center(
                      child: Text(widget.namefirst + " " + widget.namelast,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14.0,
                          fontFamily: 'Changa',
                          fontWeight: FontWeight.bold,),),
                    ),),
                  Container(
                    height: 20,
                    margin: EdgeInsets.only(top:0,left: 165),
                    child: Center(
                      child: Text(date,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 11.5,
                          fontFamily: 'Changa',
                          fontWeight: FontWeight.bold,),),
                    ),),
                ],
              ),
            ],
          ),
          text!=null?Container(
            height: 50,
            width: 320,
            margin: EdgeInsets.only(top: 5,right: 20,left:0),
            child:Text(text,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 13.0,
                fontFamily: 'Changa',
                fontWeight: FontWeight.bold,
              ),),
          ):Container(height: 0,),
        ],
      ),
    );
  }

  myPost(String text,String image,String date) {
    return Container(
      width: 380, height: 321,
      margin:EdgeInsets.only(left: 30,right: 30,bottom: 20,top: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 1.0,
            spreadRadius: 1.0,
            offset: Offset(1,1), // shadow direction: bottom right
          )
        ],

      ),
      child:Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top:10,left:10,right: 20),
                //transform: Matrix4.translationValues(0, -40.0, 0),
                child: Center(
                  child: CircleAvatar(backgroundImage: NetworkImage(
                      'http://' + IP4 + '/testlocalhost/upload/' + widget.image),
                    radius: 18.0,),),
              ),
              Column(
                children: [
                  Container(
                    height: 22,
                    margin: EdgeInsets.only(top:10,left: 150),
                    child: Center(
                      child: Text(widget.namefirst + " " + widget.namelast,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14.0,
                          fontFamily: 'Changa',
                          fontWeight: FontWeight.bold,),),
                    ),),
                  Container(
                    height: 20,
                    margin: EdgeInsets.only(top:0,left: 165),
                    child: Center(
                      child: Text(date,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 11.5,
                          fontFamily: 'Changa',
                          fontWeight: FontWeight.bold,),),
                    ),),
                ],
              ),
            ],
          ),
          text!=null?Container(
            height: 50,
            width: 320,
            margin: EdgeInsets.only(top: 5,right: 20,left:0),
            child:Text(text,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 13.0,
                fontFamily: 'Changa',
                fontWeight: FontWeight.bold,
              ),),
          ):Container(height: 0,),
          image!='null'?Container(
            width: 380,
            margin: EdgeInsets.only(top: 10),
            alignment: Alignment.centerRight,
            // margin:  EdgeInsets.only(left:10,),
            child: ClipRRect(
              child: Image.network('http://'+IP4+'/testlocalhost/upload/'+  image, height: 204, width: 380, fit: BoxFit.cover,),
            ),):Container(height:0,),
        ],
      ),
    );
  }

  myPost2() {
    Length_Post= widget.List_Post.length;
    print( widget.List_Post.toString());
    return Column(
      children: [
        Post_num<Length_Post?Container(
          child: Column(
            children: [
              widget.List_Post[Post_num]['image']=='null'? myPosttext( widget.List_Post[Post_num]['text'], widget.List_Post[Post_num++]['date']):myPost( widget.List_Post[Post_num]['text'], widget.List_Post[Post_num]['image'], widget.List_Post[Post_num++]['date']),

            ],
          ),
        ):Container(height:10.0,color: Colors.yellowAccent,),
        Post_num<Length_Post?Container(
          child: Column(
            children: [
              widget.List_Post[Post_num]['image']=='null'? myPosttext( widget.List_Post[Post_num]['text'], widget.List_Post[Post_num++]['date']):myPost( widget.List_Post[Post_num]['text'], widget.List_Post[Post_num]['image'], widget.List_Post[Post_num++]['date']),

            ],
          ),
        ):Container(height:0.0,),
      ],
    );
  }

  myPost2another() {
    List_Postanother=widget.List_Post;
    return Column(
      children: [
        Post_num<Length_Post?Container(
          child: Column(
            children: [
              List_Postanother[Post_num]['image']=='null'? myPosttext(List_Postanother[Post_num]['text'],List_Postanother[Post_num++]['date']):myPost(List_Postanother[Post_num]['text'],List_Postanother[Post_num]['image'],List_Postanother[Post_num++]['date']),

            ],
          ),
        ):Container(height:0.0,),
        Post_num<Length_Post?Container(
          child: Column(
            children: [
              List_Postanother[Post_num]['image']=='null'? myPosttext(List_Postanother[Post_num]['text'],List_Postanother[Post_num++]['date']):myPost(List_Postanother[Post_num]['text'],List_Postanother[Post_num]['image'],List_Postanother[Post_num++]['date']),

            ],
          ),
        ):Container(height:0.0,),
        // widget.List_Post[Post_num]['image']=='null'? myPosttext(widget.List_Post[Post_num]['text'],widget.List_Post[Post_num++]['date']):Container(height: 0.0,),
        // Post_num<Length_Post && widget.List_Post[Post_num]['image']!='null'?myPost(widget.List_Post[Post_num]['text'],widget.List_Post[Post_num]['image'],widget.List_Post[Post_num++]['date']):Container(height: 0.0,),
        // Post_num<Length_Post && widget.List_Post[Post_num]['image']=='null'? myPosttext(widget.List_Post[Post_num]['text'],widget.List_Post[Post_num++]['date']):Container(height: 0.0,),
        // Post_num<Length_Post && widget.List_Post[Post_num]['image']!='null'?myPost(widget.List_Post[Post_num]['text'],widget.List_Post[Post_num]['image'],widget.List_Post[Post_num++]['date']):Container(height: 0.0,),

        // widget.List_Post[Post_num]['image']=='null'? myPosttext(widget.List_Post[Post_num]['text'],widget.List_Post[Post_num++]['date']):myPost(widget.List_Post[Post_num]['text'],widget.List_Post[Post_num]['image'],widget.List_Post[Post_num++]['date']),

      ],
    );
  }

  myAlbum2f(String asset1, String asset2) {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 0, 15, 10),
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      height: 130,
      width: 400,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 0),
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),),
        shadowColor: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Container(
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context) =>
                              Get_Images(
                                  phone: widget.phone, name: widget.name)));
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10, bottom: 10, top: 10),
                      child: Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              asset1, height: 110,
                              width: 110,
                              fit: BoxFit.cover,),
                          ),
                          Positioned(
                            child: Container(
                              height: 110,
                              width: 110,
                              decoration: BoxDecoration(
                                  color: Colors.black38,
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                              child: Center(
                                child: Text('معرضي', style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'Changa',
                                  fontWeight: FontWeight.bold,
                                ),),
                              ),
                            ),
                          )
                        ],
                      ),),),
                  Container(
                    margin: EdgeInsets.only(
                        left: 10, right: 10, bottom: 10, top: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        asset2, height: 110,
                        width: 209,
                        fit: BoxFit.cover,),
                    ),),
                ],),
            ),
          ],),
      ),
      // Container(
      //  child:Text("ألبومي "),
      // ),
    );
  }

  // myAlbum3(String asset1, String asset2, String asset3) {
  //   return Container(
  //     margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
  //     padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
  //     height: 250,
  //     width: 400,
  //     child: Card(
  //       elevation: 5,
  //       margin: EdgeInsets.symmetric(vertical: 0),
  //       color: Colors.white,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(20),),
  //       shadowColor: Colors.white,
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           Container(
  //             // margin: EdgeInsets.only(top:5,right: 30,),
  //             child: Row(
  //               children: <Widget>[
  //                 Container(
  //                   margin: EdgeInsets.only(right: 10, bottom: 10, top: 10),
  //                   // margin:  EdgeInsets.only(left:15,right: 15),
  //                   child: ClipRRect(
  //                     borderRadius: BorderRadius.circular(10.0),
  //                     child: Image.network(
  //                       asset2, height: 110,
  //                       width: 159,
  //                       fit: BoxFit.cover,),
  //                   ),),
  //                 Container(
  //                   margin: EdgeInsets.all(10),
  //                   // margin:  EdgeInsets.only(left:10,),
  //                   child: ClipRRect(
  //                     borderRadius: BorderRadius.circular(10.0),
  //                     child: Image.network(
  //                       asset1, height: 110,
  //                       width: 159,
  //                       fit: BoxFit.cover,),
  //                   ),),
  //               ],
  //             ),),
  //           Container(
  //             child: Row(
  //               children: <Widget>[
  //                 GestureDetector(
  //                   onTap: () {
  //                     Navigator.push(context, MaterialPageRoute(
  //                         builder: (BuildContext context) =>
  //                             Get_Images(
  //                                 phone: widget.phone, name: widget.name)));
  //                   },
  //                   child: Container(
  //                     margin: EdgeInsets.only(right: 130, bottom: 10),
  //                     child: Stack(
  //                       overflow: Overflow.visible,
  //                       children: <Widget>[
  //                         ClipRRect(
  //                           borderRadius: BorderRadius.circular(10.0),
  //                           child: Image.network(
  //                             asset3, height: 110,
  //                             width: 209,
  //                             fit: BoxFit.cover,),
  //                         ),
  //                         Positioned(
  //                           child: Container(
  //                             height: 110,
  //                             width: 209,
  //                             decoration: BoxDecoration(
  //                                 color: Colors.black38,
  //                                 borderRadius: BorderRadius.circular(10.0)
  //                             ),
  //                             child: Center(
  //                               child: Text("+0", style: TextStyle(
  //                                 color: Colors.white,
  //                                 fontSize: 20,
  //                               ),),
  //                             ),
  //                           ),
  //                         )
  //                       ],
  //                     ),),),
  //               ],),
  //           ),
  //           // Container(
  //           //  child:Text("ألبومي "),
  //           // ),
  //         ],),),);
  // }

  Future<void> _dialogCall(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return MyDialog(phone:phone,);
        });
  }
}

class MyDialog extends StatefulWidget {
  @override
  final phone;
  MyDialog({this.phone});
  _MyDialogState createState() => new _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {

  String imagePath;
  Image image;
  File image_file;
  TextEditingController text_post =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      actionsPadding: EdgeInsets.zero,
      content: new SingleChildScrollView(
        child: new ListBody(
          children: <Widget>[
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                  width: 70,
                  color: Colors.white,
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 0, right: 170),
                  child:Icon(Icons.close, color: Colors.black.withOpacity(0.5)),
                      ),
              ),
            Container(
              width:500,
              height: 100,
              child: TextFormField(
                textAlign: TextAlign.right,
                controller: text_post,
                maxLines: 20,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16.0,
                  fontFamily: 'Changa',
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  enabledBorder: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                    borderSide:  BorderSide(color:Colors.white),

                  ),
                  focusedBorder: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                    borderSide:  BorderSide(color:Colors.white),

                  ),
                  hintText: 'أضف إعلاناتك هنا ',
                  hintStyle: TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'Changa',
                    color: Colors.black.withOpacity(0.5),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
            ),
            image!= null? Container(
              // width:400,
              // height:200,
              //padding: EdgeInsets.all(50),
                margin: EdgeInsets.only(right:0,left:0,top: 10,bottom: 10),
                child: Container(
                  height: 200,width: 400,
                  child:image,)
            ):Container(),
            GestureDetector(
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 180),
                    Text('إضافة صورة',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontSize: 13.0,
                        fontFamily: 'Changa',
                        fontWeight: FontWeight.bold,
                      ),),
                    Icon(Icons.add_a_photo,color: Colors.black.withOpacity(0.5),),
                  ],
                ),
                onTap: () async {
                  await getImageGallory();
                  setState(() {
                    // print(image.g)

                  });
                }),
            Padding(
              padding: EdgeInsets.all(8.0),
            ),
            SizedBox(height:15),
            Container(
              color: Y,
              child:GestureDetector(
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 60),
                      SizedBox(width: 30),
                      Text('إنشاء منشور',
                        style:  TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Changa',
                          color: MY_BLACK,
                        ),),
                      SizedBox(width: 5),
                    ],
                  ),
                  onTap: () async {
                    senddata();
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => PROFILE(lat:lat,lng:lng,name:name,phone:phone,)));
                  }),),
          ],
        ),
      ),
    );
  }


  Future getImageGallory() async {
    final x = await ImagePicker.pickImage(source: ImageSource.gallery);
    imagePath = x.path;
    image_file = x;
    image = Image(image: FileImage(x),width: 400,height: 150,fit: BoxFit.cover,);
  }

  Future senddata()async{
    if(image==null){
      print("image null");
      DateTime date=DateTime.now();
      var formattedDate = DateFormat('yyyy-MM-dd').format(date);
      var url = 'http://'+IP4+'/testlocalhost/add_post.php';
      var ressponse = await http.post(url, body: {
        "text": text_post.text,
        "phone": widget.phone,
        "imagename": 'null',
        "image64": '',
        "date":formattedDate,
      });
      // String massage= json.decode(ressponse.body);
      // print(massage);
    }
    else{ String base64;
    DateTime date=DateTime.now();
    var formattedDate = DateFormat('yyyy-MM-dd').format(date);
    String imagename;
    File _file = File(image_file.path);
    base64 = base64Encode(_file.readAsBytesSync());
    imagename = _file.path.split('/').last;
    var url = 'http://'+IP4+'/testlocalhost/add_post.php';
    var ressponse = await http.post(url, body: {
      "text": text_post.text,
      "phone": widget.phone,
      "imagename": imagename,
      "image64": base64,
      "date":formattedDate,
    });
    String massage= json.decode(ressponse.body);
    print(massage);
    }
  }

}
class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
class CurvePainter extends CustomPainter {

  bool outterCurve;

  CurvePainter(this.outterCurve);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Color(0xFFF3D657);
    paint.style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width * 0.5, outterCurve ? size.height + 110 : size.height - 110, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
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
class _MyButton extends StatelessWidget {
  _MyButton({Key key, this.name,this.IS}) : super(key: key);
  final String name;
  final bool IS;
  @override
  Widget build(BuildContext context) {
    return IS?Container(
      margin: EdgeInsets.all(6),
      padding: EdgeInsets.symmetric(horizontal:15,vertical:5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Y,
          width: 0.8,
        ),
        borderRadius: BorderRadius.circular(10),
        // color: Colors.white,
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.5),
        //     blurRadius: 2.0,
        //     spreadRadius: 0.0,
        //     offset: Offset(1.0,1.0), // shadow direction: bottom right
        //   )
        // ],
      ),
      child: Text(name,style: TextStyle(
        color: Colors.black.withOpacity(0.7),
        fontSize: 14,
        fontFamily: 'Changa',
        fontWeight: FontWeight.bold,),),
    ):Text('');
  }
}