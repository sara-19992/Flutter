import 'package:carousel_pro/carousel_pro.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterphone/ChatUuser/chatListUser.dart';
import 'package:flutterphone/USER/List_worker_group.dart';
import 'package:flutterphone/USER/WORKER_PROFILE.dart';
import 'package:flutterphone/USER/search_user.dart';
import 'package:flutterphone/USER/taseer.dart';
import 'package:flutterphone/USER/user_reserve_order.dart';
import 'package:flutterphone/screens/login_screen.dart';
import 'package:flutterphone/screens/welcome.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutterphone/constants.dart';
import 'package:rate_my_app/rate_my_app.dart';
import '../constants.dart';
import '../database.dart';
import 'ALL_SERVICE.dart';
import 'favarate.dart';
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

class U_PROFILE extends StatefulWidget {
  final name_Me;
  List<dynamic>Lsist_Post;
  U_PROFILE({this.name_Me,this.Lsist_Post});
  _U_PROFILE createState() =>  _U_PROFILE();
}
class  _U_PROFILE extends State<U_PROFILE> {
  // AnimationController _animationController;
  int _selectedIndex = 0;
  List<String> _filterList;
  var _searchview = new TextEditingController();

  bool _firstSearch = false;
  String _query = "";
  GlobalKey _bottomNavigationKey = GlobalKey();
  final List1 = [];
  var ListDate1 = [];
  final List2 = [];
  var ListDate2 = [];
  var ListBlock=["8.00 - 9.00 ","9.00 - 10.00","","","",];
  var Search=[];
  Future getSearchall()async{
    var url='http://'+IP4+'/testlocalhost/all_worker.php';
    var ressponse=await http.post(url,body: {
    });
    // ignore: deprecated_member_use
    Search= await json.decode(ressponse.body);
    return json.decode(ressponse.body);
  }
  getChat(){
    databaseMethods.getChatsMe(widget.name_Me).then((val){
      setState(() {
        print(val.toString());
        chatsRoom=val;
      });
    });
  }
  var POST=[];
  void initState(){
    super.initState();
    POST=widget.Lsist_Post;
    getChat();
    getSearchall();
    _rateMyApp.init().then((_) {
      if (_rateMyApp.shouldOpenDialog) {
        _rateMyApp.showStarRateDialog(
          context,
          starRatingOptions: StarRatingOptions(

          ),
          actionsBuilder: (context, stars) {
            return [
              // Container(
              //  // height: 131,
              //  //  width: 500,
              //  //  //transform: Matrix4.translationValues(0.0, -200.0, 0.0),
              //  //  decoration: BoxDecoration(
              //  //   color: Colors.transparent,
              //  //  borderRadius: BorderRadius.only(
              //  //  topLeft: Radius.circular(10),
              //  //  topRight: Radius.circular(10),
              //  //  bottomRight:  Radius.circular(10),
              //  //   bottomLeft:  Radius.circular(10),
              //  // ),),
              //  child: Column(
              //    children: [
              //
              //    ],
              //  ),
              // ),
              Stack(
                children: [

                  // GestureDetector(),
                  //  Container(
                  //    height: 50,
                  //    child: FlatButton(
                  //      onPressed: () {
                  //        if (stars != null) {
                  //          print("NULLLLLLLLLLLLLLLlllll");
                  //          _rateMyApp.save().then((v) => Navigator.pop(context));
                  //
                  //          if (stars <= 3) {
                  //            print("User Selected $stars");
                  //          } else if (stars <= 5) {
                  //            print('Leave a Review Dialog');
                  //          }
                  //        } else {
                  //          Navigator.pop(context);
                  //        }
                  //      },
                  //      child: Text('OK'),
                  //    ),
                  //  ),


                  Container(
                    transform: Matrix4.translationValues(0.0, 15.0, 0.0),
                    width: 500,
                    height:50,
                  ),
                  Container(
                    transform: Matrix4.translationValues(0.0, 15, 0.0),
                    width: 500,
                    height: 1,
                    child: Divider(
                      color: Colors.black54,
                      thickness: 0.2,
                    ),
                  ),
                  Container(
                      height: 65,
                      transform: Matrix4.translationValues(0.0,10.0, 20.0),
                      child: Row(
                        children: [
                          Container(
                            width: 175,
                            height: 65,
                            margin: EdgeInsets.only(bottom:30),
                            transform: Matrix4.translationValues(0.0,15.0, 0.0),
                            child:GestureDetector(
                              onTap: () {Navigator.pop(context);},
                              child: Center(
                                child:Text('ليس الأن',style:
                                TextStyle(
                                  fontFamily: 'Changa',
                                  color:Y,
                                  // backgroundColor: Colors.grey,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),),
                              ),
                            ),
                          ),
                          Container(
                            width: 2,
                            height: 50,
                            margin: EdgeInsets.only(bottom:5),
                            child: VerticalDivider(
                              color: Colors.black54,
                              thickness: 0.2,
                            ),
                          ),
                          Container(
                            width: 160,
                            height: 65,
                            margin: EdgeInsets.only(bottom:30),
                            transform: Matrix4.translationValues(0.0,15.0, 0.0),
                            child:GestureDetector(
                              onTap: () {
                                if (stars != null) {
                                  print("NULLLLLLLLLLLLLLLlllll");
                                  _rateMyApp.save().then((v) => Navigator.pop(context));

                                  if (stars <= 3) {
                                    print("User Selected $stars");
                                  } else if (stars <= 5) {
                                    print('Leave a Review Dialog');
                                  }
                                } else {
                                  Navigator.pop(context);
                                }
                              },
                              child:Center(
                                child:Text('تقييم',style:
                                TextStyle(
                                  fontFamily: 'Changa',
                                  color:Y,
                                  // backgroundColor: Colors.grey,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),),
                              ),
                            ),
                          ),
                        ],
                      )
                  ),
                  Container(
                    height: 60,
                    transform: Matrix4.translationValues(0.0, -200.0, 0.0),
                    child:Center(
                      child:Image.asset('assets/work/house-reforms.png', height: 60,
                        width: 60,
                        // color: Colors.white,
                        fit: BoxFit.contain,),),

                  ),
                ],
              ),

            ];
          },
          title: "هل أعجبك تطبيق صنايعي ؟",
          message: "اضغط على النجم لتقييم صنايعي في متجر التطبيقات  ",
          dialogStyle: DialogStyle(
              messageStyle: TextStyle(
                fontFamily: 'Changa',
                color: Colors.black54,
                // backgroundColor: Colors.grey,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
              titleStyle: TextStyle(
                fontFamily: 'Changa',
                color: Colors.black87,
                // backgroundColor: Colors.grey,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
              titleAlign: TextAlign.center,
              messageAlign: TextAlign.center,
              titlePadding:EdgeInsets.only(top: 90.0),
              messagePadding: EdgeInsets.only(top: 10.0,bottom: 20)

          ),

        );
      }
    });

  }
  Future getUser() async {
    var url = 'http://' + IP4 + '/testlocalhost/getUser.php';
    var ressponse = await http.post(url, body: {
      "name": widget.name_Me,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  // _U_PROFILE() {
  //   //Register a closure to be called when the object changes.
  //   _searchview.addListener(() {
  //     if (_searchview.text.isEmpty) {
  //       //Notify the framework that the internal state of this object has changed.
  //       setState(() {
  //         _firstSearch = true;
  //         _query = "bvn";
  //       });
  //     } else {
  //       setState(() {
  //         _firstSearch = false;
  //         _query = _searchview.text;
  //       });
  //     }
  //   });
  // }
  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  RateMyApp _rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 3,
    minLaunches: 7,
    remindDays: 2,
    remindLaunches: 5,
    // appStoreIdentifier: '',
    // googlePlayIdentifier: '',
  );
  int _selectedItem=0;
  DatabaseMethods databaseMethods=new DatabaseMethods();
  Stream chatsRoom;
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Directionality(textDirection: TextDirection.rtl,
      child:Stack(
        children: [
      Scaffold(
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
        //                 Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => U_PROFILE(name_Me: widget.name_Me,)));
        //               }
        //               if(index==1){
        //                 print(phone+"PHONE");
        //                 Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => user_reserve_order(username: widget.name_Me,phoneuser: phone,namelast:namelast,image:image,token:token,namefirst:namefirst)));
        //               }
        //               if(index==2){
        //                 Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Chat(name_Me:widget.name_Me,chatsRoomList: chatsRoom,phone:phone,namelast:namelast,image:image,token:token,namefirst:namefirst)));
        //               }
        //               if(index==3){
        //                 Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => favarate(username: widget.name_Me,phoneuser: phone,namelast:namelast,image:image,token:token,namefirst:namefirst)));
        //               }
        //               if(index==4){
        //                 Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MenuePage(namelast:namelast,name:widget.name_Me,phone:phone,image:image,token:token,namefirst:namefirst)));
        //               }
        //
        //
        //
        //             });
        //           }
        //           ),
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
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => U_PROFILE(name_Me: widget.name_Me,Lsist_Post:widget.Lsist_Post,)));
            }
            if(_selectedItem==1){
              print(phone+"PHONE");
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => user_reserve_order(index:'0',Lsist_Post:widget.Lsist_Post,username: widget.name_Me,phoneuser: phone,namelast:namelast,image:image,token:token,namefirst:namefirst)));
            }
            if(_selectedItem==2){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Chat(Lsist_Post:widget.Lsist_Post,name_Me:widget.name_Me,chatsRoomList: chatsRoom,phone:phone,namelast:namelast,image:image,token:token,namefirst:namefirst)));
            }
            if(_selectedItem==3){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => favarate(Lsist_Post:widget.Lsist_Post,username: widget.name_Me,phoneuser: phone,namelast:namelast,image:image,token:token,namefirst:namefirst)));
            }
            if(_selectedItem==4){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MenuePage(Lsist_Post:widget.Lsist_Post,namelast:namelast,name:widget.name_Me,phone:phone,image:image,token:token,namefirst:namefirst)));
            }
          },
          defaultSelectedIndex: _selectedItem,
        ),
       // backgroundColor:PURPEL,
       //  appBar: PreferredSize(
       //      preferredSize: Size.fromHeight(1.0), // here the desired height
       //      child: AppBar(
       //        backgroundColor: A,
       //        elevation: 0.0,
       //        actions: [],
       //        titleSpacing: 0,
       //        automaticallyImplyLeading: false,
       //        //leading: I,
       //      )
       //  ),
        body: Form(
         child:SingleChildScrollView(
          child: Stack(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Container(
                  height: 210.0,
                  width: 450.0,
                  child: Carousel(
                    boxFit: BoxFit.cover,
                    indicatorBgPadding: 10,
                    images: [
                      ExactAssetImage("assets/work/s1.png"),
                      ExactAssetImage("assets/work/s2.png"),
                      ExactAssetImage("assets/work/s4.png")
                    ],
                  )
              ),
             Container(
                height: 600,
                margin: EdgeInsets.only(top: 210),
                decoration: BoxDecoration(
                  // color:  Colors.grey[50],
                 // color:  YSD.withOpacity(0.1),
                  color: Colors.grey[50],
                  // color:Color(0xFF1C1C1C),
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(50),
                  //   topRight: Radius.circular(50),
                  // ),
                ),
                child: FutureBuilder(
                  future: getUser(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          name = snapshot.data[index]['name'];
                          phone = snapshot.data[index]['phone'];
                          image = snapshot.data[index]['image'];
                          namefirst = snapshot.data[index]['namefirst'];
                          namelast = snapshot.data[index]['namelast'];
                          token = snapshot.data[index]['token'];

                            return USER_PROFILE(Post:POST,Search:Search,country: snapshot.data[index]['country'],name_Me: snapshot.data[index]['name'], namefirst: snapshot.data[index]['namefirst'], namelast: snapshot.data[index]['namelast'], phone: snapshot.data[index]['phone'], image: snapshot.data[index]['image'], token: snapshot.data[index]['token']);

                        },
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],),),),),],),);
  }
}
class USER_PROFILE  extends StatefulWidget {
  final  name_Me;
  final  namefirst;
  final  namelast;
  final  phone;
  final  image;
  final  token;
  final country;
  List<dynamic>Search;
  List<dynamic>Post;
  USER_PROFILE({this.Post,this.Search,this.country,this.name_Me,this.namelast,this.namefirst, this.phone, this.image,this.token,});

