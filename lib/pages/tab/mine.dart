import 'package:bill/adaptor.dart';
import 'package:bill/assets.dart';
import 'package:bill/colors.dart';
import 'package:bill/iconfont.dart';
import 'package:bill/router.dart';
import 'package:bill/stores/group.dart';
import 'package:bill/stores/limit.dart';
import 'package:bill/stores/reminder.dart';
import 'package:bill/stores/stores.dart';
import 'package:bill/stores/task.dart';
import 'package:bill/stores/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MineState();
}

class MineState extends State<MinePage> {
  final UserStore userStore = AppStores.userStore;
  final LimitStore limitStore = AppStores.limitStore;
  final ReminderStore reminderStore = AppStores.reminderStore;
  final TaskStore taskStore = AppStores.taskStore;
  final GroupStore groupStore = AppStores.groupStote;

  @override
  initState() {
    super.initState();
    _initPage();
  }

  Future<void> _initPage() async {
    bool logined = userStore.logined;
    if (logined) {
      userStore.getBillCount();
      limitStore.queryLimit(false);
      reminderStore.queryReminder(false);
      taskStore.queryTask(false);
      groupStore.queryGroups(false);
    }
  }

  void _toProfile() {
    AppRouter.toPage(context, 'profile');
  }

  void _toTask() {
    AppRouter.toPage(context, 'tasks');
  }

  void _toSaveReminder() {
    AppRouter.toPage(context, 'save-reminder');
  }

  void _toSetLimit() {
    AppRouter.toPage(context, 'limit-set');
  }

  void _toCircles() {
    AppRouter.toPage(context, 'groups');
  }

