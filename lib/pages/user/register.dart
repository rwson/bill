import 'dart:io' show Platform;

import 'package:bill/adaptor.dart';
import 'package:bill/api.dart';
import 'package:bill/colors.dart';
import 'package:bill/router.dart';
import 'package:bill/stores/stores.dart';
import 'package:bill/stores/user.dart';
import 'package:bill/util.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:device_info/device_info.dart';
import 'package:flt_telephony_info/flt_telephony_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobpush_plugin/mobpush_plugin.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({@required this.target});

  final String target;

  @override
  State<StatefulWidget> createState() => RegisterState();
}

class RegisterState extends State<RegisterPage> {
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  final TextEditingController _mobileController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _passwordConfirmController =
      TextEditingController();

  final TextEditingController _vCodeController = TextEditingController();

  final FocusNode _mobileFocus = FocusNode();

  final FocusNode _passwordFocus = FocusNode();

  final FocusNode _passwordConfirmFocus = FocusNode();

  final FocusNode _vCodeFocus = FocusNode();

  final UserStore userStore = AppStores.userStore;

  int step = 1;

  String vCodeUrl = '';

  @override
  void initState() {
    super.initState();
    _initMobile();
  }

  @override
  void dispose() {
    _mobileController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _vCodeController.dispose();

    _mobileFocus.dispose();
    _passwordFocus.dispose();
    _passwordConfirmFocus.dispose();
    _vCodeFocus.dispose();

    super.dispose();
  }

  void _initCodeUrl() {
    String mobile = _mobileController.text;

    if (!Util.validMobile(mobile)) {
      BotToast.showText(text: '请输入正确的手机号');
      return;
    }

    setState(() {
      vCodeUrl = '${Api.base}${Api.getVCode}/${mobile}?t=${Util.randomStr(20)}';
    });

    _nextStep();
  }

  void _updateCodeUrl() {
    setState(() {
      vCodeUrl =
          '${Api.base}${Api.getVCode}/${_mobileController.text}?t=${Util.randomStr(20)}';
    });
  }

  void _nextStep() {
    setState(() {
      if (step == 1) {
        _mobileFocus.unfocus();
      } else {
        _vCodeFocus.unfocus();
      }

      step = step + 1;
    });
  }

  void _initMobile() async {
    try {
      if (Platform.isAndroid) {
        TelephonyInfo info = await FltTelephonyInfo.info;
      }
    } catch (e) {}
  }

  Future<void> _toRegister() async {
    _passwordFocus.unfocus();
    _passwordConfirmFocus.unfocus();

    String mobile = _mobileController.text;
    String password = _passwordController.text;
    String passwordConfirm = _passwordConfirmController.text;
    String model;

    try {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      model = androidInfo.model;
    } catch (e) {}

    if (password != passwordConfirm) {
      BotToast.showText(text: '两次密码不一致!');
      return;
    }

    Map<String, dynamic> ridMap = await MobpushPlugin.getRegistrationId();

    bool loginSuccess = await userStore.registerLogin(
        mobile, password, ridMap['res'].toString(), model);

    if (loginSuccess) {
      AppRouter.redirectTo(context, widget.target);
    }
  }

  Future<void> _validateCode() async {
    String mobile = _mobileController.text;
    String vCode = _vCodeController.text;

    if (vCode.length != 4) {
      BotToast.showText(text: '验证码为4位!');
      return;
    }

    bool validateSuccess = await userStore.validateCode(mobile, vCode);

    if (validateSuccess) {
      _nextStep();
    }
  }

  Widget _buildFirstStep() {
    return Wrap(
      children: <Widget>[
        TextField(
          controller: _mobileController,
          keyboardType: TextInputType.phone,
          focusNode: _mobileFocus,
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
                      color: AppColors.appBorderDark, width: Adaptor.onePx()))),
        ),
        Container(
            width: Adaptor.px(1040.0),
            height: Adaptor.px(80.0),
            margin: EdgeInsets.only(top: Adaptor.px(20.0)),
            decoration: BoxDecoration(
                color: AppColors.appYellow,
                borderRadius:
                    BorderRadius.all(Radius.circular(Adaptor.px(10.0)))),
            child: FlatButton(
                onPressed: _initCodeUrl,
                child: Text('下一步',
                    style: TextStyle(
                        fontSize: Adaptor.px(32.0),
                        fontWeight: FontWeight.normal,
                        color: AppColors.appTextDark))))
      ],
    );
  }

  Widget _buildSecondStep() {
    return Wrap(
      children: <Widget>[
        Flex(
          direction: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Expanded(
                child: TextField(
              controller: _vCodeController,
              focusNode: _vCodeFocus,
              autocorrect: false,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                      top: Adaptor.px(30.0),
                      bottom: Adaptor.px(30.0),
                      left: Adaptor.px(20.0)),
                  hintText: '请输入图片验证码',
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
            )),
            GestureDetector(
                onTap: _updateCodeUrl,
                child: Container(
                    child: Image.network(
                  vCodeUrl,
                  width: Adaptor.px(240),
                  height: Adaptor.px(80),
                ))),
          ],
        ),
        Container(
            width: Adaptor.px(1040.0),
            height: Adaptor.px(80.0),
            margin: EdgeInsets.only(top: Adaptor.px(20.0)),
            decoration: BoxDecoration(
                color: AppColors.appYellow,
                borderRadius:
                    BorderRadius.all(Radius.circular(Adaptor.px(10.0)))),
            child: FlatButton(
                onPressed: _validateCode,
                child: Text('下一步',
                    style: TextStyle(
                        fontSize: Adaptor.px(32.0),
                        fontWeight: FontWeight.normal,
                        color: AppColors.appTextDark))))
      ],
    );
  }

  Widget _buildThirdStep() {
    return Wrap(
      children: <Widget>[
        TextField(
          controller: _passwordController,
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          focusNode: _passwordFocus,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                  top: Adaptor.px(30.0),
                  bottom: Adaptor.px(30.0),
                  left: Adaptor.px(20.0)),
              hintText: '设置密码',
              fillColor: AppColors.appWhite,
              filled: true,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: AppColors.appBorder, width: Adaptor.onePx()),
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: AppColors.appBorderDark, width: Adaptor.onePx()))),
        ),
        TextField(
          controller: _passwordConfirmController,
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          focusNode: _passwordConfirmFocus,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                  top: Adaptor.px(30.0),
                  bottom: Adaptor.px(30.0),
                  left: Adaptor.px(20.0)),
              hintText: '确认密码',
              fillColor: AppColors.appWhite,
              filled: true,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: AppColors.appBorder, width: Adaptor.onePx()),
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: AppColors.appBorderDark, width: Adaptor.onePx()))),
        ),
        Container(
            width: Adaptor.px(1040.0),
            height: Adaptor.px(80.0),
            margin: EdgeInsets.only(top: Adaptor.px(20.0)),
            decoration: BoxDecoration(
                color: AppColors.appYellow,
                borderRadius:
                    BorderRadius.all(Radius.circular(Adaptor.px(10.0)))),
            child: FlatButton(
                onPressed: _toRegister,
                child: Text('注册',
                    style: TextStyle(
                        fontSize: Adaptor.px(32.0),
                        fontWeight: FontWeight.normal,
                        color: AppColors.appTextDark))))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('注册',
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
            child: step == 1
                ? _buildFirstStep()
                : step == 2 ? _buildSecondStep() : _buildThirdStep()));
  }
}