  @override
  _USER_PROFILE createState() => _USER_PROFILE();
}

class _USER_PROFILE extends State<USER_PROFILE> {
  bool uploading = false;
  double val = 0;
  File uploadimage;
  bool image =false;
  // File _file;
  List<File> _image = []; //هاي هي
  int counter = 0;
  File _file;
  final picker = ImagePicker();
  var Listsearch=[];
  List<String> _filterList;
  var _searchview = new TextEditingController();
  Future getpost()async{
    var url='http://'+IP4+'/testlocalhost/post_profile.php';
    var ressponse=await http.get(url);
    // // ignore: deprecated_member_use
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);

  }
  bool _firstSearch = true;
  String _query = "";
  _USER_PROFILE() {
    //Register a closure to be called when the object changes.
    _searchview.addListener(() {
      if (_searchview.text.isEmpty) {
        //Notify the framework that the internal state of this object has changed.
        setState(() {
          _firstSearch = true;
          _query = "bvn";
        });
      } else {
        setState(() {
          _firstSearch = false;
          _query = _searchview.text;
        });
      }
    });
  }
  Future getdata()async{
    var url='http://'+IP4+'/testlocalhost/all_worker.php';
    var ressponse=await http.get(url);
    var responsepody= json.decode(ressponse.body);
    for(int i=0;i<responsepody.length;i++){
      if(!Listsearch.contains(responsepody[i]['Work'])){ Listsearch.add(responsepody[i]['Work']);}

    }
  }
  DatabaseMethods databaseMethods=new DatabaseMethods();
  Stream chatsRoom;
  getChat(){
    databaseMethods.getChatsMe(widget.name_Me).then((val){
      setState(() {
        print(val.toString());
        chatsRoom=val;
      });
    });
  }
  @override
  void initState() {
    super.initState();
    getdata();
    getpost();
    // getChat();
  }


  @override
  Widget build(BuildContext context) {
     getChat();
    return Stack(
        children:<Widget>[

          // Container(
          //   margin: EdgeInsets.only(top:10),
          //   child:IconButton(
          //   onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Chat(name_Me:widget.name_Me,chatsRoomList: chatsRoom,user: true)));},
          //   icon: Icon(Icons.chat_bubble),
          //   ),),
          // Container(
          //   margin: EdgeInsets.only(top:20,left: 300),
          //   //transform: Matrix4.translationValues(0, 5.0, 0),
          //     child:CircleAvatar(backgroundImage: NetworkImage('http://'+IP4+'/testlocalhost/upload/'+widget.image),radius: 25.0,),
          // ),
          // Container(
          //   margin: EdgeInsets.only(top:20,left: 100),
          //   child:Center(
          //     child: Text(widget.namefirst+ " "+widget.namelast,
          //       style: TextStyle(
          //         color: Colors.black,
          //         fontSize: 15.0,
          //         fontFamily: 'Changa',
          //         fontWeight: FontWeight.bold,),),
          //   ),),

          // Container(
          //   //margin: EdgeInsets.only(bottom: 5),
          //   transform: Matrix4.translationValues(0.0, -20.0, 0.0),
          //   child:GestureDetector(
          //     onTap: (){showSearch(context: context, delegate: DataSearch(list: Listsearch,name_Me:widget.name_Me));},
          //     child: Container(
          //       width: 360,
          //       alignment: Alignment.center,
          //       // margin: EdgeInsets.symmetric(horizontal: 40),
          //       //  padding: EdgeInsets.symmetric(horizontal: 40),
          //       height: 54,
          //       decoration: BoxDecoration(
          //         color:D,
          //         borderRadius: BorderRadius.circular(20),
          //         // boxShadow: [
          //         //   BoxShadow(
          //         //     offset: Offset(0, 1),
          //         //     blurRadius: 20,
          //         //     color: Color(0xFFECCB45),
          //         //   ),
          //         // ],
          //       ),
          //       child: Row(
          //         children: <Widget>[
          //           Container(
          //             margin: EdgeInsets.only(left: 240,right: 20),
          //             child:Text('ابحث',
          //               style: TextStyle(
          //                 fontFamily: 'Changa',
          //                 color: Colors.white,
          //                 fontSize: 20.0,
          //                 fontWeight: FontWeight.bold,
          //               ),),
          //           ),
          //           Container(
          //             margin: EdgeInsets.only(top: 10),
          //             child:RotatedBox(
          //               quarterTurns: 1,
          //               child: IconButton(
          //                 icon: Icon(
          //                   Icons.search,
          //                   color:Colors.white,
          //                   size: 40.0,
          //                 ),
          //                 onPressed: null,
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),),
          //   ),
          // ),
          SingleChildScrollView(
              child: Container(
                transform: Matrix4.translationValues(0.0, -50.0, 0.0),
              margin: EdgeInsets.only(top:0),
             height: 1000,
             width: 500,
             child: Stack(
              children: [
              Container(
                margin: EdgeInsets.only(top:110),
              child:Column(
              children:[
              // Container(
              //   child:Row(
              //     children: [
              //       Container(
              //         margin: EdgeInsets.only(right: 35,),
              //         child: Text('اختر خدمة',
              //           style: TextStyle(
              //           fontFamily: 'Changa',
              //           color: Colors.black87,
              //           fontSize: 15.0,
              //           fontWeight: FontWeight.bold,
              //         ),),
              //       ),
              //     ],
              //   ),
              //   ),
              Container(
                color: Colors.grey[50],
                margin: EdgeInsets.only(top: 0,right: 22,left: 20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      RecomendPlantCard1(
                        image: "assets/work/mec.png",
                        title: "ميكانيكي",
                        press: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Search_user(country:widget.country,token_Me:widget.token,work: 'أقفال',name_Me: widget.name_Me,location: widget.country,namefirst_Me:widget.namefirst,nameLast_Me:widget.namelast,phone_Me: widget.phone,image_Me: widget.image,),),);
                        },
                      ),
                      SizedBox(width: 3,),
                      RecomendPlantCard2(
                        image: "assets/work/najar.png",
                        title: "نجار",
                        press: () {
                          print(widget.phone); print(widget.name_Me); print(widget.phone);
                          print(widget.token);
                          print(widget.country);
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp1()));
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Search_user(country:widget.country,token_Me:widget.token,work: 'نجار',name_Me: widget.name_Me,location: widget.country,namefirst_Me:widget.namefirst,nameLast_Me:widget.namelast,phone_Me: widget.phone,image_Me: widget.image,),),);
                        },
                      ),
                      SizedBox(width: 3,),
                      RecomendPlantCard3(
                        image: "assets/work/ele.png",
                        title: "كهربائي",
                        press: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Search_user(country:widget.country,token_Me:widget.token,work: 'كهربائي',name_Me: widget.name_Me,location: widget.country,namefirst_Me:widget.namefirst,nameLast_Me:widget.namelast,phone_Me: widget.phone,image_Me: widget.image,),),);
                        },
                      ),
                      SizedBox(width: 3,),
                      RecomendPlantCard4(
                        image: "assets/work/bal.png",
                        title: "بلييط",
                        press: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Search_user(country:widget.country,token_Me:widget.token,work: 'بلييط',name_Me: widget.name_Me,location: widget.country,namefirst_Me:widget.namefirst,nameLast_Me:widget.namelast,phone_Me: widget.phone,image_Me: widget.image,),),);
                        },
                      ),
                      SizedBox(width: 5,),
                      RecomendPlantCard5(
                        image: "assets/work/sabak.png",
                        title: "سباك",
                        press: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Search_user(country:widget.country,token_Me:widget.token,work: 'سباك',name_Me: widget.name_Me,location: widget.country,namefirst_Me:widget.namefirst,nameLast_Me:widget.namelast,phone_Me: widget.phone,image_Me: widget.image,),),);
                        },
                      ),

                    ],
                  ),

                ),
              ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => All_Service(token:widget.token,name_Me: widget.name_Me,phone: widget.phone,country: widget.country,namefirst:widget.namefirst,namelast:widget.namelast,image: widget.image)));
                  },
                  child: Container(
                    height: 30,
                    margin: EdgeInsets.only(right: 300,),
                    child: Text('عرض المزيد',
                      style: TextStyle(
                        fontFamily: 'Changa',
                        color: Colors.black54,
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                      ),),
                  ),
                ),
            ],
           ),
           ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => user_taseer_order(country:widget.country,token:widget.token,username: widget.name_Me,namefirst:widget.namefirst,namelast:widget.namelast,phoneuser: widget.phone,image: widget.image,),),);
                    },
                    child:Container(
                    width: 370, height: 165,
                    margin:EdgeInsets.only(left: 3,right:20,bottom: 0,top: 320),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.black87,
                      //     blurRadius: 1,
                      //     offset: Offset(0,0.5), // shadow direction: bottom right
                      //   )
                      // ],
                    ),
                    child:Column(
                      children: [
                        Container(
                          width: 370, height: 120,
                          child:  Row(
                            children: [
                              Container(
                                height: 100,
                                width: 50,
                                margin: EdgeInsets.only(top:0,right:20),
                                child: Image.asset(
                                  "assets/work/price.png", height: 50,
                                  width: 50,
                                  // color: Colors.white,
                                  fit: BoxFit.contain,),
                              ),
                              Container(
                                height: 100,
                                width: 250,
                                margin: EdgeInsets.only(top:30,right: 20),
                                child: Text('يمكنك أن تقدم طلب تسعير لطلبك ثم اختار الأنسب إليك والأفضل سعرا لك ',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14,
                                    fontFamily: 'Changa',
                                    fontWeight: FontWeight.bold,),),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          child:Container(
                            width: 100,
                            height: 30,
                            margin: EdgeInsets.only(right:220,top:0),
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
                              child:Text('طلب تسعير',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 13.0,
                                  fontFamily: 'Changa',
                                  fontWeight: FontWeight.bold,),),
                            ),
                          ),
                        ),
                      ],
                    ),

                  ),
                ),
                // Container(
                //   height:1600,
                //   width: 370,
                //   margin: EdgeInsets.only(top:480,left:5,right:20),
                //   //color:Colors.red,
                //   child:ListView.builder(
                //   itemCount:widget.Post.length,
                //  itemBuilder: (context, index) {
                //     if(widget.Post[index]['imagepost']=='null'){
                //       return myPosttext(widget.Post[index]['text'],widget.Post[index]['date'],widget.Post[index]['image'],widget.Post[index]['namefirst'],widget.Post[index]['namelast'],);
                //     }
                //     else{
                //       return myPost(widget.Post[index]['text'], widget.Post[index]['imagepost'], widget.Post[index]['date'],widget.Post[index]['image'],widget.Post[index]['namefirst'],widget.Post[index]['namelast'],);
                //     }
                //  },),
                // ),
                new Container(
                  margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 0),
                  child: new Column(
                    children: <Widget>[
                      _createSearchView(),
                      _firstSearch ? Text('') : _performSearch()
                    ],
                  ),
                ),
              ],),
    ),
    ),
        ],);
  }
  myPost(String text,String image,String date,String imageworker,String namefirst,String namelast) {
    return Container(
      width: 370, height: 321,
      margin:EdgeInsets.only(left: 3,right: 3,bottom: 20,top: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black87,
            blurRadius: 0.8,
            offset: Offset(0,1), // shadow direction: bottom right
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
                      'http://' + IP4 + '/testlocalhost/upload/' + imageworker),
                    radius: 18.0,),),
              ),
              Column(
                children: [
                  Container(
                    height: 22,
                    margin: EdgeInsets.only(top:10,left: 150),
                    child: Center(
                      child: Text(namefirst + " " + namelast,
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
  myPosttext(String text,String date,String imageworker,String namefirst,String namelast){
    return Container(
      width: 370, height: 150,
      margin:EdgeInsets.only(left: 3,right: 3,bottom: 20,top: 5),
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
            color: Colors.black87,
            blurRadius: 1,
            offset: Offset(0,0.5), // shadow direction: bottom right
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
                      'http://' + IP4 + '/testlocalhost/upload/' + imageworker),
                    radius: 18.0,),),
              ),
              Column(
                children: [
                  Container(
                    height: 22,
                    margin: EdgeInsets.only(top:10,left: 150),
                    child: Center(
                      child: Text(namefirst + " " + namelast,
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
  Widget _createSearchView() {

    return new Container(
      height: 55,
      width: 410,
      margin: EdgeInsets.only(top: 30,left: 10),
      padding: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.5),
        //     blurRadius: 2.0,
        //     spreadRadius: 0.0,
        //     offset: Offset(1.0,1.0), // shadow direction: bottom right
        //   )
        // ],
      ),
      // decoration: BoxDecoration(border: Border.all(width: 1.0)),
      child: new TextField(
        controller: _searchview,
        cursorColor:Y,
        scrollPadding: EdgeInsets.only(top:7),
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Changa',
        ),
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: "ابحث",
          hintStyle: new TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Changa',
          ),
          enabledBorder: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(15.0),
            borderSide:  BorderSide(color:Colors.grey[300]),

          ),
          focusedBorder: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(15.0),
            borderSide:  BorderSide(color:Colors.grey[300]),

          ),
          suffixIcon: GestureDetector(
            onTap: () {
            },
            child:  Container(
              // margin: EdgeInsets.only(top: 5),
              child:RotatedBox(
                quarterTurns: 1,
                child: IconButton(
                  icon: Icon(
                    Icons.search,
                    color:Colors.black54,
                    size: 25.0,
                  ),
                  onPressed: null,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _performSearch() {
    _filterList = new List<String>();
    for (int i = 0; i < widget.Search.length; i++) {
      var item = widget.Search[i]['Work'];

      if (item.toLowerCase().contains(_query.toLowerCase())) {
        if(!_filterList.contains(item)){_filterList.add(item);}
      }
    }
    return _createFilteredListView();
  }
  //Create the Filtered ListView
  Widget _createFilteredListView() {

    return new Stack(
      children:[
        SingleChildScrollView(
          child:Directionality(textDirection: TextDirection.ltr,
            child:Container(
              width: 370,
              height: 130,
              margin:EdgeInsets.only(left: 10,right: 10,top:4),
              alignment: Alignment.topRight,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0,0.5),
                    blurRadius: 0.01,
                    color: Colors.black54,
                  ),],
              ),
              child: new ListView.builder(
                  padding: EdgeInsets.only(top: 8.0),
                  itemCount: _filterList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Search_user(country:widget.country,token_Me:widget.token,work:_filterList[index],name_Me: widget.name_Me,location: widget.country,namefirst_Me:widget.namefirst,nameLast_Me:widget.namelast,phone_Me: widget.phone,image_Me: widget.image,),),);MaterialPageRoute(builder: (context) => user_worker(phoneuser:widget.phone,tokenuser:widget.token,Work:Listsearch[index]['Work'],image:Listsearch[index]['image'],phone:Listsearch[index]['phone'],name: Listsearch[index]['name'],namelast:Listsearch[index]['namelast'],name_Me: widget.name_Me,namefirst:Listsearch[index]['namefirst'],token:Listsearch[index]['token'],Information:Listsearch[index]['Information'],Experiance:Listsearch[index]['Experiance'],),);
                      },
                      child:  Container(
                        alignment: Alignment.topRight,
                        color: Colors.white,
                        width: 200,
                        margin: EdgeInsets.only(right: 10,top:7),
                        child: new Text("${_filterList[index]}",
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Changa',
                            color: Colors.black54,
                          ),),
                      ),
                    );
                  }),
            ),),),],);
  }
}

