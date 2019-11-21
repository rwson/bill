import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bill/adaptor.dart';
import 'package:bill/colors.dart';

class ReminderRuleItem {
  String type;
  String name;
  String desc;

  ReminderRuleItem({this.type, this.name, this.desc});
}

class CreateReminderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CreateReminderState();
}

class CreateReminderState extends State<CreateReminderPage> {
  String _frequencyStr = '请选择';

  String _timeStr = '09:00';

  List<String> _clocks = [
    '00',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23'
  ];

  List<String> _minutes = ['00', '15', '30', '45'];

  List<String> _selectedTime = ['00', '00'];

  List<bool> _frequencies = [];
  List<String> _frequencieStrArr = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];

  int _selectedIndex;

  List<ReminderRuleItem> _rules = [
    ReminderRuleItem(
        type: '1',
        name: '每天递增',
        desc: '每天递增递一元, 如遇当天未存钱, 则下一天继续提醒存当天所需的金额, 到达一定天数后自动折返'),
    ReminderRuleItem(
        type: '2', name: '金额不变', desc: '每天存固定金额, 如遇当天未存钱, 则下一天提醒存入两天需要存的金额之和')
  ];

  ReminderRuleItem _selectedRule;

  @override
  void initState() {
    super.initState();
    _frequencies = [false, false, false, false, false, false, false];
    _frequencyStr = '请选择';
    _timeStr = '09:00';
    _selectedIndex = 0;
  }

  void _frequencySelectOk() {
    List<String> res = [];
    Iterable<int>.generate(_frequencies.length).forEach((int index) {
      bool item = _frequencies[index];
      String str = _frequencieStrArr[index];
      if (item) {
        res.add(str);
      }
    });
    setState(() {
      _frequencyStr = res.join(' ');
    });
    Navigator.of(context).pop();
  }

  void _timeSelectOk() {
    setState(() {
      _timeStr = _selectedTime.join(':');
    });
    Navigator.of(context).pop();
  }

  void _ruleSelectOk() {
    setState(() {
      _selectedRule = _rules[_selectedIndex];
    });
    Navigator.of(context).pop();
  }

  void _frequencySelect(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
            titlePadding: EdgeInsets.only(
                top: Adaptor.px(20.0),
                bottom: 0,
                left: Adaptor.px(20.0),
                right: Adaptor.px(20.0)),
            contentPadding: EdgeInsets.only(
                top: 0,
                bottom: 0,
                left: Adaptor.px(20.0),
                right: Adaptor.px(20.0)),
            title: new Text('选择记账频率',
                style: TextStyle(
                    fontSize: Adaptor.px(32.0),
                    fontWeight: FontWeight.w400,
                    color: AppColors.appTextDark)),
            content:
                new StatefulBuilder(builder: (context, StateSetter setState) {
              return new Container(
                  child: new Wrap(
                children: List.generate(_frequencies.length, (int index) {
                  return new Container(
                    height: Adaptor.px(66.0),
                    child: new CheckboxListTile(
                        title: new Text(_frequencieStrArr[index],
                            style: TextStyle(
                                fontSize: Adaptor.px(28.0),
                                color: AppColors.appTextDark)),
                        activeColor: AppColors.appYellow,
                        value: _frequencies[index],
                        onChanged: (bool value) {
                          setState(() {
                            _frequencies[index] = value;
                          });
                        }),
                  );
                }).toList(),
              ));
            }),
            actions: <Widget>[
              new FlatButton(
                onPressed: _frequencySelectOk,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: new Text('确定',
                    style: TextStyle(
                        fontSize: Adaptor.px(28.0),
                        color: AppColors.appYellow,
                        fontWeight: FontWeight.normal)),
              ),
              new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: new Text('取消',
                      style: TextStyle(
                          fontSize: Adaptor.px(28.0),
                          color: AppColors.appTextDark,
                          fontWeight: FontWeight.normal))),
            ],
          );
        });
  }

  void _timeSelect(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
            titlePadding: EdgeInsets.only(
                top: Adaptor.px(20.0),
                bottom: 0,
                left: Adaptor.px(20.0),
                right: Adaptor.px(20.0)),
            contentPadding: EdgeInsets.only(
                top: 0,
                bottom: 0,
                left: Adaptor.px(20.0),
                right: Adaptor.px(20.0)),
            title: new Text('选择提醒时间',
                style: TextStyle(
                    fontSize: Adaptor.px(32.0),
                    fontWeight: FontWeight.w400,
                    color: AppColors.appTextDark)),
            content:
                new StatefulBuilder(builder: (context, StateSetter setState) {
              return new Container(
                  height: Adaptor.px(350.0),
                  child: new Center(
                      child: new Container(
                          width: Adaptor.px(400.0),
                          height: Adaptor.px(300.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Container(
                                  width: Adaptor.px(180.0),
                                  child: new CupertinoPicker(
                                    itemExtent: Adaptor.px(64.0),
                                    backgroundColor: Colors.white,
                                    onSelectedItemChanged: (int i) {
                                      setState(() {
                                        if (_selectedTime.length >= 1) {
                                          _selectedTime[0] = _clocks[i];
                                        } else {
                                          _selectedTime.add(_clocks[i]);
                                        }
                                      });
                                    },
                                    children: List.generate(_clocks.length,
                                        (int index) {
                                      return new Center(
                                          child: new Text(_clocks[index],
                                              style: TextStyle(
                                                  color: AppColors.appTextDark,
                                                  fontSize: Adaptor.px(32.0),
                                                  fontWeight:
                                                      FontWeight.normal)));
                                    }).toList(),
                                  )),
                              new Container(
                                  width: Adaptor.px(180.0),
                                  child: new CupertinoPicker(
                                    itemExtent: Adaptor.px(64.0),
                                    backgroundColor: Colors.white,
                                    onSelectedItemChanged: (int i) {
                                      setState(() {
                                        if (_selectedTime.length < 2) {
                                          _selectedTime.add(_minutes[i]);
                                        } else {
                                          _selectedTime[1] = _minutes[i];
                                        }
                                      });
                                    },
                                    children: List.generate(_minutes.length,
                                        (int index) {
                                      return new Center(
                                          child: new Text(_minutes[index],
                                              style: TextStyle(
                                                  color: AppColors.appTextDark,
                                                  fontSize: Adaptor.px(32.0),
                                                  fontWeight:
                                                      FontWeight.normal)));
                                    }).toList(),
                                  )),
                            ],
                          ))));
            }),
            actions: <Widget>[
              new FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _timeSelectOk,
                child: new Text('确定',
                    style: TextStyle(
                        fontSize: Adaptor.px(28.0),
                        color: AppColors.appYellow,
                        fontWeight: FontWeight.normal)),
              ),
              new FlatButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: new Text('取消',
                      style: TextStyle(
                          fontSize: Adaptor.px(28.0),
                          color: AppColors.appTextDark,
                          fontWeight: FontWeight.normal))),
            ],
          );
        });
  }

  void _ruleSelect(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
            titlePadding: EdgeInsets.only(
                top: Adaptor.px(20.0),
                bottom: 0,
                left: Adaptor.px(20.0),
                right: Adaptor.px(20.0)),
            contentPadding: EdgeInsets.only(
                top: 0,
                bottom: 0,
                left: Adaptor.px(20.0),
                right: Adaptor.px(20.0)),
            title: new Text('选择存钱规则',
                style: TextStyle(
                    fontSize: Adaptor.px(32.0),
                    fontWeight: FontWeight.w400,
                    color: AppColors.appTextDark)),
            content:
                new StatefulBuilder(builder: (context, StateSetter setState) {
              return new Container(
                  height: Adaptor.px(400.0),
                  margin: EdgeInsets.only(top: Adaptor.px(40.0)),
                  child: new SingleChildScrollView(
                    child: new Wrap(
                        children: List.generate(_rules.length, (int index) {
                      return new Container(
                          child: new RadioListTile(
                              title: new Text(_rules[index].name,
                                  style: TextStyle(
                                      fontSize: Adaptor.px(32.0),
                                      color: AppColors.appTextDark)),
                              subtitle: new Text(_rules[index].desc,
                                  style: TextStyle(
                                      fontSize: Adaptor.px(26.0),
                                      color: AppColors.appTextNormal)),
                              activeColor: AppColors.appYellow,
                              value: index,
                              groupValue: _selectedIndex,
                              onChanged: (int value) {
                                setState(() {
                                  _selectedIndex = value;
                                });
                              }));
                    }).toList()),
                  ));
            }),
            actions: <Widget>[
              new FlatButton(
                onPressed: _ruleSelectOk,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: new Text('确定',
                    style: TextStyle(
                        fontSize: Adaptor.px(28.0),
                        color: AppColors.appYellow,
                        fontWeight: FontWeight.normal)),
              ),
              new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: new Text('取消',
                      style: TextStyle(
                          fontSize: Adaptor.px(28.0),
                          color: AppColors.appTextDark,
                          fontWeight: FontWeight.normal))),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('添加存钱提醒',
                style: TextStyle(
                    fontSize: Adaptor.px(32.0), color: AppColors.appTextDark))),
        body: new Container(
            margin: EdgeInsets.all(Adaptor.px(10.0)),
            padding: EdgeInsets.only(
                left: Adaptor.px(10.0), right: Adaptor.px(10.0)),
            decoration: new BoxDecoration(color: AppColors.appWhite),
            width: Adaptor.px(1060.0),
            child: new Wrap(
              children: <Widget>[
                new Container(
                  width: Adaptor.px(1060.0),
                  height: Adaptor.px(80.0),
                  padding: EdgeInsets.only(
                      left: Adaptor.px(16.0), right: Adaptor.px(16.0)),
                  margin: EdgeInsets.only(
                      left: Adaptor.px(10.0), right: Adaptor.px(10.0)),
                  decoration: new BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: Adaptor.onePx(),
                              color: AppColors.appBorder))),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text('提醒频率',
                          style: TextStyle(
                              color: AppColors.appTextDark,
                              fontSize: Adaptor.px(24.0))),
                      new Expanded(
                          flex: 1,
                          child: new FlatButton(
                              padding: EdgeInsets.all(0),
                              onPressed: () => _frequencySelect(context),
                              child: new Align(
                                  alignment: Alignment.centerRight,
                                  child: new Text(_frequencyStr,
                                      style: TextStyle(
                                          color: AppColors.appTextNormal,
                                          fontSize: Adaptor.px(24.0),
                                          fontWeight: FontWeight.normal)))))
                    ],
                  ),
                ),
                new Container(
                  width: Adaptor.px(1060.0),
                  height: Adaptor.px(80.0),
                  padding: EdgeInsets.only(
                      left: Adaptor.px(16.0), right: Adaptor.px(16.0)),
                  margin: EdgeInsets.only(
                      left: Adaptor.px(10.0), right: Adaptor.px(10.0)),
                  decoration: new BoxDecoration(
                      color: AppColors.appWhite,
                      border: Border(
                          bottom: BorderSide(
                              width: Adaptor.onePx(),
                              color: AppColors.appBorder))),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text('提醒时间',
                          style: TextStyle(
                              color: AppColors.appTextDark,
                              fontSize: Adaptor.px(24.0))),
                      new Expanded(
                          flex: 1,
                          child: new FlatButton(
                              padding: EdgeInsets.all(0),
                              onPressed: () => _timeSelect(context),
                              child: new Align(
                                  alignment: Alignment.centerRight,
                                  child: new Text(_timeStr,
                                      style: TextStyle(
                                          color: AppColors.appTextNormal,
                                          fontSize: Adaptor.px(24.0),
                                          fontWeight: FontWeight.normal)))))
                    ],
                  ),
                ),
                new Container(
                  width: Adaptor.px(1060.0),
                  height: Adaptor.px(80.0),
                  padding: EdgeInsets.only(
                      left: Adaptor.px(16.0), right: Adaptor.px(16.0)),
                  margin: EdgeInsets.only(
                      left: Adaptor.px(10.0), right: Adaptor.px(10.0)),
                  decoration: new BoxDecoration(
                      color: AppColors.appWhite,
                      border: Border(
                          bottom: BorderSide(
                              width: Adaptor.onePx(),
                              color: AppColors.appBorder))),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text('提醒规则',
                          style: TextStyle(
                              color: AppColors.appTextDark,
                              fontSize: Adaptor.px(24.0))),
                      new Expanded(
                          flex: 1,
                          child: new FlatButton(
                              padding: EdgeInsets.all(0),
                              onPressed: () => _ruleSelect(context),
                              child: new Align(
                                  alignment: Alignment.centerRight,
                                  child: new Text(
                                      _selectedRule != null
                                          ? _selectedRule.name
                                          : '请选择',
                                      style: TextStyle(
                                          color: AppColors.appTextNormal,
                                          fontSize: Adaptor.px(24.0),
                                          fontWeight: FontWeight.normal)))))
                    ],
                  ),
                ),
                new Container(
                    width: Adaptor.px(1000.0),
                    height: Adaptor.px(80.0),
                    padding: EdgeInsets.only(
                        left: Adaptor.px(16.0), right: Adaptor.px(16.0)),
                    margin: EdgeInsets.only(
                        top: Adaptor.px(40.0),
                        left: Adaptor.px(10.0),
                        right: Adaptor.px(10.0)),
                    decoration: new BoxDecoration(
                        color: AppColors.appYellow,
                        borderRadius: BorderRadius.all(
                            Radius.circular(Adaptor.px(10.0)))),
                    child: new FlatButton(
                        onPressed: () {},
                        child: new Text('确定',
                            style: TextStyle(
                                fontSize: Adaptor.px(32.0),
                                fontWeight: FontWeight.normal,
                                color: AppColors.appTextDark))))
              ],
            )));
  }
}
