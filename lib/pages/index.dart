import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

import '../adaptor.dart';
import '../assets.dart';
import '../colors.dart';
import '../iconfont.dart';
import '../router.dart';

class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<IndexPage> {
  @override
  void initState() {
    super.initState();
  }

  void _toRecord() {
    AppRouter.router
        .navigateTo(context, 'record', transition: TransitionType.material);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('首页', style: TextStyle(fontSize: 16.0))),
        body: new Container(
            padding: const EdgeInsets.all(8.0),
            child: new Column(children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Expanded(
                    flex: 1,
                    child: new Container(
                        height: Adaptor.px(180.0),
                        margin: EdgeInsets.only(
                            left: Adaptor.px(8.0), right: Adaptor.px(8.0)),
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
                        child: new Container(
                          margin: const EdgeInsets.only(left: 20.0),
                          child: new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Text(
                                  '支出',
                                  style: TextStyle(
                                    color: AppColors.appWhite,
                                    fontSize: Adaptor.px(26.0),
                                  ),
                                ),
                                new Padding(
                                  padding: EdgeInsets.only(
                                      top: Adaptor.px(6.0),
                                      bottom: Adaptor.px(6.0)),
                                  child: new Text('100.00',
                                      style: TextStyle(
                                          color: AppColors.appWhite,
                                          fontSize: Adaptor.px(34.0),
                                          fontWeight: FontWeight.w500)),
                                ),
                                new Text('比上月多100000',
                                    style: TextStyle(
                                        color: AppColors.appWhite,
                                        fontSize: Adaptor.px(26.0))),
                              ]),
                        )),
                  ),
                  new Expanded(
                      flex: 1,
                      child: new Container(
                          height: Adaptor.px(180.0),
                          margin: EdgeInsets.only(
                              left: Adaptor.px(8.0), right: Adaptor.px(8.0)),
                          decoration: new BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              boxShadow: [
                                BoxShadow(
                                    color: AppColors.appGreenShadow,
                                    blurRadius: 8.0,
                                    offset: Offset(2.0, 1.0))
                              ],
                              gradient: const LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    AppColors.appGreen,
                                    AppColors.appGreenLight
                                  ])),
                          child: new Container(
                            margin: const EdgeInsets.only(left: 20.0),
                            child: new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Text('收入',
                                      style: TextStyle(
                                          color: AppColors.appWhite,
                                          fontSize: Adaptor.px(26.0))),
                                  new Padding(
                                    padding: EdgeInsets.only(
                                        top: Adaptor.px(6.0),
                                        bottom: Adaptor.px(6.0)),
                                    child: new Text('100.00',
                                        style: TextStyle(
                                            color: AppColors.appWhite,
                                            fontSize: Adaptor.px(34.0),
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  new Text('比上月多100000',
                                      style: TextStyle(
                                        color: AppColors.appWhite,
                                        fontSize: Adaptor.px(26.0),
                                      )),
                                ]),
                          )))
                ],
              ),
              new Container(
                  margin: EdgeInsets.only(top: Adaptor.px(20.0)),
                  width: Adaptor.px(1020),
                  padding: const EdgeInsets.all(10.0),
                  decoration: new BoxDecoration(
                      color: AppColors.appWhite,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.appBlackShadow, blurRadius: 5.0)
                      ]),
                  child: new Wrap(children: <Widget>[
                    new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Text(
                            '本月预算',
                            style: TextStyle(
                                color: AppColors.appTextDark,
                                fontSize: Adaptor.px(28.0)),
                          ),
                          new Text('设置预算',
                              style: TextStyle(
                                  color: AppColors.appTextDark,
                                  fontSize: Adaptor.px(28.0)))
                        ]),
                    new Container(
                      margin: const EdgeInsets.only(top: 6.0, bottom: 6.0),
                      child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Text('￥100',
                                style: TextStyle(
                                    color: AppColors.appTextDark,
                                    fontSize: Adaptor.px(28.0))),
                            new Text('￥100',
                                style: TextStyle(
                                    color: AppColors.appTextDark,
                                    fontSize: Adaptor.px(28.0))),
                          ]),
                    ),
                    new FAProgressBar(
                        direction: Axis.horizontal,
                        currentValue: 80,
                        displayText: '%',
                        size: Adaptor.px(28.0))
                  ])),
              new Container(
                  margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  width: Adaptor.px(1020.0),
                  height: Adaptor.px(80.0),
                  decoration: new BoxDecoration(
                      color: AppColors.appWhite,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.appBlackShadow, blurRadius: 5.0)
                      ]),
                  child: new FlatButton(
                      onPressed: _toRecord,
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Icon(IconFont.iconEdit,
                              size: Adaptor.px(32.0),
                              color: AppColors.appTextNormal),
                          new Padding(
                            padding: EdgeInsets.only(left: Adaptor.px(10.0)),
                            child: new Text('记一笔',
                                style: TextStyle(
                                    color: AppColors.appTextDark,
                                    fontSize: Adaptor.px(28.0))),
                          )
                        ],
                      ))),
              new Container(
                  child: Expanded(
                      child: new ListView(children: <Widget>[
                new Container(
                    margin: EdgeInsets.only(
                        left: Adaptor.px(6.0),
                        right: Adaptor.px(6.0),
                        bottom: Adaptor.px(10.0),
                        top: Adaptor.onePx()),
                    padding: EdgeInsets.all(Adaptor.px(16.0)),
                    decoration: new BoxDecoration(
                        color: AppColors.appWhite,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.appBlackShadow, blurRadius: 5.0)
                        ]),
                    child: new Wrap(children: <Widget>[
                      new Container(
                          padding: EdgeInsets.only(
                              top: Adaptor.px(16.0), bottom: Adaptor.px(16.0)),
                          decoration: new BoxDecoration(
                              border: Border(
                            bottom: BorderSide(
                                width: Adaptor.onePx(),
                                color: AppColors.appBorder),
                          )),
                          child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Text('2019-11-12',
                                    style: TextStyle(
                                        fontSize: Adaptor.px(28.0),
                                        color: AppColors.appTextNormal)),
                                new Text('支出7.50',
                                    style: TextStyle(
                                        fontSize: Adaptor.px(28.0),
                                        color: AppColors.appTextNormal)),
                              ])),
                      new Wrap(children: <Widget>[
                        new Container(
                            padding: EdgeInsets.only(
                                top: Adaptor.px(20.0),
                                bottom: Adaptor.px(20.0)),
                            decoration: new BoxDecoration(
                                border: Border(
                              bottom: BorderSide(
                                  width: Adaptor.onePx(),
                                  color: AppColors.appBorder),
                            )),
                            child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  new Column(children: <Widget>[
                                    new Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                      new Image.asset(
                                        Assets.iconSave,
                                        width: Adaptor.px(90.0),
                                        height: Adaptor.px(90.0),
                                      ),
                                      new Padding(
                                          padding: EdgeInsets.only(
                                              left: Adaptor.px(20.0)),
                                          child: new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                new Text('交通',
                                                    style: TextStyle(
                                                        fontSize:
                                                            Adaptor.px(30.0),
                                                        color: AppColors
                                                            .appTextDark)),
                                                new Text('地铁',
                                                    style: TextStyle(
                                                        fontSize:
                                                            Adaptor.px(24.0),
                                                        color: AppColors
                                                            .appTextDark))
                                              ]))
                                    ])
                                  ]),
                                  new Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      new Text('3.00',
                                          style: TextStyle(
                                            fontSize: Adaptor.px(36.0),
                                            color: AppColors.appOutlay,
                                          )),
                                      SizedBox(
                                        width: Adaptor.px(8.0),
                                      ),
                                      new Icon(IconFont.iconMore,
                                          size: Adaptor.px(20.0),
                                          color: AppColors.appTextNormal),
                                    ],
                                  )
                                ])),
                        new Container(
                            padding: EdgeInsets.only(
                                top: Adaptor.px(20.0),
                                bottom: Adaptor.px(20.0)),
                            decoration: new BoxDecoration(
                                border: Border(
                              bottom: BorderSide(
                                  width: Adaptor.onePx(),
                                  color: AppColors.appBorder),
                            )),
                            child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  new Column(children: <Widget>[
                                    new Row(children: <Widget>[
                                      new Image.asset(
                                        Assets.iconSave,
                                        width: Adaptor.px(90.0),
                                        height: Adaptor.px(90.0),
                                      ),
                                      new Padding(
                                          padding: EdgeInsets.only(
                                              left: Adaptor.px(20.0)),
                                          child: new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                new Text('交通',
                                                    style: TextStyle(
                                                        fontSize:
                                                            Adaptor.px(30.0),
                                                        color: AppColors
                                                            .appTextDark)),
                                                new Text('地铁',
                                                    style: TextStyle(
                                                        fontSize:
                                                            Adaptor.px(24.0),
                                                        color: AppColors
                                                            .appTextDark))
                                              ]))
                                    ])
                                  ]),
                                  new Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      new Text('3.00',
                                          style: TextStyle(
                                            fontSize: Adaptor.px(36.0),
                                            color: AppColors.appOutlay,
                                          )),
                                      SizedBox(
                                        width: Adaptor.px(8.0),
                                      ),
                                      new Icon(IconFont.iconMore,
                                          size: Adaptor.px(20.0),
                                          color: AppColors.appTextNormal),
                                    ],
                                  )
                                ]))
                      ])
                    ])),
                new Container(
                    margin: EdgeInsets.only(
                        left: Adaptor.px(6.0),
                        right: Adaptor.px(6.0),
                        bottom: Adaptor.px(10.0),
                        top: Adaptor.onePx()),
                    padding: EdgeInsets.all(Adaptor.px(16.0)),
                    decoration: new BoxDecoration(
                        color: AppColors.appWhite,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.appBlackShadow, blurRadius: 5.0)
                        ]),
                    child: new Wrap(children: <Widget>[
                      new Container(
                          padding: EdgeInsets.only(
                              top: Adaptor.px(16.0), bottom: Adaptor.px(16.0)),
                          decoration: new BoxDecoration(
                              border: Border(
                            bottom: BorderSide(
                                width: Adaptor.onePx(),
                                color: AppColors.appBorder),
                          )),
                          child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Text('2019-11-12',
                                    style: TextStyle(
                                        fontSize: Adaptor.px(28.0),
                                        color: AppColors.appTextNormal)),
                                new Text('支出7.50',
                                    style: TextStyle(
                                        fontSize: Adaptor.px(28.0),
                                        color: AppColors.appTextNormal)),
                              ])),
                      new Wrap(children: <Widget>[
                        new Container(
                            padding: EdgeInsets.only(
                                top: Adaptor.px(20.0),
                                bottom: Adaptor.px(20.0)),
                            decoration: new BoxDecoration(
                                border: Border(
                              bottom: BorderSide(
                                  width: Adaptor.onePx(),
                                  color: AppColors.appBorder),
                            )),
                            child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  new Column(children: <Widget>[
                                    new Row(children: <Widget>[
                                      new Image.asset(
                                        Assets.iconSave,
                                        width: Adaptor.px(90.0),
                                        height: Adaptor.px(90.0),
                                      ),
                                      new Padding(
                                          padding: EdgeInsets.only(
                                              left: Adaptor.px(20.0)),
                                          child: new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                new Text('交通',
                                                    style: TextStyle(
                                                        fontSize:
                                                            Adaptor.px(30.0),
                                                        color: AppColors
                                                            .appTextDark)),
                                                new Text('地铁',
                                                    style: TextStyle(
                                                        fontSize:
                                                            Adaptor.px(24.0),
                                                        color: AppColors
                                                            .appTextDark))
                                              ]))
                                    ])
                                  ]),
                                  new Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      new Text('3.00',
                                          style: TextStyle(
                                            fontSize: Adaptor.px(36.0),
                                            color: AppColors.appOutlay,
                                          )),
                                      SizedBox(
                                        width: Adaptor.px(8.0),
                                      ),
                                      new Icon(IconFont.iconMore,
                                          size: Adaptor.px(20.0),
                                          color: AppColors.appTextNormal),
                                    ],
                                  )
                                ])),
                        new Container(
                            padding: EdgeInsets.only(
                                top: Adaptor.px(20.0),
                                bottom: Adaptor.px(20.0)),
                            decoration: new BoxDecoration(
                                border: Border(
                              bottom: BorderSide(
                                  width: Adaptor.onePx(),
                                  color: AppColors.appBorder),
                            )),
                            child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  new Column(children: <Widget>[
                                    new Row(children: <Widget>[
                                      new Image.asset(
                                        Assets.iconSave,
                                        width: Adaptor.px(90.0),
                                        height: Adaptor.px(90.0),
                                      ),
                                      new Padding(
                                          padding: EdgeInsets.only(
                                              left: Adaptor.px(20.0)),
                                          child: new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                new Text('交通',
                                                    style: TextStyle(
                                                        fontSize:
                                                            Adaptor.px(30.0),
                                                        color: AppColors
                                                            .appTextDark)),
                                                new Text('地铁',
                                                    style: TextStyle(
                                                        fontSize:
                                                            Adaptor.px(24.0),
                                                        color: AppColors
                                                            .appTextDark))
                                              ]))
                                    ])
                                  ]),
                                  new Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      new Text('3.00',
                                          style: TextStyle(
                                            fontSize: Adaptor.px(36.0),
                                            color: AppColors.appOutlay,
                                          )),
                                      SizedBox(
                                        width: Adaptor.px(8.0),
                                      ),
                                      new Icon(IconFont.iconMore,
                                          size: Adaptor.px(20.0),
                                          color: AppColors.appTextNormal),
                                    ],
                                  )
                                ]))
                      ])
                    ])),
                new Container(
                    margin: EdgeInsets.only(
                        left: Adaptor.px(6.0),
                        right: Adaptor.px(6.0),
                        bottom: Adaptor.px(10.0),
                        top: Adaptor.onePx()),
                    padding: EdgeInsets.all(Adaptor.px(16.0)),
                    decoration: new BoxDecoration(
                        color: AppColors.appWhite,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.appBlackShadow, blurRadius: 5.0)
                        ]),
                    child: new Wrap(children: <Widget>[
                      new Container(
                          padding: EdgeInsets.only(
                              top: Adaptor.px(16.0), bottom: Adaptor.px(16.0)),
                          decoration: new BoxDecoration(
                              border: Border(
                            bottom: BorderSide(
                                width: Adaptor.onePx(),
                                color: AppColors.appBorder),
                          )),
                          child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Text('2019-11-12',
                                    style: TextStyle(
                                        fontSize: Adaptor.px(28.0),
                                        color: AppColors.appTextNormal)),
                                new Text('支出7.50',
                                    style: TextStyle(
                                        fontSize: Adaptor.px(28.0),
                                        color: AppColors.appTextNormal)),
                              ])),
                      new Wrap(children: <Widget>[
                        new Container(
                            padding: EdgeInsets.only(
                                top: Adaptor.px(20.0),
                                bottom: Adaptor.px(20.0)),
                            decoration: new BoxDecoration(
                                border: Border(
                              bottom: BorderSide(
                                  width: Adaptor.onePx(),
                                  color: AppColors.appBorder),
                            )),
                            child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  new Column(children: <Widget>[
                                    new Row(children: <Widget>[
                                      new Image.asset(
                                        Assets.iconSave,
                                        width: Adaptor.px(90.0),
                                        height: Adaptor.px(90.0),
                                      ),
                                      new Padding(
                                          padding: EdgeInsets.only(
                                              left: Adaptor.px(20.0)),
                                          child: new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                new Text('交通',
                                                    style: TextStyle(
                                                        fontSize:
                                                            Adaptor.px(30.0),
                                                        color: AppColors
                                                            .appTextDark)),
                                                new Text('地铁',
                                                    style: TextStyle(
                                                        fontSize:
                                                            Adaptor.px(24.0),
                                                        color: AppColors
                                                            .appTextDark))
                                              ]))
                                    ])
                                  ]),
                                  new Text('3.00',
                                      style: TextStyle(
                                        fontSize: Adaptor.px(36.0),
                                        color: AppColors.appOutlay,
                                      ))
                                ])),
                        new Container(
                            padding: EdgeInsets.only(
                                top: Adaptor.px(20.0),
                                bottom: Adaptor.px(20.0)),
                            decoration: new BoxDecoration(
                                border: Border(
                              bottom: BorderSide(
                                  width: Adaptor.onePx(),
                                  color: AppColors.appBorder),
                            )),
                            child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  new Column(children: <Widget>[
                                    new Row(children: <Widget>[
                                      new Image.asset(
                                        Assets.iconSave,
                                        width: Adaptor.px(90.0),
                                        height: Adaptor.px(90.0),
                                      ),
                                      new Padding(
                                          padding: EdgeInsets.only(
                                              left: Adaptor.px(20.0)),
                                          child: new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                new Text('交通',
                                                    style: TextStyle(
                                                        fontSize:
                                                            Adaptor.px(30.0),
                                                        color: AppColors
                                                            .appTextDark)),
                                                new Text('地铁',
                                                    style: TextStyle(
                                                        fontSize:
                                                            Adaptor.px(24.0),
                                                        color: AppColors
                                                            .appTextDark))
                                              ]))
                                    ])
                                  ]),
                                  new Text('3.00',
                                      style: TextStyle(
                                          fontSize: Adaptor.px(36.0),
                                          color: AppColors.appIncome))
                                ]))
                      ])
                    ]))
              ])))
            ])));
  }
}