class post  extends StatefulWidget {


  @override
  _post createState() => _post();
}

class _post extends State<post> {

  Future getpost()async{
    var url='http://'+IP4+'/testlocalhost/post_profile.php';
    var ressponse=await http.get(url);
    // // ignore: deprecated_member_use
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);

  }
  @override
  Widget build(BuildContext context) {
    Container(
      height: 500,
      margin: EdgeInsets.only(top: 210),
      decoration: BoxDecoration(
        color:  Colors.grey[50],
        // color:Color(0xFF1C1C1C),
        // borderRadius: BorderRadius.only(
        //   topLeft: Radius.circular(50),
        //   topRight: Radius.circular(50),
        // ),
      ),
      child: FutureBuilder(
        future: getpost(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Container(height:100,color:Colors.red,);

              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
  // myPost(String text,String image,String date) {
  //   return Container(
  //     width: 380, height: 321,
  //     margin:EdgeInsets.only(left: 30,right: 30,bottom: 20,top: 5),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(10),
  //         topRight: Radius.circular(10),
  //       ),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.grey,
  //           blurRadius: 1.0,
  //           spreadRadius: 1.0,
  //           offset: Offset(1,1), // shadow direction: bottom right
  //         )
  //       ],
  //
  //     ),
  //     child:Column(
  //       children: [
  //         Row(
  //           children: [
  //             Container(
  //               margin: EdgeInsets.only(top:10,left:10,right: 20),
  //               //transform: Matrix4.translationValues(0, -40.0, 0),
  //               child: Center(
  //                 child: CircleAvatar(backgroundImage: NetworkImage(
  //                     'http://' + IP4 + '/testlocalhost/upload/' + widget.image),
  //                   radius: 18.0,),),
  //             ),
  //             Column(
  //               children: [
  //                 Container(
  //                   height: 22,
  //                   margin: EdgeInsets.only(top:10,left: 150),
  //                   child: Center(
  //                     child: Text(widget.namefirst + " " + widget.namelast,
  //                       style: TextStyle(
  //                         color: Colors.black87,
  //                         fontSize: 14.0,
  //                         fontFamily: 'Changa',
  //                         fontWeight: FontWeight.bold,),),
  //                   ),),
  //                 Container(
  //                   height: 20,
  //                   margin: EdgeInsets.only(top:0,left: 165),
  //                   child: Center(
  //                     child: Text(date,
  //                       style: TextStyle(
  //                         color: Colors.black54,
  //                         fontSize: 11.5,
  //                         fontFamily: 'Changa',
  //                         fontWeight: FontWeight.bold,),),
  //                   ),),
  //               ],
  //             ),
  //           ],
  //         ),
  //         text!=null?Container(
  //           height: 50,
  //           width: 320,
  //           margin: EdgeInsets.only(top: 5,right: 20,left:0),
  //           child:Text(text,
  //             style: TextStyle(
  //               color: Colors.black87,
  //               fontSize: 13.0,
  //               fontFamily: 'Changa',
  //               fontWeight: FontWeight.bold,
  //             ),),
  //         ):Container(height: 0,),
  //         image!='null'?Container(
  //           width: 380,
  //           margin: EdgeInsets.only(top: 10),
  //           alignment: Alignment.centerRight,
  //           // margin:  EdgeInsets.only(left:10,),
  //           child: ClipRRect(
  //             child: Image.network('http://'+IP4+'/testlocalhost/upload/'+  image, height: 204, width: 380, fit: BoxFit.cover,),
  //           ),):Container(height:0,),
  //       ],
  //     ),
  //   );
  // }

}
class RecomendPlantCard extends StatelessWidget {
  const RecomendPlantCard({
    Key key,
    this.image,
    this.title,
    this.press,
  }) : super(key: key);

  final String image, title;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(left: 10, top: 10, bottom: 10,right: 0),
      width: 111,
      height: 130,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: press,
            child: Container(
              height: 130,
              // padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color:Colors.grey[50],
                borderRadius: BorderRadius.circular(29),
                // boxShadow: [
                //   BoxShadow(
                //     offset: Offset(0, 10),
                //     blurRadius: 50,
                //     color:Color(0xFF1C1C1C),
                //   ),
                // ],
              ),
              child: Container(
                child:Stack(
                  children:<Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(29),
                      child: Image.asset(
                        image, height: 90,
                        width: 100,
                        fit: BoxFit.contain,),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 85),
                      child:Center(
                        child:Text(title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Changa',
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),),),
                  ],),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RecomendPlantCard1 extends StatelessWidget {
  RecomendPlantCard1({
    Key key,
    this.image,
    this.title,
    this.press,
  }) : super(key: key);

  final String image, title;
  final Function press;

  @override
  Widget build(BuildContext context) {
    List<Colors> Color=[];
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),
      width: 110,
      height: 120,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: press,
            child:Stack(
              children:<Widget>[
                // Icon(Icons.paint),
                Container(
                  width: 160,
                 height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                    color: Colors.grey.withOpacity(0.06),
                    // gradient: LinearGradient(
                    //     begin: Alignment.topLeft,
                    //     end: Alignment.bottomRight,
                    //     colors: [Y,Y5]
                    // ),
                  ),
                 child:  Center(
                   child:Column(
                     children: [
                       Container(
                         height: 75,
                         width: 110,
                         margin: EdgeInsets.only(top: 0),
                         child:ClipRRect(
                           borderRadius: BorderRadius.circular(5),
                           child: Image.asset(
                             image, height: 70,
                             width: 110,
                             // color: Colors.white,
                             fit: BoxFit.contain,),
                         ),),
                       Container(
                         margin: EdgeInsets.only(top: 10),
                         child:Center(
                           child:Text(title,
                             textAlign: TextAlign.center,
                             style: TextStyle(
                               fontFamily: 'Changa',
                               color: Colors.black87,
                               fontSize: 14.0,
                               fontWeight: FontWeight.bold,
                             ),
                           ),),),
                     ],
                   ),),
                ),
              ],),
          ),
        ],),
    );
  }
}

