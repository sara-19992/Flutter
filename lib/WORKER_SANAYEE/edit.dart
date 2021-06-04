import 'package:flutterphone/screens/signuser_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutterphone/components/pin_entry_text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import '../constants.dart';
import 'menue_Page.dart';
import 'Profile.dart';
String IP4="192.168.1.8:8080";
String _verificationCode;
String smscode ;
FocusNode myFocusNode = new FocusNode();
String country_id;
List<String>country=["جنين","نابلس","طولكرم","رام الله","طوباس",""];

class EditProfilePage extends StatefulWidget {
  final  name;
  final  phone;
  final  image;
  final  Work;
  final  Experiance;
  final  Information;
  final  token;
  final namefirst;
  final namelast;
  EditProfilePage({this.namefirst,this.namelast,this.name, this.phone, this.image, this.Work, this.Experiance, this.Information, this.token});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController phone_Num = TextEditingController();

  TextEditingController nameController1 = TextEditingController();
  TextEditingController nameController2 = TextEditingController();
  TextEditingController workcontroller = TextEditingController();
  TextEditingController experController = TextEditingController();
  TextEditingController infoController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  void initState() {
   nameController1.text=widget.namefirst;
    nameController2.text=widget.namelast;
    workcontroller.text=widget.Work;
    experController.text=widget.Experiance;
    infoController.text=widget.Information;
    super.initState();
  }

