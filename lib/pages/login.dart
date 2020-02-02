import 'dart:io' show Platform;

import 'package:bill/adaptor.dart';
import 'package:bill/colors.dart';
import 'package:bill/router.dart';
import 'package:bill/stores/stores.dart';
import 'package:bill/stores/user.dart';
import 'package:device_info/device_info.dart';
import 'package:flt_telephony_info/flt_telephony_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//MobpushPlugin.getRegistrationId().then((Map<String, dynamic> ridMap) {
//print(ridMap);
//String regId = ridMap['res'].toString();
//print('------>#### registrationId: ' + regId);
//});

class LoginPage extends StatefulWidget {
  LoginPage({@required this.target});

  final String target;

  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<LoginPage> {
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  final TextEditingController _mobileController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final UserStore userStore = AppStores.userStore;

  String regId;

  @override
  void initState() {
    super.initState();
    _initMobile();
  }

  @override
  void dispose() {
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _initMobile() async {
    try {
      if (Platform.isAndroid) {
        TelephonyInfo info = await FltTelephonyInfo.info;
      }
    } catch (e) {}
  }

  void _toRegister() {
    AppRouter.redirectTo(context, 'register');
  }

  void _toForgot() {
    AppRouter.toPage(context, 'forgot', false);
  }

  Future<void> _toLogin() async {
    String mobile = _mobileController.text;
    String password = _passwordController.text;
    String model;

    try {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      model = androidInfo.model;
    } catch (e) {}

    bool loginSuccess = await userStore.login(mobile, password, model);

    if (loginSuccess) {
      if (widget.target != '') {
        AppRouter.redirectTo(context, widget.target);
      }
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
                left: Adaptor.px(20.0),
                right: Adaptor.px(20.0)),
            padding: EdgeInsets.only(
                left: Adaptor.px(10.0), right: Adaptor.px(10.0)),
            width: Adaptor.px(1020.0),
            child: Wrap(
              children: <Widget>[
                TextField(
                  controller: _mobileController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          top: Adaptor.px(30.0),
                          bottom: Adaptor.px(30.0),
                          left: Adaptor.px(20.0)),
                      hintText: '请输入手机号',
                      fillColor: AppColors.appWhite,
                      filled: true,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.appBorder, width: Adaptor.onePx()),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.appBorderDark,
                              width: Adaptor.onePx()))),
                ),
                TextField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          top: Adaptor.px(30.0),
                          bottom: Adaptor.px(30.0),
                          left: Adaptor.px(20.0)),
                      hintText: '请输入登录密码',
                      fillColor: AppColors.appWhite,
                      filled: true,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.appBorder, width: Adaptor.onePx()),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.appBorderDark,
                              width: Adaptor.onePx()))),
                ),
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
                        child: Text('登录',
                            style: TextStyle(
                                fontSize: Adaptor.px(32.0),
                                fontWeight: FontWeight.normal,
                                color: AppColors.appTextDark)))),
                Container(
                    margin: EdgeInsets.only(top: Adaptor.px(20.0)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(onTap: _toForgot, child: Text('忘记密码')),
                        GestureDetector(onTap: _toRegister, child: Text('注册')),
                      ],
                    ))
              ],
            )));
  }
}
