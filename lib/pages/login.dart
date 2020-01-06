import 'package:bill/adaptor.dart';
import 'package:bill/colors.dart';
import 'package:bill/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flt_telephony_info/flt_telephony_info.dart';

import 'package:bill/stores/stores.dart';

import 'package:bot_toast/bot_toast.dart';

class LoginPage extends StatefulWidget {
  LoginPage({@required this.target});

  final String target;

  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<LoginPage> {
  final _amountController = TextEditingController();

  final userStore = AppStores.userStore;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _toLogin() async {
    TelephonyInfo info;
    try {
      info = await FltTelephonyInfo.info;
      print(info.toString());
    } catch(e) {
      BotToast.showText(text: '手机号获取失败, 请手动填写');
    }

    await userStore.login('13814529475', '!@#qwe456', 'xiaomi 8 ud');
    if (widget.target != '') {
      AppRouter.redirectTo(context, widget.target);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('登录',
                style: TextStyle(
                    fontSize: Adaptor.px(32.0), color: AppColors.appTextDark))),
        body: Container(
            margin: EdgeInsets.only(
                top: Adaptor.px(20.0),
                left: Adaptor.px(10.0),
                right: Adaptor.px(10.0)),
            padding: EdgeInsets.only(
                left: Adaptor.px(10.0), right: Adaptor.px(10.0)),
            width: Adaptor.px(1040.0),
            child: Wrap(
              children: <Widget>[
                Container(
                    width: Adaptor.px(1040.0),
                    height: Adaptor.px(80.0),
                    margin: EdgeInsets.only(top: Adaptor.px(20.0)),
                    decoration: BoxDecoration(
                        color: AppColors.appYellow,
                        borderRadius: BorderRadius.all(
                            Radius.circular(Adaptor.px(10.0)))),
                    child: FlatButton(
                        onPressed: _toLogin,
                        child: Text('一键登录',
                            style: TextStyle(
                                fontSize: Adaptor.px(32.0),
                                fontWeight: FontWeight.normal,
                                color: AppColors.appTextDark))))
              ],
            )));
  }
}