  bool showPassword = false;
  PickedFile image_file;
  File _file;
  bool choose=false;
  final ImagePicker image_picker =ImagePicker();
  final formKey = new GlobalKey<FormState>();
  Widget build(BuildContext context) {
    debugShowCheckedModeBanner: false;
    Size size = MediaQuery.of(context).size;
    bool _value1 = false;
    bool _value2 = false;
    String code = "";
    String pass="";
    return Directionality(
      textDirection: TextDirection.rtl,
      child:Scaffold(
       backgroundColor: Colors.white,
      body: SingleChildScrollView(
            child: Stack(

              // crossAxisAlignment: CrossAxisAlignment.stretch,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
                  margin:EdgeInsets.only(top:60,right: 10),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MenuePage(Information:widget.Information,Experiance:widget.Experiance,Work:widget.Work,namelast:widget.namelast,name:widget.name,phone:widget.phone,image:widget.image,token:widget.token,namefirst:widget.namefirst,)));
                      // Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => PROFILE(name: widget.name,)));
                    },
                    child:Icon(Icons.arrow_back,color: Colors.white,),
                  ),
                ),
                // Container(
                //   width: 500,
                //   height: 110,
                //   color: Colors.white,
                //   child: Row(
                //     children: [
                //       Container(
                //         margin: EdgeInsets.only(top:60,right: 10),
                //         child:GestureDetector(
                //           onTap: (){
                //             Navigator.pop(context);
                //           },
                //           child:Icon(Icons.arrow_back,color: Colors.black,),
                //         ),
                //       ),
                //       // Container(
                //       //   margin: EdgeInsets.only(top:60,right: 11),
                //       //   child:Text('تعديل المعلومات الشخصية',
                //       //     style: TextStyle(
                //       //       fontSize: 17,
                //       //       fontWeight: FontWeight.bold,
                //       //       color: Colors.white,
                //       //       fontFamily: 'Changa',
                //       //       //fontStyle: FontStyle.italic,
                //       //     ),),
                //       // ),
                //
                //     ],
                //   ),
                // ),
                GestureDetector(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease,
                    child: Container(
                      height: 690,
                      margin: EdgeInsets.fromLTRB(0,150,0,0),
                      color: Colors.transparent,
                      padding: EdgeInsets.only(top: 5),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0,),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[

                                      Container(
                                        margin: EdgeInsets.fromLTRB(0,60,40,15),
                                        width: size.width * 0.33,
                                        height: 60,
                                        child: TextFormField(
                                          textDirection: TextDirection.ltr,
                                          textAlign: TextAlign.right,
                                          onChanged: (value) {

                                          },
                                          controller: nameController1,
                                          cursorColor: Colors.grey[600],
                                          style: TextStyle(
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Changa',
                                            color:Colors.black87,
                                          ),
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor:Colors.grey[50],
                                            enabledBorder: new OutlineInputBorder(
                                              borderRadius: new BorderRadius.circular(28.0),
                                              borderSide:  BorderSide(color:Colors.grey[50]),

                                            ),
                                            focusedBorder: new OutlineInputBorder(
                                              borderRadius: new BorderRadius.circular(28.0),
                                              borderSide:  BorderSide(color:Colors.grey[50]),

                                            ),
                                            labelText: ('الاسم الأول'),
                                            floatingLabelBehavior: FloatingLabelBehavior.always,
                                            labelStyle: TextStyle(fontSize: 18.0,fontFamily: 'Changa',color: myFocusNode.hasFocus ? Colors.grey[600] : Colors.grey[600],),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0,60,10,15),
                                        width: size.width * 0.44,
                                        height: 60,
                                        child: TextFormField(
                                          onChanged: (value) {

                                          },
                                          controller: nameController2,
                                          cursorColor: Colors.grey[600],
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Changa',
                                            color:Colors.black87,
                                          ),
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor:Colors.grey[50],
                                            enabledBorder: new OutlineInputBorder(
                                              borderRadius: new BorderRadius.circular(28.0),
                                              borderSide:  BorderSide(color:Colors.grey[50]),

                                            ),
                                            focusedBorder: new OutlineInputBorder(
                                              borderRadius: new BorderRadius.circular(28.0),
                                              borderSide:  BorderSide(color:Colors.grey[50]),

                                            ),
                                            labelText: ('اسم العائلة '),
                                            floatingLabelBehavior: FloatingLabelBehavior.always,
                                            labelStyle: TextStyle(fontSize: 18.0,fontFamily: 'Changa',color: myFocusNode.hasFocus ? Colors.grey[600] : Colors.grey[600],),
                                          ),
                                        ),
                                      ),
                                    ],),
                                  Container(
                                    height: 120,
                                    margin: EdgeInsets.fromLTRB(0,10,0,15),
                                    padding: EdgeInsets.symmetric(horizontal:0,),
                                    width: size.width * 0.8,
                                    child: TextFormField(
                                      onChanged: (value) {
                                      },
                                      controller: infoController,
                                      maxLines: 20,
                                      cursorColor: Colors.grey[600],
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Changa',
                                        color:Colors.black87,
                                      ),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.grey[50],
                                        enabledBorder: new OutlineInputBorder(
                                          borderRadius: new BorderRadius.circular(30.0),
                                          borderSide:  BorderSide(color:Colors.grey[50]),

                                        ),
                                        focusedBorder: new OutlineInputBorder(
                                          borderRadius: new BorderRadius.circular(30.0),
                                          borderSide:  BorderSide(color:Colors.grey[50]),

                                        ),
                                        labelText: ('المعلومات'),
                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                        labelStyle: TextStyle(fontSize: 18.0,fontFamily: 'Changa',color: myFocusNode.hasFocus ? Colors.grey[600] : Colors.grey[600],),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 120,
                                    margin: EdgeInsets.fromLTRB(0,10,0,0),
                                    width: size.width * 0.8,
                                    child: TextFormField(
                                      onChanged: (value) {
                                      },
                                      maxLines: 20,
                                      cursorColor: Colors.grey[600],
                                      textAlign: TextAlign.right,
                                      controller: experController,
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Changa',
                                        color:Colors.black87,
                                      ),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.grey[50],
                                        enabledBorder: new OutlineInputBorder(
                                          borderRadius: new BorderRadius.circular(40.0),
                                          borderSide:  BorderSide(color:Colors.grey[50]),

                                        ),
                                        focusedBorder: new OutlineInputBorder(
                                          borderRadius: new BorderRadius.circular(40.0),
                                          borderSide:  BorderSide(color:Colors.grey[50]),

                                        ),
                                        labelText: ('خبرة وتجارب سابقة'),
                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                        labelStyle: TextStyle(fontSize: 18.0,fontFamily: 'Changa',color: myFocusNode.hasFocus ? Colors.grey[600] : Colors.grey[600],),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 130,right: 130,top:50),
                              width: 150,
                              child: FloatingActionButton(
                                backgroundColor:Y,
                                splashColor: Colors.transparent,
                                onPressed: (){
                                  editpersonalinfo();
                                  _showMyDialog();
                                },
                                tooltip: 'Increment',
                                child: Icon(Icons.edit),
                              ),
                              // child:RaisedButton(
                              //   onPressed: () {
                              //     editpersonalinfo();
                              //     _showMyDialog();
                              //   },
                              //   color:Color(0xFFECCB45),
                              //   padding: EdgeInsets.symmetric(vertical: 10),
                              //   elevation: 2,
                              //   //shape: ,
                              //   // shape: RoundedRectangleBorder(
                              //   //     borderRadius: BorderRadius.circular(25)),
                              //   child:Icon(Icons.edit),
                              //   // child: Text(
                              //   //   "حفظ التعديل",
                              //   //   style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600,fontFamily: 'Changa',color: Colors.white,),
                              //   // ),
                              // ),
                            ),
                          ],
                        ),
                      ),),
                  ),
                )
              ],),),
      ),);
  }
  Future editpersonalinfo ()async {
    var url = 'http://' + IP4 + '/testlocalhost/edit.php';
    var response = await http.post(url, body: {

      "phone":widget.phone,
      "name1": nameController1.text,
      "name2": nameController2.text,
      // "Work":workcontroller.text,
      "Information": infoController.text,
      "Experiance": experController.text,

    });
    String massage = json.decode(response.body);
    print(massage);
  }

  Widget image_profile(){
    return Center(
      child:Stack (children: <Widget>[
        CircleAvatar(
          backgroundImage: image_file==null? NetworkImage('http://'+IP4+'/testlocalhost/upload/'+widget.image):FileImage(File(image_file.path)),
          radius: 60.0,
        ),
        Positioned(
          bottom:10.0,
          right:3.0,
          child: InkWell(
            onTap:(){
              showModalBottomSheet(context: context, builder: (builder) => buttom_camera(),);
            },
            child:Icon(Icons.camera_alt,color:Colors.black54,size: 35.0,),),),
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
    setState(() {
      if(file==Null){image_file=Image.asset("assets/icons/signup.png") as PickedFile;}
      else{image_file=file;}

    });
  }
  //SignIn
  // signIn(AuthCredential authCreds) {
  //   FirebaseAuth.instance.signInWithCredential(authCreds);
  //   return StreamBuilder(
  //       stream: FirebaseAuth.instance.onAuthStateChanged,
  //       builder: (BuildContext context, snapshot) {
  //         if (snapshot.hasData) {
  //           // FirebaseAuth.instance.signOut();
  //           print(snapshot.data.toString());
  //           return InsideAPP();
  //         } else {
  //           return SignuserScreen();
  //         }
  //       });
  // }

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
class CurvePainter extends CustomPainter {

  bool outterCurve;

  CurvePainter(this.outterCurve);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Y2;
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