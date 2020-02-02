import 'package:bill/adaptor.dart';
import 'package:bill/colors.dart';
import 'package:bill/router.dart';
import 'package:bill/stores/limit.dart';
import 'package:bill/stores/stores.dart';
import 'package:bill/util.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LimitSetPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LimitSetState();
}

class LimitSetState extends State<LimitSetPage> {
  final int _precision = 2;

  final _amountController = TextEditingController();

  final FocusNode _limitFocus = FocusNode();

  final LimitStore limitStore = AppStores.limitStore;

  @override
  void initState() {
    super.initState();
    _queryLimit();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _limitFocus.dispose();
    super.dispose();
  }

  Future<void> _queryLimit() async {
    bool querySuccess = await limitStore.queryLimit();
    if (querySuccess) {
      _amountController.text = '${limitStore.limit}';
    }
  }

  Future<void> _saveLimit() async {
    _limitFocus.unfocus();
    final data = await limitStore.setLimit(int.parse(_amountController.text));
    BotToast.showText(text: data.message);
    if (data.success) {
      AppRouter.back(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('设置月预算',
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
                    decoration: BoxDecoration(
                        color: AppColors.appWhite,
                        borderRadius:
                            BorderRadius.all(Radius.circular(Adaptor.px(10.0))),
                        border: Border.all(
                            width: Adaptor.onePx(), color: AppColors.appBorder),
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.appBlackShadow,
                              blurRadius: 5.0,
                              offset: Offset(0, 1.0))
                        ]),
                    child: TextField(
                        decoration: InputDecoration(
                            hintText: '请输入金额',
                            fillColor: Colors.transparent,
                            filled: true,
                            border: InputBorder.none),
                        inputFormatters: [PrecisionLimitFormatter(_precision)],
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        style: TextStyle(
                            fontSize: Adaptor.px(28.0),
                            color: AppColors.appTextDark),
                        focusNode: _limitFocus,
                        cursorWidth: 1.0,
                        cursorColor: AppColors.appTextDark,
                        textAlign: TextAlign.center,
                        controller: _amountController)),
                Container(
                    width: Adaptor.px(1040.0),
                    height: Adaptor.px(80.0),
                    margin: EdgeInsets.only(top: Adaptor.px(20.0)),
                    decoration: BoxDecoration(
                        color: AppColors.appYellow,
                        borderRadius: BorderRadius.all(
                            Radius.circular(Adaptor.px(10.0)))),
                    child: FlatButton(
                        onPressed: _saveLimit,
                        child: Text('保存',
                            style: TextStyle(
                                fontSize: Adaptor.px(32.0),
                                fontWeight: FontWeight.normal,
                                color: AppColors.appTextDark))))
              ],
            )));
  }
}
