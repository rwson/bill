import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bill/adaptor.dart';
import 'package:bill/colors.dart';
import 'package:bill/util.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<LoginPage> {
  final int _precision = 2;

  final _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _saveLimit() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('设置月预算',
                style: TextStyle(
                    fontSize: Adaptor.px(32.0), color: AppColors.appTextDark))),
        body: new Container(
            margin: EdgeInsets.only(
                top: Adaptor.px(20.0),
                left: Adaptor.px(10.0),
                right: Adaptor.px(10.0)),
            padding: EdgeInsets.only(
                left: Adaptor.px(10.0), right: Adaptor.px(10.0)),
            width: Adaptor.px(1040.0),
            child: new Wrap(
              children: <Widget>[
                new Container(
                    width: Adaptor.px(1040.0),
                    height: Adaptor.px(100.0),
                    decoration: new BoxDecoration(
                        color: AppColors.appWhite,
                        borderRadius:
                        BorderRadius.all(Radius.circular(Adaptor.px(10.0))),
                        border: Border.all(
                            width: Adaptor.onePx(), color: AppColors.appBorder),
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.appBlackShadow, blurRadius: 5.0)
                        ]),
                    child: new TextField(
                        decoration: InputDecoration(
                            hintText: '请输入金额',
                            fillColor: Colors.transparent,
                            filled: true,
                            border: InputBorder.none),
                        inputFormatters: [PrecisionLimitFormatter(_precision)],
                        keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                        style: TextStyle(
                            fontSize: Adaptor.px(32.0),
                            color: AppColors.appTextDark),
                        cursorWidth: 1.0,
                        cursorColor: AppColors.appTextDark,
                        textAlign: TextAlign.center,
                        controller: _amountController)),
                new Container(
                    width: Adaptor.px(1040.0),
                    height: Adaptor.px(80.0),
                    margin: EdgeInsets.only(top: Adaptor.px(20.0)),
                    decoration: new BoxDecoration(
                        color: AppColors.appYellow,
                        borderRadius: BorderRadius.all(
                            Radius.circular(Adaptor.px(10.0)))),
                    child: new FlatButton(
                        onPressed: _saveLimit,
                        child: new Text('保存',
                            style: TextStyle(
                                fontSize: Adaptor.px(32.0),
                                fontWeight: FontWeight.normal,
                                color: AppColors.appTextDark))))
              ],
            )));
  }
}
