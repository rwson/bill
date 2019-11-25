import 'package:bill/adaptor.dart';
import 'package:bill/colors.dart';
import 'package:bill/methods-icons.dart';
import 'package:bill/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TaskDetailState();
}

class TaskDetailState extends State<TaskDetailPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('任务详情',
                style: TextStyle(
                    fontSize: Adaptor.px(32.0), color: AppColors.appTextDark))),
        body: new Container(
            margin: EdgeInsets.all(Adaptor.px(10.0)),
            padding: EdgeInsets.only(
                left: Adaptor.px(10.0), right: Adaptor.px(10.0)),
            decoration: new BoxDecoration(color: AppColors.appWhite),
            width: Adaptor.px(1060.0),
            child: new Wrap(
              children: <Widget>[
                new Container(
                  width: Adaptor.px(1060.0),
                  height: Adaptor.px(90.0),
                  padding: EdgeInsets.only(
                      left: Adaptor.px(16.0), right: Adaptor.px(16.0)),
                  margin: EdgeInsets.only(
                      left: Adaptor.px(10.0), right: Adaptor.px(10.0)),
                  decoration: new BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: Adaptor.onePx(),
                              color: AppColors.appBorder))),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text('记账频率',
                          style: TextStyle(
                              color: AppColors.appTextDark,
                              fontSize: Adaptor.px(26.0))),
                      new Expanded(
                          flex: 1,
                          child: new Align(
                              alignment: Alignment.centerRight,
                              child: new Text('周一 周二 周三',
                                  style: TextStyle(
                                      color: AppColors.appTextNormal,
                                      fontSize: Adaptor.px(26.0),
                                      fontWeight: FontWeight.normal)))
                      )
                    ],
                  ),
                ),
                new Container(
                  width: Adaptor.px(1060.0),
                  height: Adaptor.px(90.0),
                  padding: EdgeInsets.only(
                      left: Adaptor.px(16.0), right: Adaptor.px(16.0)),
                  margin: EdgeInsets.only(
                      left: Adaptor.px(10.0), right: Adaptor.px(10.0)),
                  decoration: new BoxDecoration(
                      color: AppColors.appWhite,
                      border: Border(
                          bottom: BorderSide(
                              width: Adaptor.onePx(),
                              color: AppColors.appBorder))),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text('记账时间',
                          style: TextStyle(
                              color: AppColors.appTextDark,
                              fontSize: Adaptor.px(26.0))),
                      new Expanded(
                          flex: 1,
                          child: new Align(
                              alignment: Alignment.centerRight,
                              child: new Text('09:00',
                                  style: TextStyle(
                                      color: AppColors.appTextNormal,
                                      fontSize: Adaptor.px(26.0),
                                      fontWeight: FontWeight.normal)))
                      )
                    ],
                  ),
                ),
                new Container(
                  width: Adaptor.px(1060.0),
                  height: Adaptor.px(90.0),
                  padding: EdgeInsets.only(
                      left: Adaptor.px(16.0), right: Adaptor.px(16.0)),
                  margin: EdgeInsets.only(
                      left: Adaptor.px(10.0), right: Adaptor.px(10.0)),
                  decoration: new BoxDecoration(
                      color: AppColors.appWhite,
                      border: Border(
                          bottom: BorderSide(
                              width: Adaptor.onePx(),
                              color: AppColors.appBorder))),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text('记账金额',
                          style: TextStyle(
                              color: AppColors.appTextDark,
                              fontSize: Adaptor.px(26.0))),
                      new Expanded(
                          flex: 1,
                          child: new Align(
                              alignment: Alignment.centerRight,
                              child: new Text('￥3.00',
                                  style: TextStyle(
                                      color: AppColors.appTextNormal,
                                      fontSize: Adaptor.px(26.0),
                                      fontWeight: FontWeight.normal)))
                      )
                    ],
                  ),
                ),
                new Container(
                  width: Adaptor.px(1060.0),
                  height: Adaptor.px(90.0),
                  padding: EdgeInsets.only(
                      left: Adaptor.px(16.0), right: Adaptor.px(16.0)),
                  margin: EdgeInsets.only(
                      left: Adaptor.px(10.0), right: Adaptor.px(10.0)),
                  decoration: new BoxDecoration(
                      color: AppColors.appWhite,
                      border: Border(
                          bottom: BorderSide(
                              width: Adaptor.onePx(),
                              color: AppColors.appBorder))),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text('账单分类',
                          style: TextStyle(
                              color: AppColors.appTextDark,
                              fontSize: Adaptor.px(26.0))),
                      new Expanded(
                          flex: 1,
                          child: new Align(
                              alignment: Alignment.centerRight,
                              child: new Text('交通',
                                  style: TextStyle(
                                      color: AppColors.appTextNormal,
                                      fontSize: Adaptor.px(26.0),
                                      fontWeight: FontWeight.normal)))
                      )
                    ],
                  ),
                ),
                new Container(
                  width: Adaptor.px(1060.0),
                  height: Adaptor.px(90.0),
                  padding: EdgeInsets.only(
                      left: Adaptor.px(16.0), right: Adaptor.px(16.0)),
                  margin: EdgeInsets.only(
                      left: Adaptor.px(10.0), right: Adaptor.px(10.0)),
                  decoration: new BoxDecoration(
                      color: AppColors.appWhite,
                      border: Border(
                          bottom: BorderSide(
                              width: Adaptor.onePx(),
                              color: AppColors.appBorder))),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text('账单备注',
                          style: TextStyle(
                              color: AppColors.appTextDark,
                              fontSize: Adaptor.px(26.0))),
                      new Expanded(
                          flex: 1,
                          child: new Align(
                              alignment: Alignment.centerRight,
                              child: new Text('地铁费',
                                  style: TextStyle(
                                      color: AppColors.appTextNormal,
                                      fontSize: Adaptor.px(26.0),
                                      fontWeight: FontWeight.normal)))
                      )
                    ],
                  ),
                ),
                new Container(
                  width: Adaptor.px(1060.0),
                  height: Adaptor.px(90.0),
                  padding: EdgeInsets.only(
                      left: Adaptor.px(16.0), right: Adaptor.px(16.0)),
                  margin: EdgeInsets.only(
                      left: Adaptor.px(10.0), right: Adaptor.px(10.0)),
                  decoration: new BoxDecoration(
                      color: AppColors.appWhite,
                      border: Border(
                          bottom: BorderSide(
                              width: Adaptor.onePx(),
                              color: AppColors.appBorder))),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text('是否确认',
                          style: TextStyle(
                              color: AppColors.appTextDark,
                              fontSize: Adaptor.px(26.0))),
                      new Expanded(
                          flex: 1,
                          child: new Align(
                              alignment: Alignment.centerRight,
                              child: new Text('是',
                                  style: TextStyle(
                                      color: AppColors.appTextNormal,
                                      fontSize: Adaptor.px(26.0),
                                      fontWeight: FontWeight.normal)))
                      )
                    ],
                  ),
                ),
                new Container(
                    width: Adaptor.px(1000.0),
                    height: Adaptor.px(90.0),
                    margin: EdgeInsets.only(
                        top: Adaptor.px(30.0),
                        left: Adaptor.px(10.0),
                        right: Adaptor.px(10.0)),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Container(
                          decoration: new BoxDecoration(
                              color: AppColors.appYellow,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Adaptor.px(10.0)))),
                          width: Adaptor.px(320.0),
                          height: Adaptor.px(60.0),
                          child: new GestureDetector(
                              onTap: () {},
                              child: new Center(
                                child: new Text('编辑',
                                    style: TextStyle(
                                        fontSize: Adaptor.px(26.0),
                                        fontWeight: FontWeight.normal,
                                        color: AppColors.appTextDark))
                              )
                          ),
                        ),
                        new Container(
                          width: Adaptor.px(320.0),
                          height: Adaptor.px(60.0),
                          decoration: new BoxDecoration(
                              color: AppColors.appOutlay,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Adaptor.px(10.0)))),
                          child: new GestureDetector(
                              onTap: () {},
                              child: new Center(
                                  child: new Text('删除',
                                      style: TextStyle(
                                          fontSize: Adaptor.px(26.0),
                                          fontWeight: FontWeight.normal,
                                          color: AppColors.appWhite))
                              )
                          )
                        ),
                      ],
                    )
                )
              ],
            )));
  }
}
