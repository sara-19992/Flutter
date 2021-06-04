import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterphone/screens/welcome.dart';
import 'package:flutterphone/constants.dart';
import 'package:sentiment_dart/sentiment_dart.dart';
import 'dart:io';
import 'USER/Comment.dart';
import 'USER/Rate_Me.dart';
import 'vb.dart';
import 'Localnotification.dart';
import 'USER/Search.dart';
import 'USER/xc.dart';
import 'USER/Setting_user.dart';
import 'new_map.dart';
import 'notificationscreen.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
@override
void main() async {
  final sentiment = Sentiment();
  print(sentiment.analysis('i hate you piece of shit 💩'));

  print(sentiment.analysis('ايها الكلب تافه',emoji: true));
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  DateTime _selectedDay = DateTime.now();
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
       primaryColor: MY_YELLOW,
       visualDensity: VisualDensity.adaptivePlatformDensity,
       // scaffoldBackgroundColor: Colors.white,
      ),
        // home: My_SLot(phoneworker: '+970595320479',phone:'+97055',tokenworker:'lkk',time: _selectedDay,),
        // home: not_conferm__order(time: _selectedDay,phone: '+970595320479'),
         home: WelcomeScreen(),
        //   home: Rate(),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(debugShowCheckedModeBanner: false,
