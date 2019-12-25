import 'package:bill/adaptor.dart';
import 'package:bill/assets.dart';
import 'package:bill/colors.dart';
import 'package:bill/iconfont.dart';
import 'package:bill/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GroupsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GroupsState();
}

class GroupsState extends State<GroupsPage> {
  @override
  void initState() {
    super.initState();
  }

  void _createCircle() {
    AppRouter.toPage(context, 'create-circle');
  }

  void _share() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('记账圈子',
                style: TextStyle(
                    fontSize: Adaptor.px(32.0), color: AppColors.appTextDark))),
        body: new Container(
            height: double.infinity,
            child: new Stack(children: <Widget>[
              new Container(
                  child: new SingleChildScrollView(
                      child: new Container(
                          margin: EdgeInsets.only(
                              top: Adaptor.px(10.0),
                              left: Adaptor.px(10.0),
                              right: Adaptor.px(10.0)),
                          child: new Wrap(
                            children: <Widget>[
                              new Container(
                                  width: Adaptor.px(1040.0),
                                  margin: EdgeInsets.only(
                                      top: Adaptor.px(10.0),
                                      left: Adaptor.px(10.0),
                                      right: Adaptor.px(10.0),
                                      bottom: Adaptor.px(10.0)),
                                  padding: EdgeInsets.all(Adaptor.px(16.0)),
                                  decoration: new BoxDecoration(
                                      color: AppColors.appWhite,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5.0)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: AppColors.appBlackShadow,
                                            blurRadius: 5.0,
                                            offset: Offset(0, 1.0))
                                      ]),
                                  child: new Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      new Row(
                                        children: <Widget>[
                                          new Container(
                                              width: Adaptor.px(100.0),
                                              height: Adaptor.px(100.0),
                                              margin: EdgeInsets.only(
                                                  right: Adaptor.px(18.0)),
                                              decoration: new BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .all(Radius.circular(
                                                          Adaptor.px(80.0))),
                                                  border: Border.all(
                                                      width: Adaptor.px(4.0),
                                                      color:
                                                          AppColors.appBorder)),
                                              child: new ClipOval(
                                                  child: new Image.asset(
                                                Assets.testImage,
                                                width: Adaptor.px(100.0),
                                                height: Adaptor.px(100.0),
                                              ))),
                                          new Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              new Text('个人账单',
                                                  style: TextStyle(
                                                      fontSize:
                                                          Adaptor.px(32.0),
                                                      color: AppColors
                                                          .appTextDark)),
                                              new Padding(
                                                padding: EdgeInsets.only(
                                                    top: Adaptor.px(0)),
                                                child: new Text(
                                                    '创建于 2019-11-21',
                                                    style: TextStyle(
                                                        fontSize:
                                                            Adaptor.px(28.0),
                                                        color: AppColors
                                                            .appTextNormal)),
                                              )
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  )),
                              new Container(
                                  width: Adaptor.px(1040.0),
                                  margin: EdgeInsets.only(
                                      top: Adaptor.px(10.0),
                                      left: Adaptor.px(10.0),
                                      right: Adaptor.px(10.0),
                                      bottom: Adaptor.px(10.0)),
                                  padding: EdgeInsets.all(Adaptor.px(16.0)),
                                  decoration: new BoxDecoration(
                                      color: AppColors.appWhite,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5.0)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: AppColors.appBlackShadow,
                                            blurRadius: 5.0,
                                            offset: Offset(0, 1.0))
                                      ]),
                                  child: new Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      new Row(
                                        children: <Widget>[
                                          new Container(
                                              width: Adaptor.px(130.0),
                                              height: Adaptor.px(130.0),
                                              margin: EdgeInsets.only(
                                                  right: Adaptor.px(18.0)),
                                              decoration: new BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .all(Radius.circular(
                                                          Adaptor.px(80.0))),
                                                  border: Border.all(
                                                      width: Adaptor.px(4.0),
                                                      color:
                                                          AppColors.appBorder),
                                                  color: AppColors.appBorder),
                                              child: new ClipOval(
                                                  child: new Image.asset(
                                                Assets.testImage,
                                                width: Adaptor.px(130.0),
                                                height: Adaptor.px(130.0),
                                              ))),
                                          new Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              new Text('合租',
                                                  style: TextStyle(
                                                      fontSize:
                                                          Adaptor.px(32.0),
                                                      color: AppColors
                                                          .appTextDark)),
                                              new Padding(
                                                padding: EdgeInsets.only(
                                                    top: Adaptor.px(0)),
                                                child: new Text(
                                                    '创建于 2019-11-21',
                                                    style: TextStyle(
                                                        fontSize:
                                                            Adaptor.px(28.0),
                                                        color: AppColors
                                                            .appTextNormal)),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      new Container(
                                          width: Adaptor.px(40.0),
                                          height: Adaptor.px(40.0),
                                          child: new FlatButton(
                                              padding: EdgeInsets.all(0),
                                              onPressed: _share,
                                              child: new Icon(
                                                IconFont.iconShare,
                                                size: Adaptor.px(40.0),
                                                color: AppColors.appYellow,
                                              )))
                                    ],
                                  )),
                              new Container(
                                  width: Adaptor.px(1040.0),
                                  margin: EdgeInsets.only(
                                      top: Adaptor.px(10.0),
                                      left: Adaptor.px(10.0),
                                      right: Adaptor.px(10.0),
                                      bottom: Adaptor.px(10.0)),
                                  padding: EdgeInsets.all(Adaptor.px(16.0)),
                                  decoration: new BoxDecoration(
                                      color: AppColors.appWhite,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5.0)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: AppColors.appBlackShadow,
                                            blurRadius: 5.0,
                                            offset: Offset(0, 1.0))
                                      ]),
                                  child: new Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      new Row(
                                        children: <Widget>[
                                          new Container(
                                              width: Adaptor.px(130.0),
                                              height: Adaptor.px(130.0),
                                              margin: EdgeInsets.only(
                                                  right: Adaptor.px(18.0)),
                                              decoration: new BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .all(Radius.circular(
                                                          Adaptor.px(80.0))),
                                                  border: Border.all(
                                                      width: Adaptor.px(4.0),
                                                      color:
                                                          AppColors.appBorder)),
                                              child: new ClipOval(
                                                  child: new Stack(
                                                children: <Widget>[
                                                  new Positioned(
                                                      left: 0,
                                                      top: 0,
                                                      child: new Image.asset(
                                                        Assets.testImage,
                                                        width: Adaptor.px(60.0),
                                                        height:
                                                            Adaptor.px(60.0),
                                                      )),
                                                  new Positioned(
                                                      right: 0,
                                                      top: 0,
                                                      child: new Image.asset(
                                                        Assets.test2Image,
                                                        width: Adaptor.px(60.0),
                                                        height:
                                                            Adaptor.px(60.0),
                                                      )),
                                                  new Positioned(
                                                      left: 0,
                                                      bottom: 0,
                                                      child: new Image.asset(
                                                        Assets.test3Image,
                                                        width: Adaptor.px(60.0),
                                                        height:
                                                            Adaptor.px(60.0),
                                                      )),
                                                  new Positioned(
                                                      right: 0,
                                                      bottom: 0,
                                                      child: new Image.asset(
                                                        Assets.testImage,
                                                        width: Adaptor.px(60.0),
                                                        height:
                                                            Adaptor.px(60.0),
                                                      ))
                                                ],
                                              ))),
                                          new Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              new Text('宿舍',
                                                  style: TextStyle(
                                                      fontSize:
                                                          Adaptor.px(32.0),
                                                      color: AppColors
                                                          .appTextDark)),
                                              new Padding(
                                                padding: EdgeInsets.only(
                                                    top: Adaptor.px(0)),
                                                child: new Text(
                                                    '创建于 2019-11-21',
                                                    style: TextStyle(
                                                        fontSize:
                                                            Adaptor.px(28.0),
                                                        color: AppColors
                                                            .appTextNormal)),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      new Container(
                                          width: Adaptor.px(40.0),
                                          height: Adaptor.px(40.0),
                                          child: new FlatButton(
                                              padding: EdgeInsets.all(0),
                                              onPressed: _share,
                                              child: new Icon(
                                                IconFont.iconShare,
                                                size: Adaptor.px(40.0),
                                                color: AppColors.appYellow,
                                              )))
                                    ],
                                  ))
                            ],
                          )))),
              new Positioned(
                  left: 0,
                  bottom: 0,
                  right: 0,
                  child: new Container(
                      height: Adaptor.px(80.0),
                      color: AppColors.appYellow,
                      child: new Center(
                          child: new FlatButton(
                              onPressed: _createCircle,
                              child: new Text('新建圈子',
                                  style: new TextStyle(
                                      fontSize: Adaptor.px(28.0),
                                      color: AppColors.appWhite))))))
            ])));
  }
}
