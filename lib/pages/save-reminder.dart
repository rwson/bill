import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../adaptor.dart';
import '../colors.dart';
import '../iconfont.dart';
import '../router.dart';

class MethodItem {
  bool checked;
  IconData icon;
  String desc;
  String type;

  MethodItem({this.checked, this.icon, this.desc, this.type});
}

class SaveReminderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SaveReminderState();
}

class SaveReminderState extends State<SaveReminderPage> {
  @override
  void initState() {
    super.initState();
  }

  void _toCreateReminder() {
    AppRouter.router.navigateTo(context, 'create-reminder',
        transition: TransitionType.material);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('存钱提醒',
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
                              top: Adaptor.px(20.0),
                              left: Adaptor.px(10.0),
                              right: Adaptor.px(10.0),
                            ),
                            padding: EdgeInsets.only(
                                left: Adaptor.px(10.0),
                                right: Adaptor.px(10.0)),
                            decoration: new BoxDecoration(
                                color: AppColors.appWhite,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0)),
                                boxShadow: [
                                  BoxShadow(
                                      color: AppColors.appBlackShadow,
                                      blurRadius: 5.0)
                                ]),
                            child: new Wrap(
                              children: <Widget>[
                                new Container(
                                    padding: EdgeInsets.only(
                                        top: Adaptor.px(20.0),
                                        left: Adaptor.px(10.0),
                                        right: Adaptor.px(10.0),
                                        bottom: Adaptor.px(20.0)),
                                    decoration: new BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: Adaptor.onePx(),
                                                color: AppColors.appBorder))),
                                    child: new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          new Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              new Icon(
                                                IconFont.iconReminder,
                                                size: Adaptor.px(32.0),
                                                color: AppColors.appYellow,
                                              ),
                                              new Padding(
                                                padding: EdgeInsets.only(
                                                    left: Adaptor.px(8.0)),
                                                child: new Text('存钱提醒',
                                                    style: TextStyle(
                                                        fontSize:
                                                            Adaptor.px(26.0),
                                                        color: AppColors
                                                            .appTextDark)),
                                              ),
                                              new Text('(已提醒)',
                                                  style: TextStyle(
                                                      fontSize:
                                                          Adaptor.px(20.0),
                                                      color:
                                                          AppColors.appIncome))
                                            ],
                                          ),
                                          new Text('09:00',
                                              style: TextStyle(
                                                  fontSize: Adaptor.px(26.0),
                                                  color: AppColors.appTextDark))
                                        ])),
                                new Container(
                                    padding: EdgeInsets.all(Adaptor.px(10.0)),
                                    child: new Text(
                                        '每天递增, 如遇当日未存钱第二天还是提醒存今天的额度, 总额到100自动折返',
                                        style: TextStyle(
                                            fontSize: Adaptor.px(24.0),
                                            color: AppColors.appTextNormal,
                                            height: 1.5)))
                              ],
                            )),
                        new Container(
                            width: Adaptor.px(1040.0),
                            margin: EdgeInsets.only(
                              top: Adaptor.px(20.0),
                              left: Adaptor.px(10.0),
                              right: Adaptor.px(10.0),
                            ),
                            padding: EdgeInsets.only(
                                left: Adaptor.px(10.0),
                                right: Adaptor.px(10.0)),
                            decoration: new BoxDecoration(
                                color: AppColors.appWhite,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0)),
                                boxShadow: [
                                  BoxShadow(
                                      color: AppColors.appBlackShadow,
                                      blurRadius: 5.0)
                                ]),
                            child: new Wrap(
                              children: <Widget>[
                                new Container(
                                    padding: EdgeInsets.only(
                                        top: Adaptor.px(20.0),
                                        left: Adaptor.px(10.0),
                                        right: Adaptor.px(10.0),
                                        bottom: Adaptor.px(20.0)),
                                    decoration: new BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: Adaptor.onePx(),
                                                color: AppColors.appBorder))),
                                    child: new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          new Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              new Icon(
                                                IconFont.iconReminder,
                                                size: Adaptor.px(32.0),
                                                color: AppColors.appYellow,
                                              ),
                                              new Padding(
                                                padding: EdgeInsets.only(
                                                    left: Adaptor.px(8.0)),
                                                child: new Text('存钱提醒',
                                                    style: TextStyle(
                                                        fontSize:
                                                            Adaptor.px(26.0),
                                                        color: AppColors
                                                            .appTextDark)),
                                              ),
                                              new Text('(待提醒)',
                                                  style: TextStyle(
                                                      fontSize:
                                                          Adaptor.px(20.0),
                                                      color:
                                                          AppColors.appOutlay))
                                            ],
                                          ),
                                          new Text('10:00',
                                              style: TextStyle(
                                                  fontSize: Adaptor.px(26.0),
                                                  color: AppColors.appTextDark))
                                        ])),
                                new Container(
                                    padding: EdgeInsets.all(Adaptor.px(10.0)),
                                    child: new Text(
                                        '每天递增, 如遇当日未存钱第二天还是提醒存今天的额度, 总额到100自动折返',
                                        style: TextStyle(
                                            fontSize: Adaptor.px(24.0),
                                            color: AppColors.appTextNormal,
                                            height: 1.5)))
                              ],
                            ))
                      ],
                    )),
              )),
              new Positioned(
                  left: 0,
                  bottom: 0,
                  right: 0,
                  child: new Container(
                      height: Adaptor.px(80.0),
                      color: AppColors.appYellow,
                      child: new Center(
                          child: new FlatButton(
                              onPressed: _toCreateReminder,
                              child: new Text('添加存钱提醒',
                                  style: new TextStyle(
                                      fontSize: Adaptor.px(28.0),
                                      color: AppColors.appWhite))))))
            ])));
  }
}
