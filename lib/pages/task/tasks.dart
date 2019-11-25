import 'package:bill/adaptor.dart';
import 'package:bill/colors.dart';
import 'package:bill/iconfont.dart';
import 'package:bill/router.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TaskState();
}

class TaskState extends State<TaskPage> {
  @override
  void initState() {
    super.initState();
  }

  void _toCreateTask() {
    AppRouter.router.navigateTo(context, 'create-task',
        transition: TransitionType.material);
  }

  void _toDetail() {
    AppRouter.router
        .navigateTo(context, 'task-detail', transition: TransitionType.material);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('记账任务',
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
                                  margin: EdgeInsets.all(
                                      Adaptor.px(10.0)
                                  ),
                                  padding: EdgeInsets.all(Adaptor.px(10.0)),
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
                                  child: new GestureDetector(
                                    onTap: _toDetail,
                                    child: new Wrap(
                                      children: <Widget>[
                                        new Container(
                                            padding: EdgeInsets.only(
                                                top: Adaptor.px(10.0),
                                                left: Adaptor.px(10.0),
                                                right: Adaptor.px(10.0),
                                                bottom: Adaptor.px(16.0)),
                                            decoration: new BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        width: Adaptor.onePx(),
                                                        color: AppColors
                                                            .appBorder))),
                                            child: new Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: <Widget>[
                                                  new Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                    children: <Widget>[
                                                      new Icon(
                                                        IconFont.iconTask,
                                                        size: Adaptor.px(28.0),
                                                        color:
                                                        AppColors.appYellow,
                                                      ),
                                                      new Text('自动记账',
                                                          style: TextStyle(
                                                              fontSize:
                                                              Adaptor.px(
                                                                  24.0),
                                                              color: AppColors
                                                                  .appTextDark)),
                                                      new Text('(记账前跟我确认)',
                                                          style: TextStyle(
                                                              fontSize:
                                                              Adaptor.px(
                                                                  20.0),
                                                              color: AppColors
                                                                  .appIncome))
                                                    ],
                                                  ),
                                                  new Text('09:00',
                                                      style: TextStyle(
                                                          fontSize:
                                                          Adaptor.px(26.0),
                                                          color: AppColors
                                                              .appTextDark))
                                                ])),
                                        new Container(
                                            padding:
                                            EdgeInsets.all(Adaptor.px(10.0)),
                                            child: new Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                new Text('上班地铁费',
                                                    style: TextStyle(
                                                        fontSize:
                                                        Adaptor.px(24.0),
                                                        color: AppColors
                                                            .appTextNormal))
                                              ],
                                            ))
                                      ],
                                    )
                                  )
                              )
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
                              onPressed: _toCreateTask,
                              child: new Text('添加记账任务',
                                  style: new TextStyle(
                                      fontSize: Adaptor.px(28.0),
                                      color: AppColors.appWhite))))))
            ])));
  }
}
