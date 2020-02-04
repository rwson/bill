import 'package:bill/adaptor.dart';
import 'package:bill/colors.dart';
import 'package:bill/iconfont.dart';
import 'package:bill/router.dart';
import 'package:bill/stores/task.dart';
import 'package:bill/stores/stores.dart';
import 'package:bill/widgets/empty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class TaskPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TaskState();
}

class TaskState extends State<TaskPage> with WidgetsBindingObserver {
  final TaskStore taskStore = AppStores.taskStore;

  @override
  void initState() {
    super.initState();
    taskStore.queryTask();
  }

  void _toCreateTask() {
    AppRouter.toPage(context, 'create-task');
  }

  void _toDetail() {
    AppRouter.toPage(context, 'task-detail');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('记账任务',
                style: TextStyle(
                    fontSize: Adaptor.px(32.0), color: AppColors.appTextDark))),
        body: Container(
            height: double.infinity,
            child: Stack(children: <Widget>[
              Container(
                  child: (taskStore.tasks != null && taskStore.tasks.length > 0) ? SingleChildScrollView(
                      child: Container(
                          margin: EdgeInsets.only(
                              top: Adaptor.px(10.0),
                              left: Adaptor.px(10.0),
                              right: Adaptor.px(10.0)),
                          child: Observer(
                            builder: (_) => Wrap(
                              children: <Widget>[
                                Container(
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
                                        onTap: _toDetail,
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
                                                            IconFont.iconTask,
                                                            size:
                                                            Adaptor.px(28.0),
                                                            color: AppColors
                                                                .appYellow,
                                                          ),
                                                          Text('自动记账',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  Adaptor.px(
                                                                      24.0),
                                                                  color: AppColors
                                                                      .appTextDark)),
                                                          Text('(记账前跟我确认)',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  Adaptor.px(
                                                                      20.0),
                                                                  color: AppColors
                                                                      .appIncome))
                                                        ],
                                                      ),
                                                      Text('09:00',
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
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: <Widget>[
                                                    Text('上班地铁费',
                                                        style: TextStyle(
                                                            fontSize:
                                                            Adaptor.px(24.0),
                                                            color: AppColors
                                                                .appTextNormal))
                                                  ],
                                                ))
                                          ],
                                        )))
                              ],
                            ),
                          )
                      )) : Empty()
              ),
              Positioned(
                  left: 0,
                  bottom: 0,
                  right: 0,
                  child: Container(
                      height: Adaptor.px(80.0),
                      color: AppColors.appYellow,
                      child: Center(
                          child: FlatButton(
                              onPressed: _toCreateTask,
                              child: Text('添加记账任务',
                                  style: TextStyle(
                                      fontSize: Adaptor.px(28.0),
                                      color: AppColors.appWhite))))))
            ])));
  }
}
