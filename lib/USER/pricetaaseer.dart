import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterphone/ChatUuser/chatListUser.dart';
import 'package:flutterphone/USER/user_Profile.dart';
import 'package:flutterphone/USER/user_reserve_order.dart';
import 'package:flutterphone/USER/warshat_delete1_stata.dart';
import 'package:flutterphone/USER/warshat_delete_state.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'delete_userstate2.dart';
import 'warshat_current_state.dart';
import 'warshat_finished_state.dart';
import 'warshat_wait_state.dart';
import 'package:flutterphone/constants.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../buttom_bar.dart';
import '../constants.dart';
import '../database.dart';
import 'Rate_Me.dart';
import 'current_user_states.dart';
import 'daycancel_user_state.dart';
import 'delete_user_state.dart';
import 'favarate.dart';
import 'finish_user_stste.dart';
import 'menue_Page.dart';
import 'not_conferm_user_state.dart';
import 'package:fluttertoast/fluttertoast.dart';
String  name_Me="";
String  name="";
String  phone="";
String  image="";
String namefirst="";
String namelast="";
String Country="";
String  token="";

String IP4="192.168.1.8:8080";

class price_taseer_order extends StatefulWidget {
  final phoneuser;
  final username;
  final country;
  final namelast;
  final namefirst;
  final token;
  final image;
  final index;
  final id_g;
  final desc;
  List<dynamic>Lsist_Post;
  price_taseer_order({this.desc,this.id_g,this.index,this.Lsist_Post,this.token,this.image,this.namefirst,this.namelast,this.country,this.username,this.phoneuser,});

  _price_taseer_order createState() => _price_taseer_order();
}
class  _price_taseer_order extends State<price_taseer_order> {
  // AnimationController _animationController;
  int _page = 0;
  final List1 = [];
  var ListDate1 = [];
  final List2 = [];
  var ListDate2 = [];
  var ListBlock=["8.00 - 9.00","9.00 - 10.00","","","",];
  var Listsearch=[];
  bool button1=false;
  bool button2=false;
  bool button3=false;
  bool button4=false;
  bool step3=false;

  Future getprice()async{
    var url='http://'+IP4+'/testlocalhost/pricerequest.php';
    var ressponse=await http.post(url,body: {
      "id_g": widget.id_g,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }

  @override
  void initState() {
    super.initState();
  }
  int _selectedItem = 1;
  PageController _pageController;
  DatabaseMethods databaseMethods=new DatabaseMethods();
  Stream chatsRoom;
  @override
  Widget build(BuildContext context) {
    print(Listsearch.toString());
    return Directionality(textDirection: ui.TextDirection.rtl,
      child:Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.white,
            body: Form(
              // child:SingleChildScrollView(
              child: Stack(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
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
                  //     ),),
                  //   child: Container(
                  //     margin:EdgeInsets.only(top:109),
                  //     child:SingleChildScrollView(
                  //       scrollDirection: Axis.horizontal,
                  //     ),
                  //   ),
                  // ),

                  GestureDetector(
                    onTap:(){
                      Navigator.pop(context,);
                      // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => U_PROFILE(name_Me: widget.name_Me,)));
                    },
                    child:Container(
                      margin: EdgeInsets.only(top:60,left: 10,right: 10),
                      child:Icon(Icons.arrow_back,color: Colors.black,),
                    ),
                  ),
                  // ),
                  Container(
                    width:370,
                    height: 70,
                    margin: EdgeInsets.only(top:100,right:20),
                    child:Text('تسعيرات طلب'+widget.desc, style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                      fontFamily: 'Changa',
                    ),
                    ),
                  ),
                  Container(
                    height: 647.5,
                    margin: EdgeInsets.only(top:120),
                    child: FutureBuilder(
                      future: getprice(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              print(snapshot.data.length);
                              print("WOWWWWWWWWWWWWWWWWWWWWWWWWW");
                              // return Container(height: 200,color:Colors.yellow,);
                              return viewtasser(country:snapshot.data[index]['country'],work:snapshot.data[index]['work'],phoneuser:widget.phoneuser,note:snapshot.data[index]['note'],price:snapshot.data[index]['price'],image:snapshot.data[index]['image'],name:widget.username,tokenworker:widget.token,imageworker:widget.image,namelastworker:widget.namelast,namefirstworker:widget.namefirst,id:snapshot.data[index]['id'],describes:snapshot.data[index]['descr'],namefirst: snapshot.data[index]['namefirst'], namelast: snapshot.data[index]['namelast'], workerphone: snapshot.data[index]['phoneuser']);
                            },
                          );
                        }
                        return Container(height: 0.0,);
                      },
                    ),
                  ),
                ],),),
          ),],),);
  }
  Future<void> _dialogCall() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return MyDialog(image:widget.image,namefirst:widget.namefirst,namelast:widget.namelast,phone:widget.phoneuser,);
        });
  }

}

