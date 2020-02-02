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

  void _createGroup() {
    AppRouter.toPage(context, 'create-group');
  }

  void _editGroup(int id) {
    AppRouter.toPage(context, 'create-group?id=${id.toString()}');
  }

  void _share() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('记账圈子',
                style: TextStyle(
                    fontSize: Adaptor.px(32.0), color: AppColors.appTextDark))),
        body: Container(
            height: double.infinity,
            child: Stack(children: <Widget>[
              Container(
                  child: SingleChildScrollView(
                      child: Container(
                          margin: EdgeInsets.only(
                              top: Adaptor.px(10.0),
                              left: Adaptor.px(10.0),
                              right: Adaptor.px(10.0)),
                          child: Wrap(
                            children: <Widget>[
                              Container(
                                  width: Adaptor.px(1040.0),
                                  margin: EdgeInsets.only(
                                      top: Adaptor.px(10.0),
                                      left: Adaptor.px(10.0),
                                      right: Adaptor.px(10.0),
                                      bottom: Adaptor.px(10.0)),
                                  padding: EdgeInsets.all(Adaptor.px(16.0)),
                                  decoration: BoxDecoration(
                                      color: AppColors.appWhite,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5.0)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: AppColors.appBlackShadow,
                                            blurRadius: 5.0,
                                            offset: Offset(0, 1.0))
                                      ]),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Container(
                                              width: Adaptor.px(100.0),
                                              height: Adaptor.px(100.0),
                                              margin: EdgeInsets.only(
                                                  right: Adaptor.px(18.0)),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .all(Radius.circular(
                                                          Adaptor.px(80.0))),
                                                  border: Border.all(
                                                      width: Adaptor.px(4.0),
                                                      color:
                                                          AppColors.appBorder)),
                                              child: ClipOval(
                                                  child: Image.asset(
                                                Assets.testImage,
                                                width: Adaptor.px(100.0),
                                                height: Adaptor.px(100.0),
                                              ))),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text('个人账单',
                                                  style: TextStyle(
                                                      fontSize:
                                                          Adaptor.px(32.0),
                                                      color: AppColors
                                                          .appTextDark)),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: Adaptor.px(0)),
                                                child: Text('创建于 2019-11-21',
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
                              Container(
                                  width: Adaptor.px(1040.0),
                                  margin: EdgeInsets.only(
                                      top: Adaptor.px(10.0),
                                      left: Adaptor.px(10.0),
                                      right: Adaptor.px(10.0),
                                      bottom: Adaptor.px(10.0)),
                                  padding: EdgeInsets.all(Adaptor.px(16.0)),
                                  decoration: BoxDecoration(
                                      color: AppColors.appWhite,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5.0)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: AppColors.appBlackShadow,
                                            blurRadius: 5.0,
                                            offset: Offset(0, 1.0))
                                      ]),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Container(
                                              width: Adaptor.px(130.0),
                                              height: Adaptor.px(130.0),
                                              margin: EdgeInsets.only(
                                                  right: Adaptor.px(18.0)),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .all(Radius.circular(
                                                          Adaptor.px(80.0))),
                                                  border: Border.all(
                                                      width: Adaptor.px(4.0),
                                                      color:
                                                          AppColors.appBorder),
                                                  color: AppColors.appBorder),
                                              child: ClipOval(
                                                  child: Image.asset(
                                                Assets.testImage,
                                                width: Adaptor.px(130.0),
                                                height: Adaptor.px(130.0),
                                              ))),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text('合租',
                                                  style: TextStyle(
                                                      fontSize:
                                                          Adaptor.px(32.0),
                                                      color: AppColors
                                                          .appTextDark)),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: Adaptor.px(0)),
                                                child: Text('创建于 2019-11-21',
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
                                      Container(
                                          width: Adaptor.px(40.0),
                                          height: Adaptor.px(40.0),
                                          child: FlatButton(
                                              padding: EdgeInsets.all(0),
                                              onPressed: _share,
                                              child: Icon(
                                                IconFont.iconShare,
                                                size: Adaptor.px(40.0),
                                                color: AppColors.appYellow,
                                              )))
                                    ],
                                  )),
                              Container(
                                  width: Adaptor.px(1040.0),
                                  margin: EdgeInsets.only(
                                      top: Adaptor.px(10.0),
                                      left: Adaptor.px(10.0),
                                      right: Adaptor.px(10.0),
                                      bottom: Adaptor.px(10.0)),
                                  padding: EdgeInsets.all(Adaptor.px(16.0)),
                                  decoration: BoxDecoration(
                                      color: AppColors.appWhite,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5.0)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: AppColors.appBlackShadow,
                                            blurRadius: 5.0,
                                            offset: Offset(0, 1.0))
                                      ]),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Container(
                                              width: Adaptor.px(130.0),
                                              height: Adaptor.px(130.0),
                                              margin: EdgeInsets.only(
                                                  right: Adaptor.px(18.0)),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .all(Radius.circular(
                                                          Adaptor.px(80.0))),
                                                  border: Border.all(
                                                      width: Adaptor.px(4.0),
                                                      color:
                                                          AppColors.appBorder)),
                                              child: ClipOval(
                                                  child: Stack(
                                                children: <Widget>[
                                                  Positioned(
                                                      left: 0,
                                                      top: 0,
                                                      child: Image.asset(
                                                        Assets.testImage,
                                                        width: Adaptor.px(60.0),
                                                        height:
                                                            Adaptor.px(60.0),
                                                      )),
                                                  Positioned(
                                                      right: 0,
                                                      top: 0,
                                                      child: Image.asset(
                                                        Assets.test2Image,
                                                        width: Adaptor.px(60.0),
                                                        height:
                                                            Adaptor.px(60.0),
                                                      )),
                                                  Positioned(
                                                      left: 0,
                                                      bottom: 0,
                                                      child: Image.asset(
                                                        Assets.test3Image,
                                                        width: Adaptor.px(60.0),
                                                        height:
                                                            Adaptor.px(60.0),
                                                      )),
                                                  Positioned(
                                                      right: 0,
                                                      bottom: 0,
                                                      child: Image.asset(
                                                        Assets.testImage,
                                                        width: Adaptor.px(60.0),
                                                        height:
                                                            Adaptor.px(60.0),
                                                      ))
                                                ],
                                              ))),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text('宿舍',
                                                  style: TextStyle(
                                                      fontSize:
                                                          Adaptor.px(32.0),
                                                      color: AppColors
                                                          .appTextDark)),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: Adaptor.px(0)),
                                                child: Text('创建于 2019-11-21',
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
                                      Container(
                                          width: Adaptor.px(40.0),
                                          height: Adaptor.px(40.0),
                                          child: FlatButton(
                                              padding: EdgeInsets.all(0),
                                              onPressed: _share,
                                              child: Icon(
                                                IconFont.iconShare,
                                                size: Adaptor.px(40.0),
                                                color: AppColors.appYellow,
                                              )))
                                    ],
                                  ))
                            ],
                          )))),
              Positioned(
                  left: 0,
                  bottom: 0,
                  right: 0,
                  child: Container(
                      height: Adaptor.px(80.0),
                      color: AppColors.appYellow,
                      child: Center(
                          child: FlatButton(
                              onPressed: _createGroup,
                              child: Text('新建圈子',
                                  style: TextStyle(
                                      fontSize: Adaptor.px(28.0),
                                      color: AppColors.appWhite))))))
            ])));
  }
}
