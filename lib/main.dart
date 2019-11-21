import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';

import 'package:bill/bottom_navigation_widget.dart';
import 'package:bill/pages/circles/circles.dart';
import 'package:bill/pages/circles/create-circle.dart';
import 'package:bill/pages/reminder/create-reminder.dart';
import 'package:bill/pages/task/create-task.dart';
import 'package:bill/pages/circles/edit-circle.dart';
import 'package:bill/pages/limit/limit-set.dart';
import 'package:bill/pages/record.dart';
import 'package:bill/pages/reminder/save-reminder.dart';
import 'package:bill/pages/task/tasks.dart';
import 'package:bill/pages/task/edit-task.dart';
import 'package:bill/router.dart';

void main() {
  Router router = new Router();

  router.define('tasks',
      handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
              TaskPage()));
  router.define('create-task',
      handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
              CreateTaskPage()));
  router.define('edit-task',
      handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
              EditTaskPage()));
  router.define('record',
      handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
              RecordPage()));
  router.define('save-reminder',
      handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
              SaveReminderPage()));
  router.define('create-reminder',
      handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
              CreateReminderPage()));
  router.define('limit-set',
      handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
              LimitSetPage()));
  router.define('circles',
      handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
              CirclesPage()));
  router.define('create-circle',
      handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
              CreateCirclePage()));
  router.define('edit-circle',
      handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
              EditCirclePage()));

  AppRouter.router = router;

  runApp(BillApp());
}

class BillApp extends StatefulWidget {
  @override
  BillAppState createState() => BillAppState();
}

class BillAppState extends State<BillApp> {
//  com.rwson.bill

//  Future<void> initMobileNumberState() async {
//    String mobileNumber = '';
//    try {
//      mobileNumber = await MobileNumber.mobileNumber;
//    } catch (e) {
//      debugPrint("Failed to get mobile number because of '${e.message}'");
//    }
//
//    if (!mounted) {
//      return;
//    }
//
//    print(mobileNumber);
//  }

  @override
  void initState() {
    super.initState();
//    initMobileNumberState();
  }

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
    FlutterStatusbarManager.setColor(Colors.white);
    return MaterialApp(
        title: '快记账',
        theme: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            buttonTheme: ButtonThemeData(
              minWidth: double.infinity,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            primaryColor: Colors.white,
            appBarTheme: AppBarTheme(
                elevation: 0 // This removes the shadow from all App Bars.
                )),
        home: BottomNavigationWidget());
  }
}
