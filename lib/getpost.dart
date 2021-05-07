import 'package:carousel_pro/carousel_pro.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterphone/ChatUuser/chatListUser.dart';
import 'package:flutterphone/USER/List_worker_group.dart';
import 'package:flutterphone/USER/WORKER_PROFILE.dart';
import 'package:flutterphone/USER/search_user.dart';
import 'package:flutterphone/USER/user_reserve_order.dart';
import 'package:flutterphone/screens/login_screen.dart';
import 'package:flutterphone/screens/welcome.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutterphone/constants.dart';
import '../constants.dart';
import '../database.dart';


String  name_Me="";
String  name="";
String  phone="";
String  image="";
String namefirst="";
String namelast="";
String Country="";
String  token="";
String IP4="192.168.1.8";

class pp extends StatefulWidget {
  final name_Me;
  pp({this.name_Me,});
  _U_PROFILE createState() =>  _U_PROFILE();
}
class  _U_PROFILE extends State<pp> {
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
    var url='https://'+IP4+'/testlocalhost/all_worker.php';
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
  void initState(){
    super.initState();
    getChat();
    getSearchall();
  }
  Future getUser() async {
    var url = 'https://' + IP4 + '/testlocalhost/getUser.php';
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
  Future getpost()async{
    var url='https://'+IP4+'/testlocalhost/post_profile.php';
    var ressponse=await http.get(url);
    // // ignore: deprecated_member_use
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);

  }
  DatabaseMethods databaseMethods=new DatabaseMethods();
  Stream chatsRoom;
  @override
  Widget build(BuildContext context) {
    print(Search.toString());
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Container(
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
}

class post  extends StatefulWidget {


  @override
  _post createState() => _post();
}

class _post extends State<post> {


  Future getpost()async{
    var url='https://'+IP4+'/testlocalhost/post_profile.php';
    var ressponse=await http.get(url);
    // // ignore: deprecated_member_use
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      margin: EdgeInsets.only(top:700),
      color: Colors.red,
      child:FutureBuilder(
        future: getpost(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasData){
            print("ASDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD");
            return ListView.builder(
                itemCount:2,
                itemBuilder: (context, index) {
                  //List_Post=snapshot.data;
                  // postnumber=snapshot.data.length;
                  //return myPost(snapshot.data[index]['text'], snapshot.data[index]['image'], snapshot.data[index]['data'],);
                  return Container(height:100,color:Colors.green,);
                }
            );
          }
          return Center(child: Text('ASD'));
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
//                     'https://' + IP4 + '/testlocalhost/upload/' + widget.image),
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
//             child: Image.network('https://'+IP4+'/testlocalhost/upload/'+  image, height: 204, width: 380, fit: BoxFit.cover,),
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
      height: 105,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: press,
            child:Stack(
              children:<Widget>[
                // Icon(Icons.paint),
                Container(
                  width: 160,
                  height: 101,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                      bottomRight:  Radius.circular(5),
                      bottomLeft:  Radius.circular(5),
                    ),
                    color: Colors.grey[100],
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [X1,X3]
                    ),
                  ),
                  child:  Center(
                    child:Column(
                      children: [
                        Container(
                          height: 70,
                          width: 80,
                          margin: EdgeInsets.only(top: 0),
                          child:ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                              image, height: 90,
                              width: 100,
                              // color: Colors.white,
                              fit: BoxFit.contain,),
                          ),),
                        Container(
                          margin: EdgeInsets.only(top: 2),
                          child:Center(
                            child:Text(title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Changa',
                                color: Colors.white,
                                fontSize: 16.0,
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
      height: 105,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: press,
            child:Stack(
              children:<Widget>[
                // Icon(Icons.paint),
                Container(
                  height: 101,
                  width: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                      bottomRight:  Radius.circular(5),
                      bottomLeft:  Radius.circular(5),
                    ),
                    color: Colors.grey[100],
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [red1,red2]
                    ),
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
                          margin: EdgeInsets.only(top: 2),
                          child:Center(
                            child:Text(title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Changa',
                                color: Colors.white,
                                fontSize: 16.0,
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
      height: 105,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: press,
            child:Stack(
              children:<Widget>[
                // Icon(Icons.paint),
                Container(
                  height: 101,
                  width: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                      bottomRight:  Radius.circular(5),
                      bottomLeft:  Radius.circular(5),

                    ),
                    color: Colors.grey[100],
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [blue1,blue2]
                    ),
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
                          margin: EdgeInsets.only(top: 2),
                          child:Center(
                            child:Text(title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Changa',
                                color: Colors.white,
                                fontSize: 16.0,
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
      height: 105,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: press,
            child:Stack(
              children:<Widget>[
                // Icon(Icons.paint),
                Container(
                  height: 101,
                  width: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),

                    ),
                    color: Colors.grey[100],
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [green1,green2]
                    ),
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
                          margin: EdgeInsets.only(top: 2),
                          child:Center(
                            child:Text(title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Changa',
                                color: Colors.white,
                                fontSize: 16.0,
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
      height: 105,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: press,
            child:Stack(
              children:<Widget>[
                // Icon(Icons.paint),
                Container(
                  height: 101,
                  width: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                    color: Colors.grey[100],
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [perp1,perp2]
                    ),
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
                          margin: EdgeInsets.only(top: 2),
                          child:Center(
                            child:Text(title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Changa',
                                color: Colors.white,
                                fontSize: 16.0,
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