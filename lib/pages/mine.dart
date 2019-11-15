import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../adaptor.dart';
import '../assets.dart';
import '../colors.dart';
import '../iconfont.dart';
import '../router.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MineState();
}

class MineState extends State<MinePage> {
  @override
  void initState() {
    super.initState();
  }

  void _toTask() {
    AppRouter.router
        .navigateTo(context, 'tasks', transition: TransitionType.material);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('我的',
                style: TextStyle(
                    fontSize: Adaptor.px(32.0), color: AppColors.appTextDark))),
        body: new Container(
            padding: EdgeInsets.only(
                left: Adaptor.px(16.0), right: Adaptor.px(16.0)),
            child: new SingleChildScrollView(
                child: new Column(children: <Widget>[
              new Wrap(children: <Widget>[
                new Container(
                    width: Adaptor.screenW(),
                    height: Adaptor.px(350.0),
                    margin: EdgeInsets.only(top: Adaptor.px(30.0)),
                    padding: EdgeInsets.only(
                        top: Adaptor.px(30.0),
                        left: Adaptor.px(30.0),
                        right: Adaptor.px(30.0)),
                    decoration: new BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.appYellowShadow,
                              blurRadius: 8.0,
                              offset: Offset(2.0, 1.0))
                        ],
                        gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                              AppColors.appYellow,
                              AppColors.appYellowLight
                            ])),
                    child: new Wrap(
                      children: <Widget>[
                        new Container(
                          child: new Center(
                            child: new Column(
                              children: <Widget>[
                                new Image.asset(
                                  Assets.iconAvatar,
                                  width: Adaptor.px(100.0),
                                  height: Adaptor.px(100.0),
                                ),
                                new Padding(
                                  padding: EdgeInsets.only(
                                      top: Adaptor.px(10.0),
                                      bottom: Adaptor.px(20.0)),
                                  child: new Text('未登录',
                                      style: TextStyle(
                                          fontSize: Adaptor.px(32.0),
                                          color: AppColors.appTextDark)),
                                )
                              ],
                            ),
                          ),
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            new Column(
                              children: <Widget>[
                                new Text('0',
                                    style: TextStyle(
                                        fontSize: Adaptor.px(48.0),
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.appTextDark)),
                                new Padding(
                                  padding: EdgeInsets.all(Adaptor.px(16.0)),
                                  child: new Text(
                                    '记账天数',
                                    style: TextStyle(
                                        fontSize: Adaptor.px(32.0),
                                        color: AppColors.appTextDark),
                                  ),
                                )
                              ],
                            ),
                            new Column(
                              children: <Widget>[
                                new Text('0',
                                    style: TextStyle(
                                        fontSize: Adaptor.px(48.0),
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.appTextDark)),
                                new Padding(
                                  padding: EdgeInsets.all(Adaptor.px(16.0)),
                                  child: new Text(
                                    '记账笔数',
                                    style: TextStyle(
                                        fontSize: Adaptor.px(32.0),
                                        color: AppColors.appTextDark),
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    )),
                new Container(
                    margin: EdgeInsets.only(top: Adaptor.px(20.0)),
                    padding: EdgeInsets.only(left: Adaptor.px(20.0)),
                    decoration: new BoxDecoration(
                        color: AppColors.appWhite,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.appBlackShadow, blurRadius: 5.0)
                        ]),
                    child: new Wrap(children: <Widget>[
                      new Container(
                          height: Adaptor.px(100.0),
                          decoration: new BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                  bottom: BorderSide(
                                      width: Adaptor.onePx(),
                                      color: AppColors.appBorderLight))),
                          child: new FlatButton(
                              onPressed: _toTask,
                              child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  new Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      new Image.asset(Assets.iconTask,
                                          width: Adaptor.px(32.0),
                                          height: Adaptor.px(32.0)),
                                      new Padding(
                                        padding: EdgeInsets.only(
                                            left: Adaptor.px(12.0)),
                                        child: new Text(
                                          '记账任务',
                                          style: TextStyle(
                                              color: AppColors.appTextDark,
                                              fontSize: Adaptor.px(32.0),
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ],
                                  ),
                                  new Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      new Text(
                                        '3个记账任务',
                                        style: TextStyle(
                                            color: AppColors.appTextLight,
                                            fontSize: Adaptor.px(28.0),
                                            fontWeight: FontWeight.normal),
                                      ),
                                      new Icon(IconFont.iconRight,
                                          color: AppColors.appTextLight,
                                          size: Adaptor.px(36.0))
                                    ],
                                  )
                                ],
                              ))),
                      new Container(
                        height: Adaptor.px(100.0),
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                bottom: BorderSide(
                                    width: Adaptor.onePx(),
                                    color: AppColors.appBorderLight))),
                        child: new FlatButton(
                            onPressed: () => {},
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                new Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    new Image.asset(Assets.iconReminder,
                                        width: Adaptor.px(32.0),
                                        height: Adaptor.px(32.0)),
                                    new Padding(
                                      padding: EdgeInsets.only(
                                          left: Adaptor.px(12.0)),
                                      child: new Text(
                                        '存钱提醒',
                                        style: TextStyle(
                                            color: AppColors.appTextDark,
                                            fontSize: Adaptor.px(32.0),
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ],
                                ),
                                new Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    new Text(
                                      '每天09:00,10:00 各一次',
                                      style: TextStyle(
                                          color: AppColors.appTextLight,
                                          fontSize: Adaptor.px(28.0),
                                          fontWeight: FontWeight.normal),
                                    ),
                                    new Icon(IconFont.iconRight,
                                        color: AppColors.appTextLight,
                                        size: Adaptor.px(36.0))
                                  ],
                                )
                              ],
                            )),
                      ),
                      new Container(
                          height: Adaptor.px(100.0),
                          decoration: new BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                  bottom: BorderSide(
                                      width: Adaptor.onePx(),
                                      color: AppColors.appBorderLight))),
                          child: new FlatButton(
                              onPressed: () => {},
                              child: new Row(
                                    mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    new Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        new Image.asset(Assets.iconLimit,
                                            width: Adaptor.px(32.0),
                                            height: Adaptor.px(32.0)),
                                        new Padding(
                                          padding: EdgeInsets.only(
                                              left: Adaptor.px(12.0)),
                                          child: new Text(
                                            '我的预算',
                                            style: TextStyle(
                                                color: AppColors.appTextDark,
                                                fontSize: Adaptor.px(32.0),
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ],
                                    ),
                                    new Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          new Text(
                                            '￥20000',
                                            style: TextStyle(
                                                color: AppColors.appTextLight,
                                                fontSize: Adaptor.px(28.0),
                                                fontWeight: FontWeight.normal),
                                          ),
                                          new Icon(IconFont.iconRight,
                                              color: AppColors.appTextLight,
                                              size: Adaptor.px(36.0))
                                        ])
                                  ]))),
                      new Container(
                          height: Adaptor.px(100.0),
                          decoration: new BoxDecoration(color: Colors.white),
                          child: new FlatButton(
                              onPressed: () => {},
                              child: new Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    new Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        new Image.asset(Assets.iconCircle,
                                            width: Adaptor.px(32.0),
                                            height: Adaptor.px(32.0)),
                                        new Padding(
                                          padding: EdgeInsets.only(
                                              left: Adaptor.px(12.0)),
                                          child: new Text(
                                            '记账圈子',
                                            style: TextStyle(
                                                color: AppColors.appTextDark,
                                                fontSize: Adaptor.px(32.0),
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ],
                                    ),
                                    new Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          new Text(
                                            '2个圈子',
                                            style: TextStyle(
                                                color: AppColors.appTextLight,
                                                fontSize: Adaptor.px(28.0),
                                                fontWeight: FontWeight.normal),
                                          ),
                                          new Icon(IconFont.iconRight,
                                              color: AppColors.appTextLight,
                                              size: Adaptor.px(36.0))
                                        ])
                                  ])))
                    ]))
              ])
            ]))));
  }
}