  @override
  void deactivate() {
    super.deactivate();
    bool current = ModalRoute.of(context).isCurrent;
    if (current) {
      _initPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('我的',
                style: TextStyle(
                    fontSize: Adaptor.px(32.0), color: AppColors.appTextDark))),
        body: Container(
            child: Observer(
                builder: (_) => Container(
                    margin: EdgeInsets.only(
                        top: Adaptor.px(10.0),
                        left: Adaptor.px(10.0),
                        right: Adaptor.px(10.0)),
                    child: Wrap(children: <Widget>[
                      Container(
                          width: Adaptor.px(1040.0),
                          height: Adaptor.px(350.0),
                          margin: EdgeInsets.only(
                              top: Adaptor.px(10.0),
                              left: Adaptor.px(10.0),
                              right: Adaptor.px(10.0)),
                          padding: EdgeInsets.only(
                              top: Adaptor.px(30.0),
                              left: Adaptor.px(30.0),
                              right: Adaptor.px(30.0)),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0)),
                              boxShadow: [
                                BoxShadow(
                                    color: AppColors.appYellowShadow,
                                    blurRadius: 8.0,
                                    offset: Offset(0, 1.0))
                              ],
                              gradient: LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    AppColors.appYellow,
                                    AppColors.appYellowLight
                                  ])),
                          child: Wrap(
                            children: <Widget>[
                              GestureDetector(
                                  onTap: _toProfile,
                                  child: Container(
                                    child: Center(
                                      child: Column(
                                        children: <Widget>[
                                          userStore.logined
                                              ?
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(
                                                    Adaptor.px(50.0)),
                                            child: Image.network(
                                                userStore.userInfo.avatar,
                                                width: Adaptor.px(100.0),
                                                height:
                                                    Adaptor.px(100.0)))
                                              : Image.asset(
                                                  Assets.iconAvatar,
                                                  width: Adaptor.px(100.0),
                                                  height: Adaptor.px(100.0),
                                                ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: Adaptor.px(10.0),
                                                bottom: Adaptor.px(20.0)),
                                            child: Text(
                                                userStore.logined
                                                    ? userStore
                                                        .userInfo.nickname
                                                    : '登录/注册',
                                                style: TextStyle(
                                                    fontSize: Adaptor.px(30.0),
                                                    color:
                                                        AppColors.appTextDark)),
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Text(userStore.billCount != null ? '${userStore.billCount.days}' : '0',
                                          style: TextStyle(
                                              fontSize: Adaptor.px(48.0),
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.appTextDark)),
                                      Padding(
                                        padding:
                                            EdgeInsets.all(Adaptor.px(16.0)),
                                        child: Text(
                                          '记账天数',
                                          style: TextStyle(
                                              fontSize: Adaptor.px(28.0),
                                              color: AppColors.appTextDark),
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text(userStore.billCount != null ? '${userStore.billCount.counts}' : '0',
                                          style: TextStyle(
                                              fontSize: Adaptor.px(48.0),
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.appTextDark)),
                                      Padding(
                                        padding:
                                            EdgeInsets.all(Adaptor.px(16.0)),
                                        child: Text(
                                          '记账笔数',
                                          style: TextStyle(
                                              fontSize: Adaptor.px(28.0),
                                              color: AppColors.appTextDark),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          )),
                      Container(
                          margin: EdgeInsets.only(
                              top: Adaptor.px(20.0),
                              left: Adaptor.px(10.0),
                              right: Adaptor.px(10.0),
                              bottom: Adaptor.px(20.0)),
                          padding: EdgeInsets.only(
                              left: Adaptor.px(14.0), right: 6.0),
                          decoration: BoxDecoration(
                              color: AppColors.appWhite,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0)),
                              boxShadow: [
                                BoxShadow(
                                    color: AppColors.appBlackShadow,
                                    blurRadius: 8.0,
                                    offset: Offset(0, 1.0))
                              ]),
                          child: Wrap(children: <Widget>[
                            Container(
                                height: Adaptor.px(84.0),
                                decoration: BoxDecoration(
                                    color: AppColors.appWhite,
                                    border: Border(
                                        bottom: BorderSide(
                                            width: Adaptor.onePx(),
                                            color: AppColors.appBorderLight))),
                                child: FlatButton(
                                    padding: EdgeInsets.only(
                                        left: Adaptor.px(20.0),
                                        right: Adaptor.px(10.0)),
                                    onPressed: _toTask,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Image.asset(Assets.iconTask,
                                                width: Adaptor.px(28.0),
                                                height: Adaptor.px(28.0)),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: Adaptor.px(12.0)),
                                              child: Text(
                                                '记账任务',
                                                style: TextStyle(
                                                    color:
                                                        AppColors.appTextDark,
                                                    fontSize: Adaptor.px(26.0),
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              (taskStore.tasks != null &&
                                                  taskStore.tasks.length >
                                                      0)
                                                  ? '${taskStore.tasks.length}个记账任务'
                                                  : '暂未添加记账任务',
                                              style: TextStyle(
                                                  color: AppColors.appTextLight,
                                                  fontSize: Adaptor.px(24.0),
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            Icon(IconFont.iconRight,
                                                color: AppColors.appTextLight,
                                                size: Adaptor.px(22.0))
                                          ],
                                        )
                                      ],
                                    ))),
                            Container(
                              height: Adaptor.px(84.0),
                              decoration: BoxDecoration(
                                  color: AppColors.appWhite,
                                  border: Border(
                                      bottom: BorderSide(
                                          width: Adaptor.onePx(),
                                          color: AppColors.appBorderLight))),
                              child: FlatButton(
                                  padding: EdgeInsets.only(
                                      left: Adaptor.px(20.0),
                                      right: Adaptor.px(10.0)),
                                  onPressed: _toSaveReminder,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Image.asset(Assets.iconReminder,
                                              width: Adaptor.px(28.0),
                                              height: Adaptor.px(28.0)),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: Adaptor.px(12.0)),
                                            child: Text(
                                              '存钱提醒',
                                              style: TextStyle(
                                                  color: AppColors.appTextDark,
                                                  fontSize: Adaptor.px(26.0),
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            (reminderStore.reminder != null &&
                                                    reminderStore
                                                            .reminder.length >
                                                        0)
                                                ? '${reminderStore.reminder.length}个记账提醒'
                                                : '暂未添加记账提醒',
                                            style: TextStyle(
                                                color: AppColors.appTextLight,
                                                fontSize: Adaptor.px(24.0),
                                                fontWeight: FontWeight.normal),
                                          ),
                                          Icon(IconFont.iconRight,
                                              color: AppColors.appTextLight,
                                              size: Adaptor.px(22.0))
                                        ],
                                      )
                                    ],
                                  )),
                            ),
                            Container(
                                height: Adaptor.px(84.0),
                                decoration: BoxDecoration(
                                    color: AppColors.appWhite,
                                    border: Border(
                                        bottom: BorderSide(
                                            width: Adaptor.onePx(),
                                            color: AppColors.appBorderLight))),
                                child: FlatButton(
                                    padding: EdgeInsets.only(
                                        left: Adaptor.px(20.0),
                                        right: Adaptor.px(10.0)),
                                    onPressed: _toSetLimit,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Image.asset(Assets.iconLimit,
                                                  width: Adaptor.px(28.0),
                                                  height: Adaptor.px(28.0)),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: Adaptor.px(12.0)),
                                                child: Text(
                                                  '我的预算',
                                                  style: TextStyle(
                                                      color:
                                                          AppColors.appTextDark,
                                                      fontSize:
                                                          Adaptor.px(26.0),
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  limitStore.limit > 0
                                                      ? '￥${limitStore.limit}'
                                                      : '暂未设置月预算',
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .appTextLight,
                                                      fontSize:
                                                          Adaptor.px(24.0),
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                                Icon(IconFont.iconRight,
                                                    color:
                                                        AppColors.appTextLight,
                                                    size: Adaptor.px(22.0))
                                              ])
                                        ]))),
                            Container(
                                height: Adaptor.px(84.0),
                                decoration:
                                    BoxDecoration(color: AppColors.appWhite),
                                child: FlatButton(
                                    padding: EdgeInsets.only(
                                        left: Adaptor.px(20.0),
                                        right: Adaptor.px(10.0)),
                                    onPressed: _toCircles,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Image.asset(Assets.iconCircle,
                                                  width: Adaptor.px(28.0),
                                                  height: Adaptor.px(28.0)),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: Adaptor.px(12.0)),
                                                child: Text(
                                                  '记账圈子',
                                                  style: TextStyle(
                                                      color:
                                                          AppColors.appTextDark,
                                                      fontSize:
                                                          Adaptor.px(26.0),
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  (groupStore.groups != null &&
                                                  groupStore.groups.length >
                                                      0)
                                                  ? '您有${groupStore.groups.length}个圈子'
                                                  : '暂未加入记账圈子',
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .appTextLight,
                                                      fontSize:
                                                          Adaptor.px(24.0),
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                                Icon(IconFont.iconRight,
                                                    color:
                                                        AppColors.appTextLight,
                                                    size: Adaptor.px(22.0))
                                              ])
                                        ])))
                          ]))
                    ])))));
  }
}
