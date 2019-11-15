import 'package:flutter/material.dart';

import '../adaptor.dart';
import '../assets.dart';
import '../colors.dart';
import '../iconfont.dart';
import '../router.dart';

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
                    fontSize: Adaptor.px(32.0), color: AppColors.appTextDark))));
  }
}