class RecomendPlantCard2 extends StatelessWidget {
  RecomendPlantCard2({
    Key key,
    this.image,
    this.title,
    this.press,
  }) : super(key: key);

  final String image, title;
  final Function press;

  @override
  Widget build(BuildContext context) {
    List<Colors> Color=[];
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),
      width: 110,
      height: 120,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: press,
            child:Stack(
              children:<Widget>[
                // Icon(Icons.paint),
              Container(
              height: 120,
              width: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  color: Colors.grey.withOpacity(0.06),
                  // gradient: LinearGradient(
                  //     begin: Alignment.topLeft,
                  //     end: Alignment.bottomRight,
                  //     colors: [Y,Y5]
                  // ),
                ),
              child:Center(
                child:Column(
                  children: [
                    Container(
                      height: 60,
                      width: 70,
                      margin: EdgeInsets.only(top: 10),
                      child:ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          image, height: 90,
                          width: 100,
                          // color: Colors.white,
                          fit: BoxFit.contain,),
                      ),),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child:Center(
                        child:Text(title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Changa',
                            color: Colors.black87,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),),),
                  ],
                ),
              ),),
              ],),
          ),
        ],),
    );
  }
}

class RecomendPlantCard3 extends StatelessWidget {
  RecomendPlantCard3({
    Key key,
    this.image,
    this.title,
    this.press,
  }) : super(key: key);

