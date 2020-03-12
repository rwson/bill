import 'package:bill/adaptor.dart';
import 'package:bill/colors.dart';
import 'package:bill/router.dart';
import 'package:bill/stores/reminder.dart';
import 'package:bill/stores/stores.dart';
import 'package:bill/util.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ReminderDetailPage extends StatefulWidget {
  ReminderDetailPage({@required this.id});

  final String id;

  @override
  State<StatefulWidget> createState() => ReminderDetailState();
}

class ReminderDetailState extends State<ReminderDetailPage> {
  final ReminderStore reminderStore = AppStores.reminderStore;

  AppLifecycleState appLifecycleState;

  @override
  void initState() {
    super.initState();
    reminderStore.getDetail(widget.id);
  }

  @override
  void deactivate() {
    super.deactivate();
    bool current = ModalRoute.of(context).isCurrent;
    if (current) {
      reminderStore.getDetail(widget.id);
    }
  }

  Future<void> _delete() async {
    bool deleteSuccess = await reminderStore.deleteReminder(widget.id);
    if (deleteSuccess) {
      AppRouter.back(context);
    }
  }

  void _deleteReminder() {
    BotToast.showAnimationWidget(
      onlyOne: true,
      backgroundColor: Colors.black26,
      animationDuration: Duration(milliseconds: 300),
      toastBuilder: (cancelFunc) => AlertDialog(
        title: Text('您确定要删除此存款提醒吗?',
            style: TextStyle(
                fontSize: Adaptor.px(32.0), color: AppColors.appTextDark)),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              cancelFunc();
            },
            highlightColor: const Color(0x55FF8A80),
            splashColor: const Color(0x99FF8A80),
            child: const Text(
              '取消',
              style: TextStyle(color: AppColors.appWarning),
            ),
          ),
          FlatButton(
            onPressed: () {
              cancelFunc();
              _delete();
            },
            child: const Text(
              '确定',
              style: TextStyle(color: AppColors.appDanger),
            ),
          ),
        ],
      ),
    );
  }

  void _editReminder() {
    AppRouter.toPage(context, 'edit-reminder?id=${widget.id}');
  }

  Widget _buildDetail() {
    return Observer(
        builder: (_) => Wrap(
              children: <Widget>[
                Container(
                  width: Adaptor.px(1060.0),
                  height: Adaptor.px(100.0),
                  padding: EdgeInsets.only(
                      left: Adaptor.px(16.0), right: Adaptor.px(16.0)),
                  margin: EdgeInsets.only(
                      left: Adaptor.px(10.0), right: Adaptor.px(10.0)),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: Adaptor.onePx(),
                              color: AppColors.appBorder))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('提醒频率',
                          style: TextStyle(
                              color: AppColors.appTextDark,
                              fontSize: Adaptor.px(28.0))),
                      Expanded(
                          flex: 1,
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                  (reminderStore.current != null
                                      ? Util.frenquency2Weekday(
                                          reminderStore.current.frequency)
                                      : ''),
                                  style: TextStyle(
                                      color: AppColors.appTextNormal,
                                      fontSize: Adaptor.px(28.0),
                                      fontWeight: FontWeight.normal))))
                    ],
                  ),
                ),
                Container(
                  width: Adaptor.px(1060.0),
                  height: Adaptor.px(100.0),
                  padding: EdgeInsets.only(
                      left: Adaptor.px(16.0), right: Adaptor.px(16.0)),
                  margin: EdgeInsets.only(
                      left: Adaptor.px(10.0), right: Adaptor.px(10.0)),
                  decoration: BoxDecoration(
                      color: AppColors.appWhite,
                      border: Border(
                          bottom: BorderSide(
                              width: Adaptor.onePx(),
                              color: AppColors.appBorder))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('提醒时间',
                          style: TextStyle(
                              color: AppColors.appTextDark,
                              fontSize: Adaptor.px(28.0))),
                      Expanded(
                          flex: 1,
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                  (reminderStore.current != null
                                      ? reminderStore.current.time
                                      : ''),
                                  style: TextStyle(
                                      color: AppColors.appTextNormal,
                                      fontSize: Adaptor.px(28.0),
                                      fontWeight: FontWeight.normal))))
                    ],
                  ),
                ),
                Container(
                  width: Adaptor.px(1060.0),
                  height: Adaptor.px(100.0),
                  padding: EdgeInsets.only(
                      left: Adaptor.px(16.0), right: Adaptor.px(16.0)),
                  margin: EdgeInsets.only(
                      left: Adaptor.px(10.0), right: Adaptor.px(10.0)),
                  decoration: BoxDecoration(
                      color: AppColors.appWhite,
                      border: Border(
                          bottom: BorderSide(
                              width: Adaptor.onePx(),
                              color: AppColors.appBorder))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('提醒规则',
                          style: TextStyle(
                              color: AppColors.appTextDark,
                              fontSize: Adaptor.px(28.0))),
                      Expanded(
                          flex: 1,
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                  (reminderStore.current != null
                                      ? reminderStore.current.rule == '0'
                                          ? '金额每天递增'
                                          : '金额每天固定'
                                      : ''),
                                  style: TextStyle(
                                      color: AppColors.appTextNormal,
                                      fontSize: Adaptor.px(28.0),
                                      fontWeight: FontWeight.normal))))
                    ],
                  ),
                ),
                (reminderStore.current != null &&
                        reminderStore.current.rule == '0')
                    ? Container(
                        width: Adaptor.px(1060.0),
                        height: Adaptor.px(100.0),
                        padding: EdgeInsets.only(
                            left: Adaptor.px(16.0), right: Adaptor.px(16.0)),
                        margin: EdgeInsets.only(
                            left: Adaptor.px(10.0), right: Adaptor.px(10.0)),
                        decoration: BoxDecoration(
                            color: AppColors.appWhite,
                            border: Border(
                                bottom: BorderSide(
                                    width: Adaptor.onePx(),
                                    color: AppColors.appBorder))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('折返天数',
                                style: TextStyle(
                                    color: AppColors.appTextDark,
                                    fontSize: Adaptor.px(28.0))),
                            Expanded(
                                flex: 1,
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text('${reminderStore.current.back}',
                                        style: TextStyle(
                                            color: AppColors.appTextNormal,
                                            fontSize: Adaptor.px(28.0),
                                            fontWeight: FontWeight.normal))))
                          ],
                        ),
                      )
                    : SizedBox.shrink(),
                Container(
                    width: Adaptor.px(1000.0),
                    height: Adaptor.px(100.0),
                    margin: EdgeInsets.only(
                        top: Adaptor.px(30.0),
                        left: Adaptor.px(10.0),
                        right: Adaptor.px(10.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: _editReminder,
                          child: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.appYellow,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(Adaptor.px(10.0)))),
                              width: Adaptor.px(320.0),
                              height: Adaptor.px(80.0),
                              child: Center(
                                  child: Text('编辑',
                                      style: TextStyle(
                                          fontSize: Adaptor.px(30.0),
                                          fontWeight: FontWeight.normal,
                                          color: AppColors.appTextDark)))),
                        ),
                        GestureDetector(
                            onTap: _deleteReminder,
                            child: Container(
                                width: Adaptor.px(320.0),
                                height: Adaptor.px(80.0),
                                decoration: BoxDecoration(
                                    color: AppColors.appOutlay,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(Adaptor.px(10.0)))),
                                child: Center(
                                    child: Text('删除',
                                        style: TextStyle(
                                            fontSize: Adaptor.px(30.0),
                                            fontWeight: FontWeight.normal,
                                            color: AppColors.appWhite)))))
                      ],
                    )),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('提醒详情',
                style: TextStyle(
                    fontSize: Adaptor.px(32.0), color: AppColors.appTextDark))),
        body: Container(
            margin: EdgeInsets.all(Adaptor.px(10.0)),
            padding: EdgeInsets.only(
                left: Adaptor.px(10.0), right: Adaptor.px(10.0)),
            decoration: BoxDecoration(color: AppColors.appWhite),
            width: Adaptor.px(1060.0),
            child: _buildDetail()));
  }
}
