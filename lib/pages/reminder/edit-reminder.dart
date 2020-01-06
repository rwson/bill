import 'package:bill/adaptor.dart';
import 'package:bill/colors.dart';
import 'package:bill/iconfont.dart';
import 'package:bill/router.dart';
import 'package:flutter/material.dart';

class MethodItem {
  bool checked;
  IconData icon;
  String desc;
  String type;

  MethodItem({this.checked, this.icon, this.desc, this.type});
}

class EditReminderPage extends StatefulWidget {
  EditReminderPage({@required this.id});

  final String id;

  @override
  State<StatefulWidget> createState() => EditReminderState();
}

class EditReminderState extends State<EditReminderPage> {
  @override
  void initState() {
    super.initState();
  }

  void _toCreateReminder() {
    AppRouter.toPage(context, 'create-reminder');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('修改存钱提醒',
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
                              top: Adaptor.px(20.0),
                              left: Adaptor.px(10.0),
                              right: Adaptor.px(10.0),
                            ),
                            padding: EdgeInsets.only(
                                left: Adaptor.px(10.0),
                                right: Adaptor.px(10.0)),
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
                            child: Wrap(
                              children: <Widget>[
                                Container(
                                    padding: EdgeInsets.only(
                                        top: Adaptor.px(20.0),
                                        left: Adaptor.px(10.0),
                                        right: Adaptor.px(10.0),
                                        bottom: Adaptor.px(20.0)),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: Adaptor.onePx(),
                                                color: AppColors.appBorder))),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(
                                                IconFont.iconReminder,
                                                size: Adaptor.px(32.0),
                                                color: AppColors.appYellow,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: Adaptor.px(8.0)),
                                                child: Text('存钱提醒',
                                                    style: TextStyle(
                                                        fontSize:
                                                            Adaptor.px(26.0),
                                                        color: AppColors
                                                            .appTextDark)),
                                              ),
                                              Text('(已提醒)',
                                                  style: TextStyle(
                                                      fontSize:
                                                          Adaptor.px(20.0),
                                                      color:
                                                          AppColors.appIncome))
                                            ],
                                          ),
                                          Text('09:00',
                                              style: TextStyle(
                                                  fontSize: Adaptor.px(26.0),
                                                  color: AppColors.appTextDark))
                                        ])),
                                Container(
                                    padding: EdgeInsets.all(Adaptor.px(10.0)),
                                    child: Text(
                                        '每天递增, 如遇当日未存钱第二天还是提醒存今天的额度, 总额到100自动折返',
                                        style: TextStyle(
                                            fontSize: Adaptor.px(24.0),
                                            color: AppColors.appTextNormal,
                                            height: 1.5)))
                              ],
                            )),
                        Container(
                            width: Adaptor.px(1040.0),
                            margin: EdgeInsets.only(
                              top: Adaptor.px(20.0),
                              left: Adaptor.px(10.0),
                              right: Adaptor.px(10.0),
                            ),
                            padding: EdgeInsets.only(
                                left: Adaptor.px(10.0),
                                right: Adaptor.px(10.0)),
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
                            child: Wrap(
                              children: <Widget>[
                                Container(
                                    padding: EdgeInsets.only(
                                        top: Adaptor.px(20.0),
                                        left: Adaptor.px(10.0),
                                        right: Adaptor.px(10.0),
                                        bottom: Adaptor.px(20.0)),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: Adaptor.onePx(),
                                                color: AppColors.appBorder))),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(
                                                IconFont.iconReminder,
                                                size: Adaptor.px(32.0),
                                                color: AppColors.appYellow,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: Adaptor.px(8.0)),
                                                child: Text('存钱提醒',
                                                    style: TextStyle(
                                                        fontSize:
                                                            Adaptor.px(26.0),
                                                        color: AppColors
                                                            .appTextDark)),
                                              ),
                                              Text('(待提醒)',
                                                  style: TextStyle(
                                                      fontSize:
                                                          Adaptor.px(20.0),
                                                      color:
                                                          AppColors.appOutlay))
                                            ],
                                          ),
                                          Text('10:00',
                                              style: TextStyle(
                                                  fontSize: Adaptor.px(26.0),
                                                  color: AppColors.appTextDark))
                                        ])),
                                Container(
                                    padding: EdgeInsets.all(Adaptor.px(10.0)),
                                    child: Text(
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
              Positioned(
                  left: 0,
                  bottom: 0,
                  right: 0,
                  child: Container(
                      height: Adaptor.px(80.0),
                      color: AppColors.appYellow,
                      child: Center(
                          child: FlatButton(
                              onPressed: _toCreateReminder,
                              child: Text('添加存钱提醒',
                                  style: TextStyle(
                                      fontSize: Adaptor.px(28.0),
                                      color: AppColors.appWhite))))))
            ])));
  }
}
