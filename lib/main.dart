import 'package:bill/bottom_navigation_widget.dart';
import 'package:bill/pages/circles/circles.dart';
import 'package:bill/pages/circles/create-circle.dart';
import 'package:bill/pages/circles/edit-circle.dart';
import 'package:bill/pages/limit/limit-set.dart';
import 'package:bill/pages/login.dart';
import 'package:bill/pages/record.dart';
import 'package:bill/pages/reminder/create-reminder.dart';
import 'package:bill/pages/reminder/edit-reminder.dart';
import 'package:bill/pages/reminder/reminder-detail.dart';
import 'package:bill/pages/reminder/save-reminder.dart';
import 'package:bill/pages/task/create-task.dart';
import 'package:bill/pages/task/edit-task.dart';
import 'package:bill/pages/task/task-detail.dart';
import 'package:bill/pages/task/tasks.dart';
import 'package:bill/router.dart';
import 'package:bill/stores/stores.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';

void main() {
  Router router = new Router();

  router.define('tasks',
      handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
              TaskPage()),
      transitionType: TransitionType.native);
  router.define('create-task',
      handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
              CreateTaskPage()),
      transitionType: TransitionType.native);
  router.define('edit-task',
      handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
              EditTaskPage()),
      transitionType: TransitionType.native);
  router.define('task-detail',
      handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
              TaskDetailPage()),
      transitionType: TransitionType.native);
  router.define('record',
      handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
              RecordPage()),
      transitionType: TransitionType.native);
  router.define('save-reminder',
      handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
              SaveReminderPage()),
      transitionType: TransitionType.native);
  router.define('create-reminder',
      handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
              CreateReminderPage()),
      transitionType: TransitionType.native);
  router.define('reminder-detail',
      handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
              ReminderDetailPage()),
      transitionType: TransitionType.native);
  router.define('edit-reminder',
      handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
              EditReminderPage()),
      transitionType: TransitionType.native);
  router.define('limit-set',
      handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
              LimitSetPage()),
      transitionType: TransitionType.native);
  router.define('circles',
      handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
              CirclesPage()),
      transitionType: TransitionType.native);
  router.define('create-circle',
      handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
              CreateCirclePage()),
      transitionType: TransitionType.native);
  router.define('edit-circle',
      handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
              EditCirclePage()),
      transitionType: TransitionType.native);
  router.define('login',
      handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
              LoginPage(target: params['target'][0])),
      transitionType: TransitionType.native);

  AppRouter.router = router;

  AppStores.initStores();

  runApp(BillApp());
}

class BillApp extends StatelessWidget {
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

    return new MaterialApp(
        title: '快记账',
        debugShowCheckedModeBanner: false,
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
            home: BottomNavigationWidget(),
        onGenerateRoute: AppRouter.router.generator
      );
  }
}
