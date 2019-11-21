import 'package:flutter/cupertino.dart';
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
  String _currentYear = (DayDart().year()).toString();
  int _selectedIndex = -1;

  List<String> _years = [
    '2001',
    '2002',
    '2003',
    '2004',
    '2005',
    '2006',
    '2007',
    '2008'
  ];

  @override
  void initState() {
    super.initState();
  }

  void _yearSelectOk() {
    setState(() {
      if (_selectedIndex != -1) {
        _currentYear = _years[_selectedIndex];
      }
    });
    Navigator.of(context).pop();
  }

  void _showYearSelect(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
            titlePadding: EdgeInsets.only(
                top: Adaptor.px(20.0),
                bottom: 0,
                left: Adaptor.px(20.0),
                right: Adaptor.px(20.0)),
            contentPadding: EdgeInsets.only(
                top: 0,
                bottom: 0,
                left: Adaptor.px(20.0),
                right: Adaptor.px(20.0)),
            title: new Text('选择查询年度',
                style: TextStyle(
                    fontSize: Adaptor.px(32.0),
                    fontWeight: FontWeight.w400,
                    color: AppColors.appTextDark)),
            content:
                new StatefulBuilder(builder: (context, StateSetter setState) {
              return new Container(
                  height: Adaptor.px(350.0),
                  child: new Center(
                      child: new Container(
                          width: Adaptor.px(200.0),
                          height: Adaptor.px(300.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Container(
                                  width: Adaptor.px(180.0),
                                  child: new CupertinoPicker(
                                    itemExtent: Adaptor.px(64.0),
                                    backgroundColor: Colors.white,
                                    onSelectedItemChanged: (int i) {
                                      setState(() {
                                        _selectedIndex = i;
                                      });
                                    },
                                    children: List.generate(_years.length,
                                        (int index) {
                                      return new Center(
                                          child: new Text(_years[index],
                                              style: TextStyle(
                                                  color: AppColors.appTextDark,
                                                  fontSize: Adaptor.px(32.0),
                                                  fontWeight:
                                                      FontWeight.normal)));
                                    }).toList(),
                                  )),
                            ],
                          ))));
            }),
            actions: <Widget>[
              new FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _yearSelectOk,
                child: new Text('确定',
                    style: TextStyle(
                        fontSize: Adaptor.px(28.0),
                        color: AppColors.appYellow,
                        fontWeight: FontWeight.normal)),
              ),
              new FlatButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: new Text('取消',
                      style: TextStyle(
                          fontSize: Adaptor.px(28.0),
                          color: AppColors.appTextDark,
                          fontWeight: FontWeight.normal))),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('资产',
                style: TextStyle(
                    fontSize: Adaptor.px(32.0), color: AppColors.appTextDark))),
        body: new Container(
            child: new SingleChildScrollView(
                child: new Container(
          margin: EdgeInsets.only(
              top: Adaptor.px(10.0),
              left: Adaptor.px(10.0),
              right: Adaptor.px(10.0)),
          child: new Wrap(
            children: <Widget>[
              new Container(
                  margin: EdgeInsets.only(
                      top: Adaptor.px(10.0),
                      left: Adaptor.px(10.0),
                      right: Adaptor.px(10.0)),
                  width: Adaptor.px(1040.0),
                  height: Adaptor.px(350.0),
                  decoration: new BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.appYellowShadow, blurRadius: 8.0)
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
                            child: new FlatButton(
                                padding: EdgeInsets.all(Adaptor.px(10.0)),
                                onPressed: () => _showYearSelect(context),
                                child: new Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    new Text('$_currentYear年',
                                        style: TextStyle(
                                            color: AppColors.appTextDark,
                                            fontSize: Adaptor.px(32.0),
                                            fontWeight: FontWeight.normal)),
                                    new Padding(
                                      padding: EdgeInsets.only(
                                          left: Adaptor.px(4.0)),
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
                                                color:
                                                    AppColors.appBorderDark))),
                                    child: new Column(
                                      children: <Widget>[
                                        new Text('全年支出',
                                            style: TextStyle(
                                                fontSize: Adaptor.px(28.0),
                                                color: AppColors.appTextDark)),
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
                  margin: EdgeInsets.only(
                      top: Adaptor.px(20.0),
                      bottom: Adaptor.px(20.0),
                      left: Adaptor.px(10.0),
                      right: Adaptor.px(10.0)),
                  width: Adaptor.px(1040.0),
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
                        height: Adaptor.px(80.0),
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
            ],
          ),
        ))));
  }
}
