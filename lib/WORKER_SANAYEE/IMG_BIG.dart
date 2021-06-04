import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import 'GET_IMGS.dart';
String IP4="192.168.1.8:8080";

class IMG extends StatefulWidget {
  final  imageName;
  final  int index;
  final  phone;
  final  id;
  IMG({this.imageName,this.index,this.phone,this.id});

  _Get_Images createState() =>  _Get_Images();
}
class  _Get_Images extends State<IMG> {

  Future Delete()async{
    var url='http://'+IP4+'/testlocalhost/delete_IMG.php';
    var ressponse=await http.post(url,body: {
      "id": widget.id,
    });
    String massage = json.decode(ressponse.body);
    print(massage);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color:Colors.black,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(5, 50, 370, 10),
              child: IconButton(
                alignment: Alignment.topRight,
                onPressed: () { Navigator.pop(context);},
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 30.0,
                ),
              ),
            ),
            Expanded(
              child: Hero(
                tag: 'logo$widget.index',
                child: GestureDetector(
                  child:Container(margin:EdgeInsets.symmetric(vertical:100),
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage('http://'+IP4+'/testlocalhost/upload/'+widget.imageName),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.fromLTRB(360, 0, 10, 5),
              child: IconButton(
                alignment: Alignment.topRight,
                onPressed: () {
                  _showMyDialog();
                  print(widget.id);
                  print(widget.imageName);
                  //Delete();
                   },
                icon: Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 37.0,
                ),
              ),
            ),
                  //  Row(
                  //   children: <Widget>[
                  //
                  //     Container(
                  //       margin: EdgeInsets.fromLTRB(20, 0, 10, 20),
                  //       child: IconButton(
                  //         alignment: Alignment.topRight,
                  //         onPressed: () { Navigator.pop(context);},
                  //         icon: Icon(
                  //           Icons.arrow_back,
                  //           color: Colors.red,
                  //           size: 30.0,
                  //         ),
                  //       ),
                  //     ),
                  //     Container(
                  //       margin: EdgeInsets.fromLTRB(270, 0, 10, 20),
                  //       child: IconButton(
                  //         alignment: Alignment.topRight,
                  //         onPressed: () { Navigator.pop(context);},
                  //         icon: Icon(
                  //           Icons.arrow_forward,
                  //           color: Colors.red,
                  //           size: 30.0,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // )
                ],
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
          backgroundColor: Colors.white,
          actionsPadding: EdgeInsets.zero,
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 110,top: 5),
                      width: 300,
                      child: Text('هل  تريد حذف هذه الصورة ؟',
                        style: TextStyle(
                          fontFamily: 'Changa',
                          color: Colors.black45,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),),
                    ),
                    SizedBox(height:50,),
                    Row(
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
                                  color: Y,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                          ),
                        ),
                        GestureDetector(
                          onTap: () async{
                            Delete();
                            print("dsd");
                            Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>Get_Images(phone:widget.phone)));
                            },
                          child: Container(
                              margin: EdgeInsets.only(right: 150),
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
                    ),
                    // SizedBox(width: 10,),
                  ],
                ),
              ],
            ),
          ),
        );
        return AlertDialog(
           actions: <Widget>[
             Container(
               child: Text(' هل تريد حذف هذه الصورة ؟ ',
                 style: TextStyle(
                   fontSize: 14,
                   fontWeight: FontWeight.bold,
                   color: Colors.black87,
                   fontFamily: 'Changa',
                 ),),
             ),
            Container(
              margin: EdgeInsets.only(left: 10,bottom: 20,top: 30),
            child:FlatButton(
              child: Text('إلغاء',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Y,
                  fontFamily: 'Changa',
                ),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),),
            Container(
              margin: EdgeInsets.only(left: 20,right: 90,bottom: 20,top: 30),
             child:FlatButton(
              child: Text('حذف ',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color:Y,
                  fontFamily: 'Changa',
                ),),
              onPressed: () {
                Delete();
                print("dsd");
                Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>Get_Images(phone:widget.phone)));
              },
            ),),
          ],
        );
      },
    );
  }
}
