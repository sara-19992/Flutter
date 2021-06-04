import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

import '../constants.dart';
String IP4="192.168.1.8:8080";
FocusNode myFocusNode = new FocusNode();
bool Pass_Null=true;
bool Pass_R=true;
bool Pass_Mismatch=true;
bool Pass_S=true;
bool Pass_old=true;
bool Pass_old_notC=true;
String pass="";

class getMyComment extends StatefulWidget{
  final  name;
  final  phone;
  final  image;
  final  Work;
  final  Experiance;
  final  Information;
  final  token;

  getMyComment({this.name, this.phone, this.image, this.Work, this.Experiance, this.Information, this.token});
  _getMyComment createState() => _getMyComment();
}

class _getMyComment extends State<getMyComment> {
  @override
  Future getcom() async {
    var url = 'http://'+IP4+'/testlocalhost/allcomment.php';
    var ressponse = await http.post(url, body: {
      "phone": widget.phone,
    });
    return json.decode(ressponse.body);
  }
  Future getRate(String phone) async {
    var url = 'http://'+IP4+'/testlocalhost/getRate.php';
    var ressponse = await http.post(url, body: {
      "phone": phone,
      "workerphone":widget.phone,
    });
    return json.decode(ressponse.body);
  }

  Widget build(BuildContext context) {
    int value=0;
    return MaterialApp(
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Stack(
            children:[
              Scaffold(
                backgroundColor: Colors.transparent,
                body:Container(
                  height: 800,
                  color: Colors.white,
                  child: Stack(
                    children:[
                      Container(
                        margin: EdgeInsets.only(top: 60,left: 350,right: 10),
                        child:GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                            // Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => PROFILE(name: widget.name,)));
                          },
                          child:Icon(Icons.arrow_back,color: Colors.black,),
                        ),
                      ),

                      Container(
                        height: 705,
                        color: Colors.white,
                        margin: EdgeInsets.only(top: 90),
                        child: Container(
                          child:FutureBuilder(
                            future: getcom(),
                            builder: (BuildContext context, AsyncSnapshot snapshot) {
                              if(snapshot.hasData){
                                if(snapshot.data.length==0) {
                                  return Container(
                                    margin: EdgeInsets.only(top: 20),
                                    height:50,
                                    child: Text('لا يوجد لديك أي تعليقات',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.0,
                                        fontFamily: 'Changa',
                                        fontWeight: FontWeight.bold,),
                                    ),);
                                }
                                return ListView.builder(
                                  itemCount:snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    return Com(snapshot.data[index]['namefirst'],snapshot.data[index]['namelast'],snapshot.data[index]['image'],snapshot.data[index]['comment'],snapshot.data[index]['Rate']);
                                  },
                                );
                              }
                              return Center(child: Container());
                            },
                          ),
                        ),
                      ),
                      // GestureDetector(
                      //   onTap: (){
                      //     Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => getMyComment(phone: widget.phone,name:widget.name,)));
                      //   },
                      //   child:Container(
                      //     height: 55,
                      //     alignment: Alignment.center,
                      //     margin: EdgeInsets.only(top:720,right: 21),
                      //     //color:Y,
                      //     width:370,
                      //     decoration: BoxDecoration(
                      //       border: Border.all(
                      //         color: Y,
                      //         style: BorderStyle.solid,
                      //         width: 1.0,
                      //       ),
                      //       color: Colors.transparent,
                      //       borderRadius: BorderRadius.circular(10.0),
                      //     ),
                      //     // margin: EdgeInsets.only(left: 8,right: 15),
                      //     child: Text("إضافة تعليق",
                      //       style: TextStyle(
                      //         color: Y,
                      //         fontWeight: FontWeight.bold,
                      //         fontSize: 15.0,
                      //         fontFamily: 'Changa',
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],),

                ),),],),);
      },


      // localizationsDelegates: [
      // GlobalCupertinoLocalizations.delegate,
      // GlobalMaterialLocalizations.delegate,
      // GlobalWidgetsLocalizations.delegate,
      // ],
      // supportedLocales: [
      // Locale("en", "US"),
      // Locale('ar', 'AE')
      // ],
      debugShowCheckedModeBanner: false,
      // title: "Profile"
    );
  }
  Container Rate(String phone,String namefirst,String namelast,String image,String comment){
    String value;
    return  Container(
      height: 107,
      child: FutureBuilder(
          future: getRate(phone),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  value=snapshot.data[index]['total'];
                  return Com(namefirst,namelast,image,comment,value);
                },);
            }
            return Container(
              child:Text(''),
            );

          }
      ),
    );
  }
  Container Com(String namefirst,String namelast,String image,String comment,String value){
    return Container(
      width:250,
      height: 90,
      transform: Matrix4.translationValues(0.0, -20.0, 0.0),
      decoration: BoxDecoration(
        color:Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0.2),
            blurRadius: 0.5,
            color: Colors.grey[400],
          ),
        ],),
      //color: PURPEL,
      margin: EdgeInsets.only(top: 10,bottom: 5,left: 20,right: 20),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(top: 5,bottom: 5,right: 10),
            child:CircleAvatar(backgroundImage: NetworkImage(
                'http://' + IP4 + '/testlocalhost/upload/' + image),
              radius: 30.0,),
          ),
          Container(
            child: Column(
              children: [
                Container(
                  width: 280,
                  //color: Colors.green,
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.only(top: 8,bottom: 0,left: 0,right:5),
                  child:Row(
                    children: [
                      Container(
                        width: 100,
                        //color: Colors.green,
                        child: Text(namefirst + " " + namelast,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontFamily: 'Changa',
                            fontWeight: FontWeight.bold,),
                        ),),
                      Directionality(textDirection: TextDirection.ltr,

                        child: Container(
                            width: 180,
                            height: 25,
                            alignment: Alignment.topLeft,
                            child: RatingBar.builder(
                              glowColor: Colors.orangeAccent,
                              initialRating:double.parse(value),
                              minRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              unratedColor: Colors.amber.withAlpha(50),
                              itemCount: 5,
                              itemSize: 20.0,
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemPadding: EdgeInsets.symmetric(horizontal:0.07),

                              onRatingUpdate: (rating) {
                                setState(() {
                                  // _rating1 = rating;
                                  //_rating2=
                                });
                              },
                              updateOnDrag: false,
                            )
                        ),),

                    ],
                  ),
                ),
                Container(
                  width: 280,
                  color: Colors.white,
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.only(top: 2,bottom: 2,left: 0,right:10),
                  child: Text(comment,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 13.0,
                      fontFamily: 'Changa',
                      fontWeight: FontWeight.bold,),
                  ),),
              ],
            ),
          ),


          // Divider(color:Colors.black,thickness: 2,),

        ],
      ),
    );
  }

}