//       title: 'Get Request',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: HomePage(),
//     );
//   }
// }
//
// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//
//   String greetings = '';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Text(greetings, //Text that will be displayed on the screen
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//             Center(
//               child: Container( //container that contains the button
//                 width: 150,
//                 height: 60,
//                 child: FlatButton(
//                   color: Colors.blue,
//                   onPressed: () async { //async function to perform http get
//
//                     final response = await http.get('http://192.168.1.8:5000'); //getting the response from our backend server script
//
//                     final decoded = json.decode(response.body) as Map<String, dynamic>; //converting it from json to key value pair
//
//                     setState(() {
//                       greetings = decoded['greetings']; //changing the state of our widget on data update
//                     });
//
//                   },
//                   child: Text(
//                     'Press',
//                     style: TextStyle(fontSize: 24,),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:rate_my_app/rate_my_app.dart';
//
// import 'constants.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter Rating Prompt'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   RateMyApp _rateMyApp = RateMyApp(
//     preferencesPrefix: 'rateMyApp_',
//     minDays: 0,
//     minLaunches: 7,
//     remindDays: 2,
//     remindLaunches: 5,
//     // appStoreIdentifier: '',
//     // googlePlayIdentifier: '',
//   );
//
//   @override
//   void initState() {
//     super.initState();
//     _rateMyApp.init().then((_) {
//       if (_rateMyApp.shouldOpenDialog) {
//         _rateMyApp.showStarRateDialog(
//           context,
//           starRatingOptions: StarRatingOptions(
//
//           ),
//           actionsBuilder: (context, stars) {
//             return [
//               // Container(
//               //  // height: 131,
//               //  //  width: 500,
//               //  //  //transform: Matrix4.translationValues(0.0, -200.0, 0.0),
//               //  //  decoration: BoxDecoration(
//               //  //   color: Colors.transparent,
//               //  //  borderRadius: BorderRadius.only(
//               //  //  topLeft: Radius.circular(10),
//               //  //  topRight: Radius.circular(10),
//               //  //  bottomRight:  Radius.circular(10),
//               //  //   bottomLeft:  Radius.circular(10),
//               //  // ),),
//               //  child: Column(
//               //    children: [
//               //
//               //    ],
//               //  ),
//               // ),
//               Stack(
//                 children: [
//
//                   // GestureDetector(),
//                   //  Container(
//                   //    height: 50,
//                   //    child: FlatButton(
//                   //      onPressed: () {
//                   //        if (stars != null) {
//                   //          print("NULLLLLLLLLLLLLLLlllll");
//                   //          _rateMyApp.save().then((v) => Navigator.pop(context));
//                   //
//                   //          if (stars <= 3) {
//                   //            print("User Selected $stars");
//                   //          } else if (stars <= 5) {
//                   //            print('Leave a Review Dialog');
//                   //          }
//                   //        } else {
//                   //          Navigator.pop(context);
//                   //        }
//                   //      },
//                   //      child: Text('OK'),
//                   //    ),
//                   //  ),
//
//
//                   Container(
//                     transform: Matrix4.translationValues(0.0, 15.0, 0.0),
//                     width: 500,
//                     height:50,
//                   ),
//                   Container(
//                     transform: Matrix4.translationValues(0.0, 15, 0.0),
//                     width: 500,
//                     height: 1,
//                     child: Divider(
//                       color: Colors.black54,
//                       thickness: 0.2,
//                     ),
//                   ),
//                   Container(
//                       height: 65,
//                       transform: Matrix4.translationValues(0.0,10.0, 20.0),
//                       child: Row(
//                         children: [
//                           Container(
//                             width: 175,
//                             height: 65,
//                             margin: EdgeInsets.only(bottom:30),
//                             transform: Matrix4.translationValues(0.0,15.0, 0.0),
//                             child:GestureDetector(
//                               onTap: () {Navigator.pop(context);},
//                               child: Center(
//                                 child:Text('ليس الأن',style:
//                                 TextStyle(
//                                   fontFamily: 'Changa',
//                                   color:Y,
//                                   // backgroundColor: Colors.grey,
//                                   fontSize: 16.0,
//                                   fontWeight: FontWeight.bold,
//                                 ),),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             width: 2,
//                             height: 50,
//                             margin: EdgeInsets.only(bottom:5),
//                             child: VerticalDivider(
//                               color: Colors.black54,
//                               thickness: 0.2,
//                             ),
//                           ),
//                           Container(
//                             width: 160,
//                             height: 65,
//                             margin: EdgeInsets.only(bottom:30),
//                             transform: Matrix4.translationValues(0.0,15.0, 0.0),
//                             child:GestureDetector(
//                               onTap: () {
//                                 if (stars != null) {
//                                   print("NULLLLLLLLLLLLLLLlllll");
//                                   _rateMyApp.save().then((v) => Navigator.pop(context));
//
//                                   if (stars <= 3) {
//                                     print("User Selected $stars");
//                                   } else if (stars <= 5) {
//                                     print('Leave a Review Dialog');
//                                   }
//                                 } else {
//                                   Navigator.pop(context);
//                                 }
//                               },
//                               child:Center(
//                                 child:Text('تقييم',style:
//                                 TextStyle(
//                                   fontFamily: 'Changa',
//                                   color:Y,
//                                   // backgroundColor: Colors.grey,
//                                   fontSize: 16.0,
//                                   fontWeight: FontWeight.bold,
//                                 ),),
//                               ),
//                             ),
//                           ),
//                         ],
//                       )
//                   ),
//                   Container(
//                     height: 60,
//                     transform: Matrix4.translationValues(0.0, -200.0, 0.0),
//                     child:Center(
//                       child:Image.asset('assets/work/house-reforms.png', height: 60,
//                         width: 60,
//                         // color: Colors.white,
//                         fit: BoxFit.contain,),),
//
//                   ),
//                 ],
//               ),
//
//             ];
//           },
//           title: "هل أعجبك تطبيق صنايعي ؟",
//           message: "اضغط على النجم لتقييم صنايعي في متجر التطبيقات  ",
//           dialogStyle: DialogStyle(
//              messageStyle: TextStyle(
//               fontFamily: 'Changa',
//               color: Colors.black54,
//               // backgroundColor: Colors.grey,
//               fontSize: 14.0,
//               fontWeight: FontWeight.bold,
//              ),
//               titleStyle: TextStyle(
//                 fontFamily: 'Changa',
//                 color: Colors.black87,
//                 // backgroundColor: Colors.grey,
//                 fontSize: 15.0,
//                 fontWeight: FontWeight.bold,
//               ),
//               titleAlign: TextAlign.center,
//               messageAlign: TextAlign.center,
//               titlePadding:EdgeInsets.only(top: 90.0),
//               messagePadding: EdgeInsets.only(top: 10.0,bottom: 20)
//
//           ),
//
//         );
//       }
//     });
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//     );
//   }
// }