  final String image, title;
  final Function press;

  @override
  Widget build(BuildContext context) {
    List<Colors> Color=[];
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),
      width: 110,
      height: 120,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: press,
            child:Stack(
              children:<Widget>[
                // Icon(Icons.paint),
              Container(
              height: 120,
              width: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  color: Colors.grey.withOpacity(0.06),
                  // gradient: LinearGradient(
                  //     begin: Alignment.topLeft,
                  //     end: Alignment.bottomRight,
                  //     colors: [Y,Y5]
                  // ),
                ),
              child:Center(
                child:Column(
                  children: [
                    Container(
                      height: 60,
                      width: 70,
                      margin: EdgeInsets.only(top: 10),
                      child:ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          image, height: 90,
                          width: 100,
                          // color: Colors.white,
                          fit: BoxFit.contain,),
                      ),),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child:Center(
                        child:Text(title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Changa',
                            color: Colors.black87,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),),),
                  ],
                ),
              ),),
              ],),
          ),
        ],),
    );
  }
}

class RecomendPlantCard4 extends StatelessWidget {
  RecomendPlantCard4({
    Key key,
    this.image,
    this.title,
    this.press,
  }) : super(key: key);

  final String image, title;
  final Function press;

  @override
  Widget build(BuildContext context) {
    List<Colors> Color=[];
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),
      width: 110,
      height: 120,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: press,
            child:Stack(
              children:<Widget>[
                // Icon(Icons.paint),
              Container(
              height: 120,
              width: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  color: Colors.grey.withOpacity(0.06),
                  // gradient: LinearGradient(
                  //     begin: Alignment.topLeft,
                  //     end: Alignment.bottomRight,
                  //     colors: [Y,Y5]
                  // ),
                ),
              child:Center(
                  child:Column(
                    children: [
                      Container(
                        height: 60,
                        width: 70,
                        margin: EdgeInsets.only(top: 10),
                        child:ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            image, height: 90,
                            width: 100,
                            // color: Colors.white,
                            fit: BoxFit.contain,),
                        ),),
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        child:Center(
                          child:Text(title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Changa',
                              color: Colors.black87,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),),),
                    ],
                  ),
                 ),),
              ],),
          ),
        ],),
    );
  }
}

class RecomendPlantCard5 extends StatelessWidget {
  RecomendPlantCard5({
    Key key,
    this.image,
    this.title,
    this.press,
  }) : super(key: key);

  final String image, title;
  final Function press;

  @override
  Widget build(BuildContext context) {
    List<Colors> Color=[];
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: 10, top: 10, bottom: 10,),
      width: 110,
      height: 120,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: press,
            child:Stack(
              children:<Widget>[
                // Icon(Icons.paint),
                Container(
                  height: 120,
                  width: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                    color: Colors.grey.withOpacity(0.06),
                    // gradient: LinearGradient(
                    //     begin: Alignment.topLeft,
                    //     end: Alignment.bottomRight,
                    //     colors: [Y,Y5]
                    // ),
                  ),
                child:Center(
                  child:Column(
                    children: [
                      Container(
                        height: 60,
                        width: 70,
                        margin: EdgeInsets.only(top: 10),
                        child:ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            image, height: 90,
                            width: 100,
                            // color: Colors.white,
                            fit: BoxFit.contain,),
                        ),),
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        child:Center(
                          child:Text(title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Changa',
                              color: Colors.black87,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),),),
                    ],
                  ),
                ),
                ),
              ],),
          ),
        ],),
    );
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