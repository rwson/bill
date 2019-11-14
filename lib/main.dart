import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'package:fluro/fluro.dart';

//import 'package:flutter_jpush/flutter_jpush.dart';

import './bottom_navigation_widget.dart';
import './router.dart';

//import './device.dart';
//CurrentDevice currentDevice = new CurrentDevice();

import './pages/tasks.dart';

void main() {
  Router router = new Router();

  router.define('tasks', handler: Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => TaskPage()));

  AppRouter.router = router;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

//  com.rwson.bill

//  void _initJPush() async {
//    await FlutterJPush.startup();
//    print("初始化jpush成功");
//    var registrationID =await FlutterJPush.getRegistrationID();
//    print(registrationID);
//    _initNotification();
//  }
//
//  void _initNotification() async {
//    FlutterJPush.addReceiveNotificationListener(
//            (JPushNotification notification) {
//          print("收到推送提醒: $notification");
//        }
//    );
//
//    FlutterJPush.addReceiveOpenNotificationListener(
//            (JPushNotification notification) {
//          print("打开了推送提醒: $notification");
//        }
//    );
//  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white
    ));

    return MaterialApp(
      title: '快记账',
      theme: ThemeData(
        buttonTheme: ButtonThemeData(minWidth: double.infinity),
        primaryColor: Colors.white,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        appBarTheme: AppBarTheme(
          elevation: 0 // This removes the shadow from all App Bars.
        )
      ),
      home: BottomNavigationWidget()
    );
  }
}
