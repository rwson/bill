import 'package:bill/adaptor.dart';
import 'package:bill/colors.dart';
import 'package:bill/iconfont.dart';
import 'package:flutter/material.dart';

class Empty extends StatelessWidget {
  Empty({Key key, this.text, this.child, this.top}) : super(key: key);
  
  final String text;

  final Widget child;

  final double top;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: top ?? Adaptor.px(300.0)),
      child: Center(
        child: Column(
          children: <Widget>[
            Icon(IconFont.iconEmpty, size: Adaptor.px(100.0), color: AppColors.appTextLight),
            Padding(
              padding: EdgeInsets.only(top: Adaptor.px(50.0)),
              child: child == null ? Text(text ?? '暂无数据', style: TextStyle(
                fontSize: Adaptor.px(28.0),
                color: AppColors.appTextLight
              )) : child
            )
          ]
        )
      ),
    );
  }
}
