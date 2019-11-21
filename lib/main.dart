import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';

import './bottom_navigation_widget.dart';
import './pages/create-reminder.dart';
import './pages/create-task.dart';
import './pages/record.dart';
import './pages/save-reminder.dart';
import './pages/tasks.dart';
import './pages/limit-set.dart';
import './router.dart';

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
