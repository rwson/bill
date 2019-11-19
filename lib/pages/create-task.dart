import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../adaptor.dart';
import '../colors.dart';
import '../iconfont.dart';
import '../router.dart';
import '../util.dart';

class CreateTaskPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CreateTaskState();
}

class CreateTaskState extends State<CreateTaskPage> {

  final int _precision = 2;

  final _amountController = TextEditingController();

  final _descontroller = TextEditingController();

  bool _switchValue = false;

  List<bool> _frequencies = [
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descontroller.dispose();
    super.dispose();
  }

  void _frequencySelect(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
            titlePadding: EdgeInsets.all(10.0),
            contentPadding: EdgeInsets.all(10.0),
            title: new Text(
              '选择记账频率',
              style: TextStyle(
                fontSize: Adaptor.px(28.0),
                fontWeight: FontWeight.w400,
                color: AppColors.appTextDark
              )
            ),
            content: new StatefulBuilder(
                builder: (context, StateSetter setState) {
                 return new Container(
                     child: new Wrap(
                       children: <Widget>[
                       ],
                     )
                 );
                }
            ),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: new Text("确认"),
              ),
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: new Text("取消"),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('添加记账任务',
                style: TextStyle(
                    fontSize: Adaptor.px(32.0), color: AppColors.appTextDark))),
        body: new Container(
            margin: EdgeInsets.all(Adaptor.px(10.0)),
            width: Adaptor.px(1060.0),
            child: new Wrap(
              children: <Widget>[
                new Container(
                  width: Adaptor.px(1060.0),
                  height: Adaptor.px(80.0),
                  padding: EdgeInsets.only(
                      left: Adaptor.px(16.0), right: Adaptor.px(16.0)),
                  margin: EdgeInsets.only(left: Adaptor.px(10.0), right: Adaptor.px(10.0)),
                  decoration: new BoxDecoration(
                    color: AppColors.appWhite,
                    border: Border(
                      bottom: BorderSide(
                        width: Adaptor.onePx(),
                        color: AppColors.appBorder
                      )
                    )
                  ),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text('记账频率', style: TextStyle(
                        color: AppColors.appTextDark,
                        fontSize: Adaptor.px(24.0)
                      )),
                      new Expanded(
                        flex: 1,
                        child: new FlatButton(
                            padding: EdgeInsets.all(0),
                            onPressed: () => _frequencySelect(context),
                            child: new Align(
                            alignment: Alignment.centerRight,
                            child: new Text('工作日', style: TextStyle(
                                color: AppColors.appTextNormal,
                                fontSize: Adaptor.px(24.0),
                                fontWeight: FontWeight.normal
                            ))
                        )
                        )
                      )
                    ],
                  ),
                ),
                new Container(
                  width: Adaptor.px(1060.0),
                  height: Adaptor.px(80.0),
                  padding: EdgeInsets.only(
                      left: Adaptor.px(16.0), right: Adaptor.px(16.0)),
                  margin: EdgeInsets.only(left: Adaptor.px(10.0), right: Adaptor.px(10.0)),
                  decoration: new BoxDecoration(
                      color: AppColors.appWhite,
                      border: Border(
                          bottom: BorderSide(
                              width: Adaptor.onePx(),
                              color: AppColors.appBorder
                          )
                      )
                  ),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text('记账时间', style: TextStyle(
                          color: AppColors.appTextDark,
                          fontSize: Adaptor.px(24.0)
                      )),
                      new Expanded(
                          flex: 1,
                          child: new FlatButton(
                              padding: EdgeInsets.all(0),
                              onPressed: () {},
                              child: new Align(
                                  alignment: Alignment.centerRight,
                                  child: new Text('09:00', style: TextStyle(
                                      color: AppColors.appTextNormal,
                                      fontSize: Adaptor.px(24.0),
                                      fontWeight: FontWeight.normal
                                  ))
                              )
                          )
                      )
                    ],
                  ),
                ),
                new Container(
                  width: Adaptor.px(1060.0),
                  height: Adaptor.px(80.0),
                  padding: EdgeInsets.only(
                      left: Adaptor.px(16.0), right: Adaptor.px(16.0)),
                  margin: EdgeInsets.only(left: Adaptor.px(10.0), right: Adaptor.px(10.0)),
                  decoration: new BoxDecoration(
                      color: AppColors.appWhite,
                      border: Border(
                          bottom: BorderSide(
                              width: Adaptor.onePx(),
                              color: AppColors.appBorder
                          )
                      )
                  ),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text('记账金额', style: TextStyle(
                          color: AppColors.appTextDark,
                          fontSize: Adaptor.px(24.0)
                      )),
                      new Expanded(
                          flex: 1,
                          child: new Container(
                            child: new TextField(
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(right: Adaptor.px(6.0)),
                                    hintText: '请输入金额',
                                    fillColor: Colors.transparent,
                                    filled: true,
                                    border: InputBorder.none
                                ),
                                inputFormatters: [PrecisionLimitFormatter(_precision)],
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                                style: TextStyle(
                                  fontSize: Adaptor.px(24.0),
                                  color: AppColors.appTextDark,
                                ),
                                cursorWidth: 1.0,
                                cursorColor: AppColors.appTextDark,
                                textAlign: TextAlign.right,
                                controller: _amountController
                            )
                          )
                      )
                    ],
                  ),
                ),
                new Container(
                  width: Adaptor.px(1060.0),
                  height: Adaptor.px(80.0),
                  padding: EdgeInsets.only(
                      left: Adaptor.px(16.0), right: Adaptor.px(16.0)),
                  margin: EdgeInsets.only(left: Adaptor.px(10.0), right: Adaptor.px(10.0)),
                  decoration: new BoxDecoration(
                      color: AppColors.appWhite,
                      border: Border(
                          bottom: BorderSide(
                              width: Adaptor.onePx(),
                              color: AppColors.appBorder
                          )
                      )
                  ),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text('账单备注', style: TextStyle(
                          color: AppColors.appTextDark,
                          fontSize: Adaptor.px(24.0)
                      )),
                      new Expanded(
                          flex: 1,
                          child: new Container(
                              child: new TextField(
                                  maxLength: 20,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(right: Adaptor.px(6.0)),
                                      hintText: '请输入备注',
                                      fillColor: Colors.transparent,
                                      filled: true,
                                      border: InputBorder.none
                                  ),
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(
                                    fontSize: Adaptor.px(24.0),
                                    color: AppColors.appTextDark,
                                  ),
                                  cursorWidth: 1.0,
                                  cursorColor: AppColors.appTextDark,
                                  textAlign: TextAlign.right,
                                  controller: _descontroller
                              )
                          )
                      )
                    ],
                  ),
                ),
                new Container(
                  width: Adaptor.px(1060.0),
                  height: Adaptor.px(80.0),
                  padding: EdgeInsets.only(
                      left: Adaptor.px(16.0), right: Adaptor.px(16.0)),
                  margin: EdgeInsets.only(left: Adaptor.px(10.0), right: Adaptor.px(10.0)),
                  decoration: new BoxDecoration(
                      color: AppColors.appWhite,
                      border: Border(
                          bottom: BorderSide(
                              width: Adaptor.onePx(),
                              color: AppColors.appBorder
                          )
                      )
                  ),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text('是否确认', style: TextStyle(
                          color: AppColors.appTextDark,
                          fontSize: Adaptor.px(24.0)
                      )),
                      new Container(
                          child: new Switch.adaptive(
                              value: _switchValue,
                              activeColor: AppColors.appGreen,
                              activeTrackColor: AppColors.appGreenLight,
                              inactiveThumbColor: AppColors.appOutlay,
                              inactiveTrackColor: AppColors.appOutlayLight,
                              onChanged: (bool value) {
                                setState(() {
                                  _switchValue = value;
                                });
                              }
                          )
                      )
                    ],
                  ),
                ),
                new Container(
                  child: new CheckboxListTile(
                      value: _frequencies[0],
                      title: new Text('星期一'),
                      activeColor: Colors.red,
                      onChanged: (bool value) {
                        setState(() {
                          _frequencies[0] = value;
                        });
                      }
                  )
                )
//                new CheckboxListTile(
//                    value: _frequencies[1],
//                    title: new Text('星期二'),
//                    activeColor: Colors.red,
//                    onChanged: (bool value) {
//                      setState(() {
//                        _frequencies[1] = value;
//                      });
//                    }
//                ),
//                new CheckboxListTile(
//                    value: _frequencies[2],
//                    title: new Text('星期三'),
//                    activeColor: Colors.red,
//                    onChanged: (bool value) {
//                      setState(() {
//                        _frequencies[2] = value;
//                      });
//                    }
//                ),
              ],
            )
        )
    );
  }
}
