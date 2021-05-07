import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

import '../constants.dart';
String IP4="192.168.1.8";
FocusNode myFocusNode = new FocusNode();

bool _showPassword1 = false;
bool _showPassword2 = false;
bool _showPassword3 = false;
class ChangePass extends StatefulWidget{
  final  name;
  final  phone;
  final  image;
  final  Work;
  final  Experiance;
  final  Information;
  final  token;

  ChangePass({this.name, this.phone, this.image, this.Work, this.Experiance, this.Information, this.token});
  _change createState() => _change();
}

class _change extends State<ChangePass> {
  @override
  TextEditingController password = TextEditingController();
  TextEditingController newpass = TextEditingController();
  TextEditingController confirmpass = TextEditingController();
  bool showPassword = false;

  bool Pass_Null=true;
  bool Pass_R=true;
  bool Pass_Mismatch=true;
  bool Pass_S=true;
  bool Pass_old=true;
  bool Pass_old_notC=true;
  String pass="";
  final formKey = new GlobalKey<FormState>();
  @override
  Future editpassword() async {
    print(widget.name);
    print(password.text);
    print(newpass.text);
    var url = 'https://'+IP4+'/testlocalhost/edit_pass.php';
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
      _showMyDialog();
      password.text="";
      newpass.text="";
      confirmpass.text="";
      Pass_old_notC=true;
      Pass_old=true;

    }
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

  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Stack(
            children:[
            Scaffold(
            backgroundColor: Colors.transparent,
            // appBar: new AppBar(
            //   backgroundColor:Y,
            //   leading:GestureDetector(
            //     onTap: (){
            //       Navigator.pop(context);
            //       // Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => PROFILE(name: widget.name,)));
            //     },
            //     child:Icon(Icons.arrow_back,color: Colors.white,),
            //   ),
            //   title: new Text('',
            //     style: TextStyle(
            //       fontSize: 16.0,
            //       fontWeight: FontWeight.bold,
            //       fontFamily: 'Changa',
            //       color: Colors.white,
            //     ),
            //   ),
            // ),
            body: Form(key: formKey,
              child:Container(
             height: 800,
             color: Colors.white,
             child: Stack(
             children:[
               ClipPath(
                 clipper: ClippingClass(),
                 child: Container(
                   height: 250,
                   width: 500,
                   decoration: BoxDecoration(
                     color: Colors.black87.withOpacity(0.9),
                     image: new DecorationImage(
                       fit: BoxFit.cover,
                       colorFilter:
                       ColorFilter.mode(Colors.black87.withOpacity(0.4),
                           BlendMode.dstATop),
                       image: new AssetImage('assets/work/cvtop.jpg',),
                     ),
                   ),
                 ),),
               Container(
                 margin:EdgeInsets.only(top:70,right:10),
                 child: GestureDetector(
                   onTap: (){
                     Navigator.pop(context);
                     // Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => PROFILE(name: widget.name,)));
                   },
                   child:Icon(Icons.arrow_back,color: Colors.white,),
                 ),
               ),
             Container(
               height: 550,
               decoration: BoxDecoration(
                 // borderRadius: BorderRadius.only(
                 //   topLeft: Radius.circular(15),
                 //   topRight: Radius.circular(15),
                 // ),
                 color: Colors.white,
               ),
               margin: EdgeInsets.only(top: 250),
               child:SingleChildScrollView(
                 child: Column(
                   children: <Widget>[
                     // Container(
                     //     alignment: Alignment.center,
                     //     margin: EdgeInsets.only(top: 0,),
                     //     child:Text('تغيير كلمة السر',
                     //       style: TextStyle(
                     //         fontSize: 30,
                     //         fontWeight: FontWeight.w400,
                     //         color: Colors.black,
                     //         fontFamily: 'vibes',
                     //         //fontStyle: FontStyle.italic,
                     //       ),)
                     // ),
                     Container(
                       height: 540,
                       child:Column(
                         children:[
                           Container(
                             margin: EdgeInsets.only(top: 50,left: 60,right: 60),
                             height: 50,
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
                               onChanged: (content) {
                                 Pass_old=true;
                                 Pass_old_notC=true;
                                 setState(() {

                                 });
                               },
                               style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600,fontFamily: 'Changa',color: Colors.grey[600],),
                               decoration: InputDecoration(
                                 filled: true,
                                 fillColor: Colors.white,
                                 enabledBorder: new OutlineInputBorder(
                                   borderRadius: new BorderRadius.circular(30.0),
                                   borderSide:  BorderSide(color: Colors.black87),

                                 ),
                                 focusedBorder: new OutlineInputBorder(
                                   borderRadius: new BorderRadius.circular(30.0),
                                   borderSide:  BorderSide(color:  Colors.black87),
                                 ),
                                 floatingLabelBehavior: FloatingLabelBehavior.always,
                                 hintText: "كلمة السر القديمة",
                                 hintStyle:  TextStyle(fontSize: 14.0,fontFamily: 'Changa',color: myFocusNode.hasFocus ? Colors.grey[600] : Colors.grey[600],),
                                 suffixIcon: IconButton(
                                   icon: Icon(_showPassword1 ? Icons.visibility : Icons.visibility_off, color: Colors.grey[600],size: 22,),
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
                             margin: EdgeInsets.fromLTRB(210, 0, 0, 0),
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
                             margin: EdgeInsets.symmetric(horizontal: 60),
                             height: 50,
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
                               onChanged: (content) {
                                 Pass_Null=true;
                                 Pass_S=true;
                                 setState(() {

                                 });
                               },
                               // textDirection: TextDirection.rtl,
                               controller: newpass,
                               obscureText: !_showPassword2,
                               style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600,fontFamily: 'Changa',color: Colors.grey[600],),
                               decoration: InputDecoration(
                                 filled: true,
                                 fillColor: Colors.white,
                                 enabledBorder: new OutlineInputBorder(
                                   borderRadius: new BorderRadius.circular(30.0),
                                   borderSide:  BorderSide(color: Colors.black87),

                                 ),
                                 focusedBorder: new OutlineInputBorder(
                                   borderRadius: new BorderRadius.circular(30.0),
                                   borderSide:  BorderSide(color:  Colors.black87),
                                 ),
                                 floatingLabelBehavior: FloatingLabelBehavior.always,
                                 hintText: "كلمة السر الجديدة",
                                 hintStyle:  TextStyle(fontSize: 14.0,fontFamily: 'Changa',color: myFocusNode.hasFocus ? Colors.grey[600] : Colors.grey[600],),
                                 suffixIcon: IconButton(
                                   icon: Icon(_showPassword2 ? Icons.visibility : Icons.visibility_off, color:Colors.grey[600],size: 22,),
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
                             margin: EdgeInsets.fromLTRB(210, 0, 0, 0),
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
                             margin: EdgeInsets.symmetric(horizontal: 60),
                             height: 50,
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
                               onChanged: (content) {
                                 Pass_R=true;
                                 Pass_Mismatch=true;
                                 setState(() {

                                 });
                               },
                               // textDirection: TextDirection.rtl,
                               controller: confirmpass,
                               style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600,fontFamily: 'Changa',color: Colors.grey[600],),
                               decoration: InputDecoration(
                                 filled: true,
                                 fillColor: Colors.white,
                                 enabledBorder: new OutlineInputBorder(
                                   borderRadius: new BorderRadius.circular(30.0),
                                   borderSide:  BorderSide(color: Colors.black87),

                                 ),
                                 focusedBorder: new OutlineInputBorder(
                                   borderRadius: new BorderRadius.circular(30.0),
                                   borderSide:  BorderSide(color:  Colors.black87),
                                 ),
                                 floatingLabelBehavior: FloatingLabelBehavior.always,
                                 hintText: "تأكيد كلمة السر",
                                 hintStyle:  TextStyle(fontSize: 14.0,fontFamily: 'Changa',color: myFocusNode.hasFocus ? Colors.grey[600] : Colors.grey[600],),
                                 suffixIcon: IconButton(
                                   icon: Icon(_showPassword3 ? Icons.visibility : Icons.visibility_off, color: Colors.grey[600],size: 22,),
                                   color: Colors.cyan,
                                   onPressed:_togglevisibility3,
                                 ),//
                               ),
                               cursorColor:Colors.grey[600],
                             ),),
                           Pass_R ? Container(
                             margin: EdgeInsets.fromLTRB(50, 0, 0, 0),
                             child: Text('',textAlign:TextAlign.end,
                               style: TextStyle(
                                 fontSize: 12.0,
                                 fontWeight: FontWeight.w700,
                                 fontFamily: 'Changa',
                                 color: Colors.red,

                               ),),
                           ): Container(
                             margin: EdgeInsets.fromLTRB(210, 0, 0, 0),
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
                             margin: EdgeInsets.fromLTRB(160, 0, 0, 0),
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
                             margin: EdgeInsets.fromLTRB(80, 0, 0, 0),
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
                             margin: EdgeInsets.fromLTRB(180, 0,0, 0),
                             child: Text('* كلمة السر غير متطابقة',textAlign:TextAlign.end,
                               style: TextStyle(
                                 fontSize: 12.0,
                                 fontWeight: FontWeight.w700,
                                 fontFamily: 'Changa',
                                 color: Colors.red,

                               ),),
                           ),
                           // GestureDetector(
                           //   onTap: () async{
                           //     if (formKey.currentState.validate()) {print('validate');}
                           //     if( Pass_Null &&  Pass_Mismatch && Pass_S && Pass_old){
                           //       await editpassword();
                           //     }
                           //     else{print('not validate');}
                           //     setState(() {
                           //
                           //     });
                           //     // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => getMyComment(phone: widget.phone,name:widget.name,)));
                           //   },
                           //   child:Container(
                           //     height: 40,
                           //     alignment: Alignment.center,
                           //     margin: EdgeInsets.only(left: 80,right: 80,top:0),
                           //     //color:Y,
                           //     width:350,
                           //     decoration: BoxDecoration(
                           //       color: Y,
                           //       border: Border.all(
                           //         color: Y,
                           //         style: BorderStyle.solid,
                           //         width: 1.0,
                           //       ),
                           //       borderRadius: BorderRadius.circular(30.0),
                           //     ),
                           //     // margin: EdgeInsets.only(left: 8,right: 15),
                           //     child: Text(
                           //       "تعديل",
                           //       style: TextStyle(
                           //         color: Colors.white,
                           //         fontWeight: FontWeight.bold,
                           //         fontSize: 15.0,
                           //         fontFamily: 'Changa',
                           //       ),
                           //     ),
                           //   ),
                           // ),
                           Container(
                             margin: EdgeInsets.only(left: 130,right: 130,top:75),
                             width: 150,
                             child: FloatingActionButton(
                               backgroundColor:Y,
                               splashColor: Colors.transparent,
                               onPressed: () async{
                                 if (formKey.currentState.validate()) {print('validate');}
                                     if( Pass_Null &&  Pass_Mismatch && Pass_S && Pass_old){
                                       await editpassword();
                                     }
                                     else{print('not validate');}
                                     setState(() {

                                     });
                               },
                               tooltip: 'Increment',
                               child: Icon(Icons.edit),
                             ),
                           ),
                           // Row(
                           //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           //   children: [
                           //     Container(
                           //       margin: EdgeInsets.symmetric(horizontal: 130),
                           //       width: 150,
                           //       child:FlatButton(
                           //         onPressed: () {
                           //           setState(() {});
                           //           if( Pass_Null &&  Pass_Mismatch && Pass_S &&  Pass_old){
                           //             editpassword();
                           //           }
                           //           if (formKey.currentState.validate()) {print('validate');}
                           //           else{print('not validate');}
                           //         },
                           //         // backgroundColor:MY_YELLOW ,
                           //         // elevation: 2,
                           //         // shape: RoundedRectangleBorder(
                           //         //     borderRadius: BorderRadius.circular(25)),
                           //         // child: Icon(Icons.check_circle),
                           //         child:Text("حفظ",
                           //           style: TextStyle(
                           //             fontSize: 20,
                           //             fontWeight: FontWeight.w700,
                           //             color: MY_YELLOW,
                           //             fontFamily: 'Changa',
                           //           ),
                           //         ),
                           //       ),
                           //     ),
                           //     // OutlineButton(
                           //     //   padding: EdgeInsets.symmetric(horizontal: 50),
                           //     //   shape: RoundedRectangleBorder(
                           //     //       borderRadius: BorderRadius.circular(20)),
                           //     //   onPressed: () {
                           //     //
                           //     //
                           //     //   },
                           //     //   child: Text("الغاء",
                           //     //       style: TextStyle(
                           //     //           fontSize: 14,
                           //     //           letterSpacing: 2.2,
                           //     //           color: Colors.purple)),
                           //     // ),
                           //
                           //   ],
                           // )

                         ],), ), ],
                 ),),),
             ],
           ),
          ),),

        ),],),);
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
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      //this means the user must tap a button to exit the Alert Dialog
      builder: (BuildContext context) {
        return AlertDialog(
          //titlePadding: EdgeInsets.only(right: 20,left: 30,top: 15),
          actions: <Widget>[
            Directionality(textDirection: TextDirection.rtl,
              child: Container(
                width: 300,
                alignment: Alignment.topRight,
                padding:EdgeInsets.only(top:10,left: 10,right: 10),
                //margin: EdgeInsets.only(top:50,left: 50,right: 10),
                child:Text('تم تعديل المعلومات بنجاح',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                    fontFamily: 'Changa',
                  ),),
              ),),
            Row(
              children: [
                Container(
                  width: 70,
                  margin: EdgeInsets.only(left: 10,right:180,bottom:15,top: 30),
                  child:GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child:Text('حسنا',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color:Y,
                        fontFamily: 'Changa',
                      ),),
                  ),),
              ],
            ),

          ],
        );
      },
    );
  }


}
class ClippingClass extends CustomClipper<Path>{
  @override

  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);
    var controlPoint = Offset(size.width - (size.width / 2), size.height - 85);
    var endPoint = Offset(size.width, size.height);
    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}