import 'package:bill/adaptor.dart';
import 'package:bill/colors.dart';
import 'package:bill/router.dart';
import 'package:bill/stores/reminder.dart';
import 'package:bill/stores/stores.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        type: '0',
        name: '每天递增',
        desc: '每天递增递一元, 如遇当天未存钱, 则下一天继续提醒存当天所需的金额, 到达一定天数后自动折返'),
    ReminderRuleItem(
        type: '1', name: '金额不变', desc: '每天存固定金额, 如遇当天未存钱, 则下一天提醒存入两天需要存的金额之和')
  ];

  ReminderRuleItem _selectedRule;

  final ReminderStore reminderStore = AppStores.reminderStore;

  final TextEditingController _backController = TextEditingController();

  final FocusNode _backFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _frequencies = [false, false, false, false, false, false, false];
    _frequencyStr = '请选择';
    _timeStr = '09:00';
    _selectedIndex = 0;
  }

  @override
  void dispose() {
    _backController.dispose();
    _backFocus.dispose();

    super.dispose();
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
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Container(
              width: Adaptor.screenW(),
              decoration: BoxDecoration(
                  color: AppColors.appWhite,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Adaptor.px(40.0)),
                      topRight: Radius.circular(Adaptor.px(40.0)))),
              padding: EdgeInsets.only(
                  top: Adaptor.px(40.0),
                  bottom: Adaptor.px(20.0),
                  left: Adaptor.px(10.0)),
              child: Wrap(children: <Widget>[
                Container(
                  child: Center(
                      child: Text('选择提醒频率',
                          style: TextStyle(
                              fontSize: Adaptor.px(32.0),
                              fontWeight: FontWeight.w400,
                              color: AppColors.appTextDark))),
                ),
                Wrap(
                  children: List.generate(_frequencies.length, (int index) {
                    return Container(
                      height: Adaptor.px(68.0),
                      child: CheckboxListTile(
                          title: Text(_frequencieStrArr[index],
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
                ),
                Container(
                    padding: EdgeInsets.only(
                        left: Adaptor.px(30.0), right: Adaptor.px(46.0)),
                    margin: EdgeInsets.only(top: Adaptor.px(30.0)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () => {Navigator.of(context).pop()},
                            child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.sheetBtnBg,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(Adaptor.px(45.0)))),
                                width: Adaptor.px(280.0),
                                height: Adaptor.px(90.0),
                                child: Center(
                                    child: Text(
                                  '取消',
                                  style: TextStyle(
                                      fontSize: Adaptor.px(32.0),
                                      color: AppColors.appDanger),
                                ))),
                          ),
                          GestureDetector(
                            onTap: _frequencySelectOk,
                            child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.sheetBtnBg,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(Adaptor.px(45.0)))),
                                width: Adaptor.px(280.0),
                                height: Adaptor.px(90.0),
                                child: Center(
                                    child: Text(
                                  '确定',
                                  style: TextStyle(
                                      fontSize: Adaptor.px(32.0),
                                      color: AppColors.appWarning),
                                ))),
                          )
                        ]))
              ]));
        });
      },
    );
  }

  void _timeSelect(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
                width: Adaptor.screenW(),
                decoration: BoxDecoration(
                    color: AppColors.appWhite,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Adaptor.px(40.0)),
                        topRight: Radius.circular(Adaptor.px(40.0)))),
                padding: EdgeInsets.only(
                    top: Adaptor.px(40.0),
                    bottom: Adaptor.px(20.0),
                    left: Adaptor.px(10.0)),
                child: Wrap(children: <Widget>[
                  Container(
                    child: Center(
                        child: Text('选择提醒时间',
                            style: TextStyle(
                                fontSize: Adaptor.px(32.0),
                                fontWeight: FontWeight.w400,
                                color: AppColors.appTextDark))),
                  ),
                  Container(
                      height: Adaptor.px(350.0),
                      child: Center(
                          child: Container(
                              width: Adaptor.px(400.0),
                              height: Adaptor.px(300.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                      width: Adaptor.px(180.0),
                                      child: CupertinoPicker(
                                        looping: true,
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
                                          return Center(
                                              child: Text(_clocks[index],
                                                  style: TextStyle(
                                                      color:
                                                          AppColors.appTextDark,
                                                      fontSize:
                                                          Adaptor.px(32.0),
                                                      fontWeight:
                                                          FontWeight.normal)));
                                        }).toList(),
                                      )),
                                  Container(
                                      width: Adaptor.px(180.0),
                                      child: CupertinoPicker(
                                        looping: true,
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
                                          return Center(
                                              child: Text(_minutes[index],
                                                  style: TextStyle(
                                                      color:
                                                          AppColors.appTextDark,
                                                      fontSize:
                                                          Adaptor.px(32.0),
                                                      fontWeight:
                                                          FontWeight.normal)));
                                        }).toList(),
                                      )),
                                ],
                              )))),
                  Container(
                      padding: EdgeInsets.only(
                          left: Adaptor.px(30.0), right: Adaptor.px(46.0)),
                      margin: EdgeInsets.only(top: Adaptor.px(30.0)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () => {Navigator.of(context).pop()},
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.sheetBtnBg,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(Adaptor.px(45.0)))),
                                  width: Adaptor.px(280.0),
                                  height: Adaptor.px(90.0),
                                  child: Center(
                                      child: Text(
                                    '取消',
                                    style: TextStyle(
                                        fontSize: Adaptor.px(32.0),
                                        color: AppColors.appDanger),
                                  ))),
                            ),
                            GestureDetector(
                              onTap: _timeSelectOk,
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.sheetBtnBg,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(Adaptor.px(45.0)))),
                                  width: Adaptor.px(280.0),
                                  height: Adaptor.px(90.0),
                                  child: Center(
                                      child: Text(
                                    '确定',
                                    style: TextStyle(
                                        fontSize: Adaptor.px(32.0),
                                        color: AppColors.appWarning),
                                  ))),
                            )
                          ]))
                ]));
          });
        });
  }

  void _ruleSelect(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Container(
              width: Adaptor.screenW(),
              decoration: BoxDecoration(
                  color: AppColors.appWhite,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Adaptor.px(40.0)),
                      topRight: Radius.circular(Adaptor.px(40.0)))),
              padding: EdgeInsets.only(
                  top: Adaptor.px(40.0),
                  bottom: Adaptor.px(20.0),
                  left: Adaptor.px(10.0)),
              child: Wrap(children: <Widget>[
                Container(
                  child: Center(
                      child: Text('选择存钱规则',
                          style: TextStyle(
                              fontSize: Adaptor.px(32.0),
                              fontWeight: FontWeight.w400,
                              color: AppColors.appTextDark))),
                ),
                Wrap(
                    children: List.generate(_rules.length, (int index) {
                  return Container(
                      child: RadioListTile(
                          title: Text(_rules[index].name,
                              style: TextStyle(
                                  fontSize: Adaptor.px(32.0),
                                  color: AppColors.appTextDark)),
                          subtitle: Text(_rules[index].desc,
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
                Container(
                    padding: EdgeInsets.only(
                        left: Adaptor.px(30.0), right: Adaptor.px(46.0)),
                    margin: EdgeInsets.only(top: Adaptor.px(30.0)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () => {Navigator.of(context).pop()},
                            child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.sheetBtnBg,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(Adaptor.px(45.0)))),
                                width: Adaptor.px(280.0),
                                height: Adaptor.px(90.0),
                                child: Center(
                                    child: Text(
                                  '取消',
                                  style: TextStyle(
                                      fontSize: Adaptor.px(32.0),
                                      color: AppColors.appDanger),
                                ))),
                          ),
                          GestureDetector(
                            onTap: _ruleSelectOk,
                            child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.sheetBtnBg,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(Adaptor.px(45.0)))),
                                width: Adaptor.px(280.0),
                                height: Adaptor.px(90.0),
                                child: Center(
                                    child: Text(
                                  '确定',
                                  style: TextStyle(
                                      fontSize: Adaptor.px(32.0),
                                      color: AppColors.appWarning),
                                ))),
                          )
                        ]))
              ]));
        });
      },
    );
  }

  Future<void> _createReminder() async {
    List<int> frequency = [];

    int len = _frequencies.length;
    bool item;

    for (int i = 0; i < len; i++) {
      item = _frequencies[i];

      if (item) {
        frequency.add(i + 1);
      }
    }

    bool createSuccess = await reminderStore.createReminder({
      'frequency': frequency.join('-'),
      'time': _timeStr,
      'rule': _selectedRule.type,
      'back': int.parse(_backController.text)
    });

    if (createSuccess) {
      AppRouter.back(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('添加存钱提醒',
                style: TextStyle(
                    fontSize: Adaptor.px(32.0), color: AppColors.appTextDark))),
        body: Container(
            margin: EdgeInsets.all(Adaptor.px(10.0)),
            padding: EdgeInsets.only(
                left: Adaptor.px(10.0), right: Adaptor.px(10.0)),
            decoration: BoxDecoration(color: AppColors.appWhite),
            width: Adaptor.px(1060.0),
            child: Wrap(
              children: <Widget>[
                Container(
                  width: Adaptor.px(1060.0),
                  height: Adaptor.px(100.0),
                  padding: EdgeInsets.only(
                      left: Adaptor.px(16.0), right: Adaptor.px(16.0)),
                  margin: EdgeInsets.only(
                      left: Adaptor.px(10.0), right: Adaptor.px(10.0)),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: Adaptor.onePx(),
                              color: AppColors.appBorder))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('提醒频率',
                          style: TextStyle(
                              color: AppColors.appTextDark,
                              fontSize: Adaptor.px(28.0))),
                      Expanded(
                          flex: 1,
                          child: FlatButton(
                              padding: EdgeInsets.all(0),
                              onPressed: () => _frequencySelect(context),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(_frequencyStr,
                                      style: TextStyle(
                                          color: AppColors.appTextNormal,
                                          fontSize: Adaptor.px(28.0),
                                          fontWeight: FontWeight.normal)))))
                    ],
                  ),
                ),
                Container(
                  width: Adaptor.px(1060.0),
                  height: Adaptor.px(100.0),
                  padding: EdgeInsets.only(
                      left: Adaptor.px(16.0), right: Adaptor.px(16.0)),
                  margin: EdgeInsets.only(
                      left: Adaptor.px(10.0), right: Adaptor.px(10.0)),
                  decoration: BoxDecoration(
                      color: AppColors.appWhite,
                      border: Border(
                          bottom: BorderSide(
                              width: Adaptor.onePx(),
                              color: AppColors.appBorder))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('提醒时间',
                          style: TextStyle(
                              color: AppColors.appTextDark,
                              fontSize: Adaptor.px(28.0))),
                      Expanded(
                          flex: 1,
                          child: FlatButton(
                              padding: EdgeInsets.all(0),
                              onPressed: () => _timeSelect(context),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(_timeStr,
                                      style: TextStyle(
                                          color: AppColors.appTextNormal,
                                          fontSize: Adaptor.px(28.0),
                                          fontWeight: FontWeight.normal)))))
                    ],
                  ),
                ),
                Container(
                  width: Adaptor.px(1060.0),
                  height: Adaptor.px(100.0),
                  padding: EdgeInsets.only(
                      left: Adaptor.px(16.0), right: Adaptor.px(16.0)),
                  margin: EdgeInsets.only(
                      left: Adaptor.px(10.0), right: Adaptor.px(10.0)),
                  decoration: BoxDecoration(
                      color: AppColors.appWhite,
                      border: Border(
                          bottom: BorderSide(
                              width: Adaptor.onePx(),
                              color: AppColors.appBorder))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('提醒规则',
                          style: TextStyle(
                              color: AppColors.appTextDark,
                              fontSize: Adaptor.px(28.0))),
                      Expanded(
                          flex: 1,
                          child: FlatButton(
                              padding: EdgeInsets.all(0),
                              onPressed: () => _ruleSelect(context),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                      _selectedRule != null
                                          ? _selectedRule.name
                                          : '请选择',
                                      style: TextStyle(
                                          color: AppColors.appTextNormal,
                                          fontSize: Adaptor.px(28.0),
                                          fontWeight: FontWeight.normal)))))
                    ],
                  ),
                ),
                (_selectedRule != null && _selectedRule.type == '0')
                    ? Container(
                        width: Adaptor.px(1060.0),
                        height: Adaptor.px(100.0),
                        padding: EdgeInsets.only(
                            left: Adaptor.px(16.0), right: Adaptor.px(16.0)),
                        margin: EdgeInsets.only(
                            left: Adaptor.px(10.0), right: Adaptor.px(10.0)),
                        decoration: BoxDecoration(
                            color: AppColors.appWhite,
                            border: Border(
                                bottom: BorderSide(
                                    width: Adaptor.onePx(),
                                    color: AppColors.appBorder))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('回头天数',
                                style: TextStyle(
                                    color: AppColors.appTextDark,
                                    fontSize: Adaptor.px(28.0))),
                            Expanded(
                                flex: 1,
                                child: TextField(
                                    controller: _backController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter.digitsOnly
                                    ],
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        color: AppColors.appTextNormal,
                                        fontSize: Adaptor.px(28.0),
                                        fontWeight: FontWeight.normal),
                                    focusNode: _backFocus,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          top: Adaptor.px(30.0),
                                          bottom: Adaptor.px(30.0)),
                                      hintText: '请输入回头天数',
                                      fillColor: AppColors.appWhite,
                                      filled: true,
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide.none),
                                    )))
                          ],
                        ),
                      )
                    : Container(),
                GestureDetector(
                  onTap: _createReminder,
                  child: Container(
                    width: Adaptor.px(1000.0),
                    height: Adaptor.px(80.0),
                    padding: EdgeInsets.only(
                        left: Adaptor.px(16.0), right: Adaptor.px(16.0)),
                    margin: EdgeInsets.only(
                        top: Adaptor.px(40.0),
                        left: Adaptor.px(10.0),
                        right: Adaptor.px(10.0)),
                    decoration: BoxDecoration(
                        color: AppColors.appYellow,
                        borderRadius: BorderRadius.all(
                            Radius.circular(Adaptor.px(10.0)))),
                    child: Center(
                        child: Text('确定',
                            style: TextStyle(
                                fontSize: Adaptor.px(30.0),
                                fontWeight: FontWeight.normal,
                                color: AppColors.appTextDark))))
                )
              ],
            )));
  }
}
