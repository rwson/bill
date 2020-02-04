import 'package:bill/adaptor.dart';
import 'package:bill/colors.dart';
import 'package:flutter/material.dart';

import 'package:bill/iconfont.dart';

class Empty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: Adaptor.px(300.0)),
      child: Center(
        child: Column(
          children: <Widget>[
            Icon(IconFont.iconEmpty, size: Adaptor.px(60.0), color: AppColors.appTextNormal,),
            Padding(
              padding: EdgeInsets.only(top: Adaptor.px(20.0)),
              child: Text('暂无数据', style: TextStyle(
                fontSize: Adaptor.px(20.0),
                color: AppColors.appTextNormal
              ),)
            )
          ],
        )
      ),
    );
  }
}
