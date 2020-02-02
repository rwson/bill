import 'package:bill/adaptor.dart';
import 'package:bill/bean/reminder.dart';
import 'package:bill/colors.dart';
import 'package:bill/iconfont.dart';
import 'package:bill/router.dart';
import 'package:bill/stores/reminder.dart';
import 'package:bill/stores/stores.dart';
import 'package:bill/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class RemindersPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RemindersState();
}

class RemindersState extends State<RemindersPage> with WidgetsBindingObserver {
  final ReminderStore reminderStore = AppStores.reminderStore;

  @override
  void initState() {
    super.initState();
    reminderStore.queryReminder();
  }

  void _toCreateReminder() {
    AppRouter.toPage(context, 'create-reminder');
  }

  void _toDetail(int id) {
    AppRouter.toPage(context, 'reminder-detail?id=${id}');
  }

  @override
  void deactivate() {
    super.deactivate();
    bool current = ModalRoute.of(context).isCurrent;
    if (current) {
      reminderStore.queryReminder();
    }
  }

  Widget _buildReminders() {
    return Container(
        child: SingleChildScrollView(
      child: Container(
          margin: EdgeInsets.only(
              top: Adaptor.px(10.0),
              left: Adaptor.px(10.0),
              right: Adaptor.px(10.0),
              bottom: Adaptor.px(120.0)),
          child: Observer(
            builder: (_) => Wrap(
              children: <Widget>[
                Container(
                    child: SingleChildScrollView(
                        child: Container(
                            margin: EdgeInsets.only(
                                top: Adaptor.px(10.0),
                                left: Adaptor.px(10.0),
                                right: Adaptor.px(10.0)),
                            child: Wrap(
                              children: List.generate(
                                  reminderStore.reminder.length, (int i) {
                                ReminderItem _reminder =
                                    reminderStore.reminder[i];
                                return Container(
                                    width: Adaptor.px(1040.0),
                                    margin: EdgeInsets.all(Adaptor.px(10.0)),
                                    padding: EdgeInsets.all(Adaptor.px(10.0)),
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
                                    child: GestureDetector(
                                        onTap: () => _toDetail(_reminder.id),
                                        child: Wrap(
                                          children: <Widget>[
                                            Container(
                                                padding: EdgeInsets.only(
                                                    top: Adaptor.px(10.0),
                                                    left: Adaptor.px(10.0),
                                                    right: Adaptor.px(10.0),
                                                    bottom: Adaptor.px(16.0)),
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            width:
                                                                Adaptor.onePx(),
                                                            color: AppColors
                                                                .appBorder))),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Icon(
                                                            IconFont
                                                                .iconReminder,
                                                            size: Adaptor.px(
                                                                28.0),
                                                            color: AppColors
                                                                .appYellow,
                                                          ),
                                                          Padding(
                                                              padding: EdgeInsets.only(
                                                                  left: Adaptor
                                                                      .px(
                                                                          10.0)),
                                                              child: Text(
                                                                  '存钱提醒',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          Adaptor.px(
                                                                              28.0),
                                                                      color: AppColors
                                                                          .appTextDark))),
                                                          Text(
                                                              Util.isAfter(
                                                                      _reminder
                                                                          .time)
                                                                  ? '(已提醒)'
                                                                  : '',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      Adaptor.px(
                                                                          20.0),
                                                                  color: AppColors
                                                                      .appIncome))
                                                        ],
                                                      ),
                                                      Text(
                                                          '${Util.frenquency2Weekday(_reminder.frequency)} ${_reminder.time}',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  Adaptor.px(
                                                                      26.0),
                                                              color: AppColors
                                                                  .appTextDark))
                                                    ])),
                                            Container(
                                                padding: EdgeInsets.all(
                                                    Adaptor.px(10.0)),
                                                child: Text(
                                                    _reminder.rule == '0'
                                                        ? '金额每天递增'
                                                        : '金额每天固定',
                                                    style: TextStyle(
                                                        fontSize:
                                                            Adaptor.px(26.0),
                                                        color: AppColors
                                                            .appTextNormal,
                                                        height: 1.5)))
                                          ],
                                        )));
                              }).toList(),
                            ))))
              ],
            ),
          )),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('存钱提醒',
                style: TextStyle(
                    fontSize: Adaptor.px(32.0), color: AppColors.appTextDark))),
        body: Container(
            height: double.infinity,
            child: Stack(children: <Widget>[
              _buildReminders(),
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
