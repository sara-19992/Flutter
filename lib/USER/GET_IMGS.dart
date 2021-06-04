import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterphone/screens/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';

import '../constants.dart';
import 'IMG_BIG.dart';
String IP4="192.168.1.8:8080";
List<Images> imagesFromJson(String str) => List<Images>.from(json.decode(str).map((x) => Images.fromJson(x)));

String imagesToJson(List<Images> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Images {
  String images;
  String phone;
  String id;

  Images({
    this.images,
    this.phone,
    this.id,
  });

  factory Images.fromJson(Map<String, dynamic> json) => Images(
    images: json["images"],
    phone: json["phone"],
    id   :  json["id"],
  );

  Map<String, dynamic> toJson() => {
    "images": images,
    "phone" : phone,
    "id"    : id,
  };
}
class Get_Images extends StatefulWidget {
  final phone;
  final name;
  Get_Images({this.phone,this.name});
  _Get_Images createState() =>  _Get_Images();
}
class  _Get_Images extends State< Get_Images> {
  @override
  void initState() {
    super.initState();
  }
  bool first=true;
  File uploadimage;
  // File _file;
  List<File> _image = []; //هاي هي
  int counter = 0;
  File _file;
  final picker = ImagePicker();
  @override
  Future getImages() async {
    var url = 'http://'+IP4+'/testlocalhost/Show_EXP.php';
    var ressponse = await http.post(url, body: {
      "phone": widget.phone,
    });
    return json.decode(ressponse.body);
  }
  Widget build(BuildContext context) {
    return Directionality( textDirection: TextDirection.rtl,
    child:Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0), // here the desired height
          child: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            //leading: I,
          )
      ),
      // backgroundColor: Colors.lightBlueAccent,
      body: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Stack(
                children:[
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    height: 180,
                     decoration: BoxDecoration(
                       color:Colors.white,
                     ),
                  ),

                  // Container(
                  //   margin: EdgeInsets.fromLTRB(100, 50, 1, 0),
                  //   child: IconButton(
                  //     alignment: Alignment.topRight,
                  //     onPressed: () {
                  //       Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>PROFILE(name:widget.name)));
                  //       },
                  //     icon: Icon(
                  //       Icons.arrow_back,
                  //       color: Colors.white,
                  //       size: 30.0,
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   margin: EdgeInsets.fromLTRB(50, 100, 1, 0),
                  //   child:Text(
                  //     'ألبوم صوري',
                  //     style: TextStyle(
                  //       fontSize: 25,
                  //       fontWeight: FontWeight.w600,
                  //       color: Colors.white,
                  //     ),
                  //     textAlign: TextAlign.center,
                  //
                  //   ),),
                   Row(
                  children :[

                    Expanded(
                    child:Column(
                      children: <Widget>[
                      Container(
                      height:685,
                      margin: EdgeInsets.only(top:20),
                      padding: EdgeInsets.only(top:30,right: 15,left: 15,),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(

                        ),
                      ),
                      child:FutureBuilder(
                        future: getImages(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if(snapshot.hasData){
                            return GridView.builder(
                              padding: EdgeInsets.only(top: 1,bottom: 10),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15,
                              ),
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                int count=0;
                                return RawMaterialButton(
                                  onPressed: () {
                                    Navigator.push(context,MaterialPageRoute(
                                        builder: (BuildContext context) =>IMG(imageName:snapshot.data[index]['images'],index:index,phone:snapshot.data[index]['phone'],id:snapshot.data[index]['id'])));},
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => DetailsPage(
                                  //       imagePath: _images[index].imagePath,
                                  //       title: _images[index].title,
                                  //       photographer: _images[index].photographer,
                                  //       price: _images[index].price,
                                  //       details: _images[index].details,
                                  //       index: index,
                                  //     ),
                                  //   ),
                                  // );

                                  child: Hero(
                                    tag: 'logo$index',
                                    child: Container(
                                      // print(_image[index].id+"");
                                      //  child: Text(_image[inde),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(image: NetworkImage('http://'+IP4+'/testlocalhost/upload/'+snapshot.data[index]['images']),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                );}

                            );
                          }
                          return Center(child: CircularProgressIndicator());
                        },
                      ),
                      // / itemCount: _image.length,
                      ),
                   ],), ),
                 ], ),  ],),
     ],),  ),),
    );
  }
  void False(){
    first=false;
  }
  chooseImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image.add(File(pickedFile?.path));
      uploadFile();
    });
    if (pickedFile.path == null) retrieveLostData();

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
    String imagename = _file.path.split('/').last;
    print("hiiii");
    print(imagename);
    var url = 'http://'+IP4+'/testlocalhost/EXP_Image.php';
    // final uri=Uri.parse("http://192.168.2.111/testlocalhost/signup.php");
    var response = await http.post(url, body: {

      "phone": widget.phone,
      "imagename": imagename,
      "image64": base64,
    });
    setState(() {

    });
    String massage= json.decode(response.body);
    print(massage);
  }
  void m(){
    print("::>>>");
  }

}

