import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../assets.dart';
import '../iconfont.dart';
import '../colors.dart';

class TaskPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TaskState();
}

class TaskState extends State<TaskPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 1080, allowFontScaling: true)
      ..init(context);

    return Scaffold(
        appBar: AppBar(title: Text('记账任务', style: TextStyle(fontSize: 16.0))),
        body: new Container(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: new SingleChildScrollView(
                child: new Column(children: <Widget>[
                  new Wrap(children: <Widget>[
                    new Container(
                        width: ScreenUtil.getInstance().setWidth(1080),
                        height: ScreenUtil.getInstance().setWidth(485),
                        margin: const EdgeInsets.only(top: 10.0),
                        padding:
                        const EdgeInsets.only(top: 20, left: 10, right: 10),
                        decoration: new BoxDecoration(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.appYellowShadow,
                                  blurRadius: 8.0,
                                  offset: Offset(2.0, 1.0))
                            ],
                            gradient: const LinearGradient(
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
                                      width: 50,
                                      height: 50,
                                    ),
                                    new Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5.0, bottom: 10.0),
                                      child: new Text('未登录',
                                          style: const TextStyle(
                                              fontSize: 18.0,
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
                                        style: const TextStyle(
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.appTextDark)),
                                    new Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: new Text(
                                        '记账天数',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: AppColors.appTextDark),
                                      ),
                                    )
                                  ],
                                ),
                                new Column(
                                  children: <Widget>[
                                    new Text('0',
                                        style: const TextStyle(
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.appTextDark)),
                                    new Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: new Text(
                                        '记账笔数',
                                        style: const TextStyle(
                                            fontSize: 16,
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
                        margin: const EdgeInsets.only(top: 10.0),
                        padding: const EdgeInsets.only(left: 10.0),
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
                              height: ScreenUtil.getInstance().setHeight(120.0),
                              decoration: new BoxDecoration(
                                  color: Colors.white,
                                  border: const Border(
                                      bottom: const BorderSide(
                                          width: 0.5,
                                          color: AppColors.appBorderLight))),
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
                                          new Image.asset(Assets.iconTask,
                                              width: 16.0, height: 16.0),
                                          new Padding(
                                            padding:
                                            const EdgeInsets.only(left: 6.0),
                                            child: new Text(
                                              '记账任务',
                                              style: const TextStyle(
                                                  color: AppColors.appTextDark,
                                                  fontSize: 16.0,
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
                                            style: const TextStyle(
                                                color: AppColors.appTextLight,
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          new Icon(IconFont.iconRight,
                                              color: AppColors.appTextLight,
                                              size: 20)
                                        ],
                                      )
                                    ],
                                  ))),
                          new Container(
                            height: ScreenUtil.getInstance().setHeight(120.0),
                            decoration: new BoxDecoration(
                                color: Colors.white,
                                border: const Border(
                                    bottom: const BorderSide(
                                        width: 0.5,
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
                                            width: 16.0, height: 16.0),
                                        new Padding(
                                          padding: const EdgeInsets.only(left: 6.0),
                                          child: new Text(
                                            '存钱提醒',
                                            style: const TextStyle(
                                                color: AppColors.appTextDark,
                                                fontSize: 16.0,
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
                                          style: const TextStyle(
                                              color: AppColors.appTextLight,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        new Icon(IconFont.iconRight,
                                            color: AppColors.appTextLight, size: 18)
                                      ],
                                    )
                                  ],
                                )),
                          ),
                          new Container(
                              height: ScreenUtil.getInstance().setHeight(120.0),
                              decoration: new BoxDecoration(
                                  color: Colors.white,
                                  border: const Border(
                                      bottom: const BorderSide(
                                          width: 0.5,
                                          color: AppColors.appBorderLight))),
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
                                            new Image.asset(Assets.iconLimit,
                                                width: 16.0, height: 16.0),
                                            new Padding(
                                              padding:
                                              const EdgeInsets.only(left: 6.0),
                                              child: new Text(
                                                '我的预算',
                                                style: const TextStyle(
                                                    color: AppColors.appTextDark,
                                                    fontSize: 16.0,
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
                                                style: const TextStyle(
                                                    color: AppColors.appTextLight,
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.normal),
                                              ),
                                              new Icon(IconFont.iconRight,
                                                  color: AppColors.appTextLight,
                                                  size: 18)
                                            ])
                                      ]))),
                          new Container(
                              height: ScreenUtil.getInstance().setHeight(120.0),
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
                                                width: 16.0, height: 16.0),
                                            new Padding(
                                              padding:
                                              const EdgeInsets.only(left: 6.0),
                                              child: new Text(
                                                '记账圈子',
                                                style: const TextStyle(
                                                    color: AppColors.appTextDark,
                                                    fontSize: 16.0,
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
                                                style: const TextStyle(
                                                    color: AppColors.appTextLight,
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.normal),
                                              ),
                                              new Icon(IconFont.iconRight,
                                                  color: AppColors.appTextLight,
                                                  size: 18)
                                            ])
                                      ])))
                        ]))
                  ])
                ]))));
  }
}