class viewtasser extends StatefulWidget {
  final lat;
  final lng;
  final latuser;
  final lnguser;
  final orderimage;
  final phoneuser;
  final name;
  final describes;
  final namefirst;
  final namelast;
  final image;
  final type;
  final workerphone;
  final nameofwork;
  final start;
  final end;
  final id;
  final city;
  final country;
  final namefirstworker;
  final namelastworker;
  final imageworker;
  final tokenworker;
  final Information;
  final Experiance;
  final work;
  final from;
  final to;
  final price;
  final note;
  viewtasser({this.price,this.note,this.name,this.from,this.to,this.work,this.namefirstworker,this.namelastworker,this.imageworker,this.tokenworker,this.Experiance,this.Information,this.orderimage,this.latuser,this.lnguser,this.lng,this.lat,this.country,this.city,this.start,this.id,this.end,this.image,this.type,this.namelast,this.workerphone,this.namefirst,this.phoneuser,this.nameofwork,this.describes});
  @override
  _viewState createState() => _viewState();
}

class _viewState extends State<viewtasser> {
  @override
  bool datepicher=false;
  Future<void> _dialogCall() {
    print(widget.id);
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Directionality(textDirection: ui.TextDirection.rtl,
            child:MyDialog(country:widget.country,work:widget.work,namefirst:widget.namefirst,namelast:widget.namelast,image: widget.image,description:widget.describes,username:widget.name,id:widget.id,phoneworker:widget.workerphone,phone:widget.phoneuser,tokenworker:widget.tokenworker,token:widget.tokenworker,),);
        });
  }
  Widget build(BuildContext context) {
    return Column(

      children:[
        card(widget.namefirst,widget.namelast,widget.describes,widget.phoneuser,widget.workerphone,widget.nameofwork,widget.image,widget.type),

      ],);
  }
  Widget card(String namefirst , String namelast,String describes,String phoneuser,String workerphone,String nameofwork,String image,String type)
  {
  return GestureDetector(
    onTap: (){
      // Navigator.push(context, MaterialPageRoute(builder: (context) => State_warshe_accept(name:widget.name,type:widget.type,from:widget.from,to:widget.to,tokenworker:widget.tokenworker,imageworker:widget.imageworker,namelastworker:widget.namelastworker,namefirstworker:widget.namefirstworker,Information:widget.Information,Experiance:widget.Experiance,work:widget.work,country:widget.country,city:widget.city,description:widget.describes,latuser:widget.latuser,lnguser:widget.lnguser,lat:widget.lat,lng:widget.lng,orderimage:widget.orderimage,workername:widget.nameofwork,id:widget.id,namefirst: widget.namefirst,namelast: widget.namelast,phoneuser: widget.phoneuser,image: widget.image,phoneworker:widget.workerphone),),);
    },
    child:Container (
      height:140,
      width: 380,
      transform: Matrix4.translationValues(0.0, 20.0, 0.0),
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(5),
      alignment: Alignment.topRight,
      decoration: BoxDecoration(
        color:Colors.grey[50],
        borderRadius: BorderRadius.circular(5),
      ),
      clipBehavior: Clip.hardEdge,
      child:Column(
        children: [
          Row(
            children: [
              Container(
                // print(_image[index].id+"");
                transform: Matrix4.translationValues(0.0, -15, 0.0),
                width: 75,
                height: 75,
                margin: EdgeInsets.only(right:10,top:0),
                decoration: BoxDecoration(
                  color:Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(image: NetworkImage('http://'+IP4+'/testlocalhost/upload/'+widget.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: 280,
                child:Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top:5,right: 10),
                      child:  Row(
                        children: [
                          // Container(
                          //   width:90,
                          //   child:Text('اسم العميل ', style: TextStyle(
                          //     fontSize: 14,
                          //     fontWeight: FontWeight.w700,
                          //     color: Colors.black87,
                          //     fontFamily: 'Changa',
                          //   ),
                          //   ),
                          // ),
                          Container(
                            width:170,
                            child:Text(namefirst + " " +namelast, style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                              fontFamily: 'Changa',
                            ),
                            ),
                          ),

                        ],
                      ),
                    ),
                    Container(
                      width:280,
                      margin: EdgeInsets.only(top:0,right: 10),
                      child:Row(
                        children: [
                          Text('السعر  '+widget.price, style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                            fontFamily: 'Changa',
                          ),
                          ),
                          Icon(Icons.attach_money_outlined,size: 20,),
                        ],
                      ),
                    ),
                    widget.note==null || widget.note=='no'?Container(height:32,):
                    Container(
                      height:32,
                      margin: EdgeInsets.only(top:0,right: 0),
                      child:  Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top:5,right: 10),
                            child:  Row(
                              children: [
                                Container(
                                  width:50,
                                  child:Text('ملاحظة ', style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black87,
                                    fontFamily: 'Changa',
                                  ),
                                  ),
                                ),
                                Container(
                                  width:170,
                                  child:Text(widget.note, style: TextStyle(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black87,
                                    fontFamily: 'Changa',
                                  ),
                                  ),
                                ),

                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                    Container(
                      width: 280,
                      height: 30,
                      margin: EdgeInsets.only(right: 15,top:5),
                      child: Row(
                        children: [
                          SizedBox(width:200,),
                          GestureDetector(
                            onTap: () async{
                              await delete();
                              await _dialogCall();
                              // await _showDialog();
                            },
                            child: Container(
                              width: 55,
                              height: 25,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Y,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child:Text('طلب الآن',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87,
                                      fontFamily: 'Changa',
                                    ),),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Image.asset('assets/card-sample-image.jpg'),
                    // Image.asset('assets/card-sample-image-2.jpg'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  }
  Future<void> delete() async {
    int i = 0;
    var url ='http://'+IP4+'/testlocalhost/deletetasser.php';
    var ressponse = await http.post(url, body: {
      "id": widget.id,

    });
  }

  Future<void> addlongtimework(final List<DateTime> picked) async {
  }
  Future<void> _showMyDialogo( ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('تضارب في المواعيد'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("يوجد لديك حجز في التاريخ المختار"),
                Text('اختر موعدا اخر'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

          ],
        );
      },
    );
  }
  int _n=0;
  void minus() {
    setState(() {
      if (_n != 0)
        _n--;
      f=true;
    });
  }
  void add() {
    setState(() {
      _n++;
      f=true;
    });
  }
  bool f=false;
  TextEditingController count =TextEditingController();
  TextEditingController description =TextEditingController();

  Future<void> _showMyDialogo1( ) async {
    count.text='0';
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
                  width: 300,
                  margin: EdgeInsets.only(top:5),
                  child:  Row(
                    children: [
                      Container(
                        width: 150,
                        height:35,
                        margin: EdgeInsets.only(left:5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          // color: Colors.black87,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              color:Y,
                              child:GestureDetector(
                                onTap: (){
                                  _n++;
                                  setState(() {
                                    count.text=_n.toString();
                                    // contentText = "Changed Content of Dialog";
                                  });
                                },
                                child: Icon(Icons.add),
                              ),
                            ),

                            Container(
                              width:70,
                              height: 30,
                              color:Colors.grey[100],
                              padding: EdgeInsets.only(top:5),
                              // alignment:Alignment.center,
                              child: TextFormField(
                                cursorColor:Colors.grey[600],
                                textAlign: TextAlign.center,
                                //controller: text_post,
                                controller: count,
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 15.0,
                                  fontFamily: 'Changa',
                                  fontWeight: FontWeight.bold,
                                ),
                                onEditingComplete: (){
                                  _n=int.parse(count.text);
                                  print("ASDASDASDASDASDASD");
                                  print(_n.toString());
                                },
                                onChanged: (content) {
                                  _n=int.parse(count.text);
                                  print("ASDASDASDASDASDASD");
                                  print(_n.toString());
                                  setState(() {

                                  });
                                },
                                //o: Desc(),
                                decoration: InputDecoration(
                                  hoverColor:Colors.black54,
                                  contentPadding: EdgeInsets.only(top:0),
                                  enabledBorder: new OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(30.0),
                                    borderSide:  BorderSide(color: Colors.grey[100]),

                                  ),
                                  focusedBorder: new OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(30.0),
                                    borderSide:  BorderSide(color:Colors.grey[100]),

                                  ),
                                  // hintText: 'أضف تفصيل لطلبك لتسعيره',
                                  focusColor:Colors.black54,
                                  hintStyle: TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: 'Changa',
                                    color: Colors.grey.withOpacity(0.8),
                                  ),
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                ),
                              ),
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              color:Y,
                              // alignment:Alignment.center,
                              child:GestureDetector(
                                onTap: (){
                                  _n--;
                                  setState(() {
                                    count.text=_n.toString();
                                    // contentText = "Changed Content of Dialog";
                                  });
                                },
                                child: Icon(Icons.remove,),
                                // child: Text('_',
                                //   style: TextStyle(
                                //     fontSize: 20,
                                //     fontWeight: FontWeight.w700,
                                //     color: Colors.black87,
                                //     fontFamily: 'Changa',
                                //   ),
                                // ),
                              ),
                            ),

                          ],
                        ),
                      ),
                      SizedBox(width: 50,),
                      Container(
                        width:90,
                        child:Text('السعر بالدولار', style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                          fontFamily: 'Changa',
                        ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 35,),
                Container(
                  width:280,
                  height: 70,
                  margin: EdgeInsets.only(right:20),
                  child: TextFormField(
                    cursorColor:Colors.grey[600],
                    textAlign: TextAlign.right,
                    //controller: text_post,
                    maxLines: 20,
                    controller: description,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14.0,
                      fontFamily: 'Changa',
                      fontWeight: FontWeight.bold,
                    ),
                    //o: Desc(),
                    decoration: InputDecoration(
                      // filled:true,
                      // fillColor:Colors.grey[100],
                      hoverColor:Colors.black54,
                      contentPadding: EdgeInsets.all(1.0),
                      enabledBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(7.0),
                        borderSide:  BorderSide(color:Colors.white),

                      ),
                      focusedBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(7.0),
                        borderSide:  BorderSide(color:Colors.white),

                      ),
                      hintText: 'إضافة ملاحظة إذا أردت ',
                      focusColor:Colors.black54,
                      hintStyle: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'Changa',
                        color: Colors.black54,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
                Container(
                  width: 400,
                  child:Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                            margin: EdgeInsets.only(left:20,right:25),
                            child:Text('إلغاء',
                              style: TextStyle(
                                fontFamily: 'Changa',
                                color:Y,
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                        ),
                      ),
                      GestureDetector(
                        onTap: ()async{
                          await price();
                          // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => taasser(name: widget.name,phone: widget.workerphone,Information:widget.Information,Experiance:widget.Experiance,Work:widget.work,namelast:widget.namelast,image:widget.image,token:widget.tokenworker,namefirst:widget.namefirst)));
                        },
                        child: Container(
                            margin: EdgeInsets.only(right: 50),
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
                  ),),
              ],
            );
          },
        );
      },
    );
  }
  Future<void> price() async {
    int i = 0;
    if(description.text.isEmpty){
      description.text='no';
    }
    var url ='http://'+IP4+'/testlocalhost/accepttaseer.php';
    var ressponse = await http.post(url, body: {
      "id": widget.id,
      "price":count.text,
      "note":description.text,
    });
  }
}

class MyDialog extends StatefulWidget {
  @override
  final work;
  final phone;
  final id;
  final token;
  final tokenworker;
  final phoneworker;
  final username;
  final description;
  final namefirst;
  final namelast;
  final image;
  final country;
  PickedFile im_file;
  MyDialog({this.im_file,this.country,this.work,this.namefirst,this.namelast,this.image,this.description,this.phone,this.id,this.username,this.token,this.phoneworker,this.tokenworker});
  _MyDialogState createState() => new _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {

  // String imagePath;
  // Image image;
  // File image_file;
  @override
  Widget build(BuildContext context){
    return AlertDialog(
      backgroundColor: Colors.white,
      actionsPadding: EdgeInsets.zero,
      content: new SingleChildScrollView(
        child: new ListBody(
          children: <Widget>[
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 0,top: 10),
                  child: Text('هل أنت متأكد من أنك تريد حجز هذا الطلب ؟',
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
                      onTap: () async{
                        await reserve();
                        // Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => not_conferm_user_statues(country:widget.country,work:widget.work,name_Me:widget.username,id:widget.id,phoneworker:widget.phoneworker,description:widget.description,namefirst: widget.namefirst,namelast: widget.namelast,phoneuser: widget.phone,image: widget.image,),),);

                      },
                      child: Container(
                          margin: EdgeInsets.only(right: 170),
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
                  ],
                ),
                // SizedBox(width: 10,),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Future uploadFile() async {
    print("hiiii");
    File _file;
    _file = File(widget.im_file.path);
    print("hiiii");
    // print(image_file.path);
    if (_file == Null) {
      return;
    }
    print("hiiii");
    String base64 = base64Encode(_file.readAsBytesSync());
    String imagename = _file.path.split('/').last;
    print("hiiii");
    print(imagename);
    print(base64);
    var url = 'http://'+IP4+'/testlocalhost/EXP_Image.php';
    // final uri=Uri.parse("http://192.168.2.111/testlocalhost/signup.php");
    var response = await http.post(url, body: {

      "phone": '9564122',
      "imagename": imagename,
      "image64": base64,
    });
    setState(() {

    });
    String massage= json.decode(response.body);
    print(massage);
  }
  Future reserve()async{
    File _file;
    DateTime date=DateTime.now();
    var formattedDate = DateFormat('yyyy-MM-dd').format(date);
    var formattedTime = DateFormat('HH:mm:ss').format(date);
    print("''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''");
    var url;
    var ressponse;
      print(widget.description);
      print(widget.id);
      print(widget.phone);
      print(widget.token);
      print(widget.tokenworker);
      print(widget.username);

      url = 'http://'+IP4+'/testlocalhost/reserve.php';
      ressponse = await http.post(url, body: {
        "description": widget.description,
        "phone": widget.phone,
        "id": widget.id,
        "tokenuser": "",
        "tokenworker": "",
        "phoneworker": widget.phoneworker,
        "username": widget.username,
        "datesend": formattedDate,
        "timesend": formattedTime,
      });
      //String massage= json.decode(ressponse.body);
    //print(massage);
  }}


