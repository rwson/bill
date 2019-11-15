import 'package:flutter/material.dart';
import 'package:flutter_daydart/flutter_daydart.dart';

import '../adaptor.dart';
import '../colors.dart';
import '../iconfont.dart';

class WealthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WealthState();
}

class WealthState extends State<WealthPage> {
  int currentYear = DayDart().year();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('资产',
                style: TextStyle(
                    fontSize: Adaptor.px(32.0), color: AppColors.appTextDark))),
        body: new Container(
            padding: EdgeInsets.all(Adaptor.px(16.0)),
            child: new SingleChildScrollView(
                child: new Column(children: <Widget>[
              new Wrap(children: <Widget>[
                new Container(
                    width: Adaptor.px(1040.0),
                    height: Adaptor.px(350.0),
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
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Container(
                            padding: EdgeInsets.only(top: Adaptor.px(10.0)),
                              child: new FlatButton(
                                  onPressed: () => {},
                                  child: new Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      new Text('$currentYear年',
                                          style: TextStyle(
                                              color: AppColors.appTextDark,
                                              fontSize: Adaptor.px(32.0),
                                              fontWeight: FontWeight.normal)),
                                      new Padding(
                                        padding: EdgeInsets.only(left: Adaptor.px(4.0)),
                                        child: new Icon(IconFont.iconDown,
                                            size: Adaptor.px(40.0),
                                            color: AppColors.appTextDark),
                                      )
                                    ],
                                  ))),
                          new Container(
                            margin: EdgeInsets.only(bottom: Adaptor.px(40.0)),
                            child: new Column(children: <Widget>[
                              new Text('全年结余',
                                  style: TextStyle(
                                      fontSize: Adaptor.px(32.0),
                                      color: AppColors.appTextDark)),
                              new Text('0',
                                  style: TextStyle(
                                      fontSize: Adaptor.px(48.0),
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.appTextDark))
                            ]),
                          ),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Expanded(
                                  flex: 1,
                                  child: new Container(
                                      width: Adaptor.px(Adaptor.screenW()),
                                      decoration: new BoxDecoration(
                                          border: Border(
                                              right: BorderSide(
                                                  width: Adaptor.onePx(),
                                                  color: AppColors
                                                      .appBorderDark))),
                                      child: new Column(
                                        children: <Widget>[
                                          new Text('全年支出',
                                              style: TextStyle(
                                                  fontSize: Adaptor.px(28.0),
                                                  color:
                                                      AppColors.appTextDark)),
                                          new Text('0.00',
                                              style: TextStyle(
                                                  fontSize: Adaptor.px(32.0),
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.appTextDark))
                                        ],
                                      ))),
                              new Expanded(
                                  flex: 1,
                                  child: new Container(
                                      child: new Column(
                                    children: <Widget>[
                                      new Text('全年收入',
                                          style: TextStyle(
                                              fontSize: Adaptor.px(28.0),
                                              color: AppColors.appTextDark)),
                                      new Text('0.00',
                                          style: TextStyle(
                                              fontSize: Adaptor.px(32.0),
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.appTextDark))
                                    ],
                                  )))
                            ],
                          )
                        ],
                      ),
                    )),
                new Container(
                    width: Adaptor.px(1060.0),
                    margin: EdgeInsets.only(top: Adaptor.px(20.0)),
                    padding: EdgeInsets.all(Adaptor.px(20.0)),
                    decoration: new BoxDecoration(
                        color: AppColors.appWhite,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.appBlackShadow, blurRadius: 5.0)
                        ]),
                    child: new Column(children: <Widget>[
                      new Container(
                          width: Adaptor.px(1040.0),
                          height: Adaptor.px(90.0),
                          padding: EdgeInsets.only(
                              bottom: Adaptor.px(20.0), top: Adaptor.px(10.0)),
                          decoration: new BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: Adaptor.onePx(),
                                      color: AppColors.appBorder))),
                          child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                new Container(
                                  child: new Text('月份',
                                      style: TextStyle(
                                          fontSize: Adaptor.px(30.0),
                                          color: AppColors.appTextDark)),
                                ),
                                new Container(
                                  child: new Text('收入',
                                      style: TextStyle(
                                          fontSize: Adaptor.px(30.0),
                                          color: AppColors.appTextDark)),
                                ),
                                new Container(
                                  child: new Text('支出',
                                      style: TextStyle(
                                          fontSize: Adaptor.px(30.0),
                                          color: AppColors.appTextDark)),
                                ),
                                new Container(
                                  child: new Text('结余',
                                      style: TextStyle(
                                          fontSize: Adaptor.px(30.0),
                                          color: AppColors.appTextDark)),
                                )
                              ])),
                      new Container(
                          width: Adaptor.px(1040.0),
                          height: Adaptor.px(100.0),
                          padding: EdgeInsets.only(
                              bottom: Adaptor.px(20.0), top: Adaptor.px(20.0)),
                          decoration: new BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: Adaptor.onePx(),
                                      color: AppColors.appBorder))),
                          child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                new Container(
                                  child: new Text('2019-11',
                                      style: TextStyle(
                                          fontSize: Adaptor.px(28.0),
                                          color: AppColors.appTextDark)),
                                ),
                                new Container(
                                  child: new Text(
                                    '1000000',
                                    style: TextStyle(
                                        fontSize: Adaptor.px(28.0),
                                        color: AppColors.appIncome),
                                  ),
                                ),
                                new Container(
                                    child: new Text('1000000',
                                        style: TextStyle(
                                            fontSize: Adaptor.px(28.0),
                                            color: AppColors.appOutlay))),
                                new Container(
                                  child: new Text('800000',
                                      style: TextStyle(
                                          fontSize: Adaptor.px(28.0),
                                          color: AppColors.appTextDark)),
                                ),
                              ]))
                    ]))
              ])
            ]))));
  }
}
