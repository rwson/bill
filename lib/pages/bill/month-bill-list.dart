import 'package:bill/adaptor.dart';
import 'package:bill/colors.dart';
import 'package:bill/stores/reminder.dart';
import 'package:bill/stores/stores.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MonthBillListPage extends StatefulWidget {
  MonthBillListPage({@required this.month});

  final String month;

  @override
  State<StatefulWidget> createState() => MonthBillListState();
}

class MonthBillListState extends State<MonthBillListPage> {
  final ReminderStore reminderStore = AppStores.reminderStore;

  AppLifecycleState appLifecycleState;

  @override
  void initState() {
    super.initState();
//    print(widget.month);
    // reminderStore.getDetail(widget.id);
  }

  @override
  void deactivate() {
    // super.deactivate();
    // bool current = ModalRoute.of(context).isCurrent;
    // if (current) {
    //   reminderStore.getDetail(widget.id);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('月度账单详情',
                style: TextStyle(
                    fontSize: Adaptor.px(32.0), color: AppColors.appTextDark))),
        body: Container(
            margin: EdgeInsets.all(Adaptor.px(10.0)),
            padding: EdgeInsets.only(
                left: Adaptor.px(10.0), right: Adaptor.px(10.0)),
            decoration: BoxDecoration(color: AppColors.appWhite),
            width: Adaptor.px(1060.0),
            child: Container()
            ));
  }
}
