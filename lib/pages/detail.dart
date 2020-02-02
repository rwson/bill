import 'package:bill/adaptor.dart';
import 'package:bill/colors.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('账单详情',
                style: TextStyle(
                    fontSize: Adaptor.px(32.0),
                    color: AppColors.appTextDark))));
  }
}
