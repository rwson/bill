import 'package:bill/adaptor.dart';
import 'package:bill/colors.dart';
import 'package:bill/methods-icons.dart';
import 'package:bill/pay-channels.dart';
import 'package:bill/router.dart';
import 'package:bill/stores/stores.dart';
import 'package:bill/stores/task.dart';
import 'package:bill/util.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class TaskDetailPage extends StatefulWidget {
  TaskDetailPage({@required this.id});

  final String id;

  @override
  State<StatefulWidget> createState() => TaskDetailState();
}

class TaskDetailState extends State<TaskDetailPage> {
  final TaskStore taskStore = AppStores.taskStore;

  @override
  void initState() {
    super.initState();

    taskStore.getDetail(widget.id);
  }

  @override
  void deactivate() {
    super.deactivate();
    bool current = ModalRoute.of(context).isCurrent;
    if (current) {
      taskStore.getDetail(widget.id);
    }
  }

  Future<void> _delete() async {
    bool deleteSuccess = await taskStore.deleteTask(widget.id);
    if (deleteSuccess) {
      AppRouter.back(context);
    }
  }

  void _deleteTask() {
    BotToast.showAnimationWidget(
      onlyOne: true,
      backgroundColor: Colors.black26,
      animationDuration: Duration(milliseconds: 300),
      toastBuilder: (cancelFunc) => AlertDialog(
        title: Text('您确定要删除此记账任务吗?',
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

  void _editTask() {
    AppRouter.toPage(context, 'edit-task?id=${widget.id}');
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
                      Text('记账频率',
                          style: TextStyle(
                              color: AppColors.appTextDark,
                              fontSize: Adaptor.px(28.0))),
                      Expanded(
                          flex: 1,
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                  (taskStore.current != null
                                      ? Util.frenquency2Weekday(
                                          taskStore.current.frequency)
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
                      Text('记账时间',
                          style: TextStyle(
                              color: AppColors.appTextDark,
                              fontSize: Adaptor.px(28.0))),
                      Expanded(
                          flex: 1,
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                  (taskStore.current != null
                                      ? taskStore.current.time
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
                      Text('记账金额',
                          style: TextStyle(
                              color: AppColors.appTextDark,
                              fontSize: Adaptor.px(28.0))),
                      Expanded(
                          flex: 1,
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                  (taskStore.current != null
                                      ? '￥${double.parse(taskStore.current.amount).toStringAsFixed(2)}'
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
                      Text('账单分类',
                          style: TextStyle(
                              color: AppColors.appTextDark,
                              fontSize: Adaptor.px(28.0))),
                      Expanded(
                          flex: 1,
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                  (taskStore.current != null
                                      ? MethodsIcons
                                          .paymentIconMaps[
                                              taskStore.current.category]
                                          .desc
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
                      Text('支付方式',
                          style: TextStyle(
                              color: AppColors.appTextDark,
                              fontSize: Adaptor.px(28.0))),
                      Expanded(
                          flex: 1,
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                  (taskStore.current != null
                                      ? PayChannels
                                          .payChannelMaps[
                                              taskStore.current.payMethod]
                                          .desc
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
                      Text('账单备注',
                          style: TextStyle(
                              color: AppColors.appTextDark,
                              fontSize: Adaptor.px(28.0))),
                      Expanded(
                          flex: 1,
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                  (taskStore.current != null
                                      ? taskStore.current.remark
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
                      Text('是否确认',
                          style: TextStyle(
                              color: AppColors.appTextDark,
                              fontSize: Adaptor.px(28.0))),
                      Expanded(
                          flex: 1,
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                  (taskStore.current != null
                                      ? taskStore.current.confirm == '1'
                                          ? '是'
                                          : '否'
                                      : ''),
                                  style: TextStyle(
                                      color: AppColors.appTextNormal,
                                      fontSize: Adaptor.px(28.0),
                                      fontWeight: FontWeight.normal))))
                    ],
                  ),
                ),
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
                            onTap: _editTask,
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
                                          fontSize: Adaptor.px(28.0),
                                          fontWeight: FontWeight.normal,
                                          color: AppColors.appTextDark))),
                            )),
                        GestureDetector(
                            onTap: _deleteTask,
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
                                            fontSize: Adaptor.px(28.0),
                                            fontWeight: FontWeight.normal,
                                            color: AppColors.appWhite)))))
                      ],
                    ))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('任务详情',
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
