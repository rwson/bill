import 'package:bill/adaptor.dart';
import 'package:bill/bean/group.dart';
import 'package:bill/bean/task.dart';
import 'package:bill/colors.dart';
import 'package:bill/methods-icons.dart';
import 'package:bill/pay-channels.dart';
import 'package:bill/router.dart';
import 'package:bill/stores/group.dart';
import 'package:bill/stores/stores.dart';
import 'package:bill/stores/task.dart';
import 'package:bill/util.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MethodItem {
  IconData icon;
  String desc;
  String type;

  MethodItem({this.icon, this.desc, this.type});
}

class EditTaskPage extends StatefulWidget {
  EditTaskPage({
    @required this.id
  });

  final String id;

  @override
  State<StatefulWidget> createState() => EditTaskState();
}

class EditTaskState extends State<EditTaskPage> {
  final int _precision = 2;

  final TextEditingController _amountController = TextEditingController();

  final FocusNode _amountFocus = FocusNode();

  final TextEditingController _descController = TextEditingController();

  final FocusNode _descFocus = FocusNode();

  final GroupStore groupStore = AppStores.groupStote;

  final TaskStore taskStore = AppStores.taskStore;

  FixedExtentScrollController _clockController;

  FixedExtentScrollController _minutesController;

  List<GroupItem> _groups = [];

  GroupItem _groupItem;

  int _groupIndex;

  bool _switchValue = false;

  String _frequencyStr = '请选择';

  String _groupStr = '';

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

  List<IconItem> _types = List.from(MethodsIcons.paymentIcons);

  IconItem _selectedType;

  int _payChannelIndex = 0;

  List<ChannelItem> _payChannels = List.from(PayChannels.payChannels);

  ChannelItem _selectedChannel = PayChannels.payChannels[0];

  @override
  void initState() {
    super.initState();
    _frequencies = [false, false, false, false, false, false, false];
    _frequencyStr = '请选择';
    _timeStr = '09:00';
    _selectedIndex = 0;
    _selectedType = _types[_selectedIndex];

    _getDetail();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descController.dispose();
    _amountFocus.dispose();
    _descFocus.dispose();
    super.dispose();
  }

  void _initGroups() async {
    bool querySuccess = await groupStore.queryGroups();

    if (querySuccess) {
      int _storeGroupsLength = groupStore.groups.length;
      GroupItem _tmp;
      for (var i = 0; i < _storeGroupsLength; i++) {
        _tmp = groupStore.groups[i];
        if (_tmp.isDefault == '1') {
          setState(() {
            _groupIndex = i;
            _groupItem = _tmp;
            _groupStr = _groupItem.name;
          });
        }
        _groups.add(_tmp);
      }
    } else {
      BotToast.showText(text: '查询记账圈子失败!');
      AppRouter.back(context);
    }
  }

  void _getDetail() async {
    await _initGroups();

    bool querySuccess = await taskStore.getDetail(widget.id);

    if (querySuccess) {
      TaskItem current = taskStore.current;

      _amountController.text = double.parse(current.amount).toStringAsFixed(2);
      _descController.text = current.remark;

      setState(() {
        _selectedTime = current.time.split(':');
        _timeStr = current.time;

        _frequencyStr = Util.frenquency2Weekday(current.frequency);
        current.frequency.split('-').toList().forEach((String index) {
          _frequencies[int.parse(index) - 1] = true;
        });

        for (int i = 0, length = _payChannels.length; i < length; i ++) {
          ChannelItem _tmp = _payChannels[i];
          if (_tmp.type == current.payMethod) {
            _selectedChannel = _tmp;
            _payChannelIndex = i;
            break;
          }
        }

        for (int i = 0, length = _types.length; i < length; i ++) {
          IconItem _tmp = _types[i];
          if (_tmp.type == current.category) {
            _selectedType = _tmp;
            _selectedIndex = i;
            break;
          }
        }

        _switchValue = current.confirm == '1';
      });

      _clockController =
        FixedExtentScrollController(initialItem: _clocks.indexOf(_selectedTime[0]));
      _minutesController =
        FixedExtentScrollController(initialItem: _clocks.indexOf(_selectedTime[1]));


    } else {
      AppRouter.back(context);
    }
  }

  void _unFocus() {
    _amountFocus.unfocus();
    _descFocus.unfocus();
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

  void _typeSelectOk() {
    setState(() {
      _selectedType = _types[_selectedIndex];
    });
    Navigator.of(context).pop();
  }

  void _frequencySelect(BuildContext context) {
    _unFocus();
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
                      child: Text('选择记账频率',
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
    _unFocus();
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
                                        scrollController: _clockController,
                                        onSelectedItemChanged: (int i) {
                                          setState(() {
                                            if (_selectedTime.length >= 1) {
                                              _selectedTime[0] = _clocks[i];
                                            } else {
                                              _selectedTime.add(_clocks[i]);
                                            }
                                          });

                                          _clockController =
                                              FixedExtentScrollController(
                                                  initialItem: _clocks
                                                      .indexOf(_clocks[i]));
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
                                        scrollController: _minutesController,
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
                                          _minutesController =
                                              FixedExtentScrollController(
                                                  initialItem: _minutes
                                                      .indexOf(_minutes[i]));
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

  void _groupSelectOk() {
    setState(() {
      _groupItem = _groups[_groupIndex];
      _groupStr = _groupItem.name;
    });
    Navigator.of(context).pop();
  }

  void _groupSelect(BuildContext context) {
    _unFocus();
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
                      child: Text('选择记账圈子',
                          style: TextStyle(
                              fontSize: Adaptor.px(32.0),
                              fontWeight: FontWeight.w400,
                              color: AppColors.appTextDark))),
                ),
                Container(
                  height: Adaptor.px(450),
                  child: SingleChildScrollView(
                      child: Wrap(
                          children: List.generate(_groups.length, (int index) {
                    return Container(
                        child: RadioListTile(
                            title: Text(_groups[index].name,
                                style: TextStyle(
                                    fontSize: Adaptor.px(32.0),
                                    color: AppColors.appTextDark)),
                            activeColor: AppColors.appYellow,
                            value: index,
                            groupValue: _groupIndex,
                            onChanged: (int value) {
                              setState(() {
                                _groupIndex = value;
                              });
                            }));
                  }).toList())),
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
                            onTap: _groupSelectOk,
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

  void _typeSelect(BuildContext context) {
    _unFocus();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Container(
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
                      child: Text('选择账单分类',
                          style: TextStyle(
                              fontSize: Adaptor.px(32.0),
                              fontWeight: FontWeight.w400,
                              color: AppColors.appTextDark))),
                ),
                Container(
                  height: Adaptor.px(450.0),
                  child: SingleChildScrollView(
                      child: Wrap(
                          children: List.generate(_types.length, (int index) {
                    return Container(
                        child: RadioListTile(
                            title: Text(_types[index].desc,
                                style: TextStyle(
                                    fontSize: Adaptor.px(32.0),
                                    color: AppColors.appTextDark)),
                            activeColor: AppColors.appYellow,
                            value: index,
                            groupValue: _selectedIndex,
                            onChanged: (int value) {
                              setState(() {
                                _selectedIndex = value;
                              });
                            }));
                  }).toList())),
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
                            onTap: _typeSelectOk,
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

  void _payMethodSelectOk() {
    setState(() {
      _selectedChannel = _payChannels[_payChannelIndex];
    });
    Navigator.of(context).pop();
  }

  void _payMethodSelect(BuildContext context) {
    _unFocus();
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
                      child: Text('选择付款方式',
                          style: TextStyle(
                              fontSize: Adaptor.px(32.0),
                              fontWeight: FontWeight.w400,
                              color: AppColors.appTextDark))),
                ),
                Wrap(
                    children: List.generate(_payChannels.length, (int index) {
                  return Container(
                      child: RadioListTile(
                          title: Text(_payChannels[index].desc,
                              style: TextStyle(
                                  fontSize: Adaptor.px(32.0),
                                  color: AppColors.appTextDark)),
                          activeColor: AppColors.appYellow,
                          value: index,
                          groupValue: _payChannelIndex,
                          onChanged: (int value) {
                            setState(() {
                              _payChannelIndex = value;
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
                            onTap: _payMethodSelectOk,
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

  void _editTask() async {
    List<int> frequency = [];

    int len = _frequencies.length;
    bool item;

    for (int i = 0; i < len; i++) {
      item = _frequencies[i];

      if (item) {
        frequency.add(i + 1);
      }
    }

    if (frequency.length == 0) {
      BotToast.showText(text: '请选择记账频率');
      return;
    }

    if (_amountController.text.length == 0) {
      BotToast.showText(text: '请输入账单金额');
      return;
    }

    double amount = double.parse(_amountController.text);

    Map<String, dynamic> task = {
      'frequency': frequency.join('-'),
      'time': _timeStr,
      'amount': amount,
      'billType': '0',
      'category': _selectedType.type,
      'remark': _descController.text,
      'confirm': _switchValue ? '1' : '0',
      'groupId': _groupItem.id,
      'payMethod': _selectedChannel.type,
      'id': widget.id
    };

    bool updateSuccess = await taskStore.updateTask(task);

    if (updateSuccess) {
      AppRouter.back(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('编辑记账任务',
                style: TextStyle(
                    fontSize: Adaptor.px(32.0), color: AppColors.appTextDark))),
        body: SingleChildScrollView(
            child: Container(
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
                          Text('记账频率',
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
                          Text('记账时间',
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
                          Text('记账金额',
                              style: TextStyle(
                                  color: AppColors.appTextDark,
                                  fontSize: Adaptor.px(28.0))),
                          Expanded(
                              flex: 1,
                              child: Container(
                                  child: TextField(
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              right: Adaptor.px(6.0)),
                                          hintText: '请输入金额',
                                          fillColor: Colors.transparent,
                                          filled: true,
                                          border: InputBorder.none),
                                      inputFormatters: [
                                        PrecisionLimitFormatter(_precision)
                                      ],
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      style: TextStyle(
                                        fontSize: Adaptor.px(28.0),
                                        color: AppColors.appTextNormal,
                                      ),
                                      cursorWidth: 1.0,
                                      cursorColor: AppColors.appTextDark,
                                      textAlign: TextAlign.right,
                                      focusNode: _amountFocus,
                                      controller: _amountController)))
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
                          Text('账单分类',
                              style: TextStyle(
                                  color: AppColors.appTextDark,
                                  fontSize: Adaptor.px(28.0))),
                          Expanded(
                              flex: 1,
                              child: FlatButton(
                                  padding: EdgeInsets.all(0),
                                  onPressed: () => _typeSelect(context),
                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                          _selectedType != null
                                              ? _selectedType.desc
                                              : '请选择',
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
                          border: Border(
                              bottom: BorderSide(
                                  width: Adaptor.onePx(),
                                  color: AppColors.appBorder))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('记账圈子',
                              style: TextStyle(
                                  color: AppColors.appTextDark,
                                  fontSize: Adaptor.px(28.0))),
                          Expanded(
                              flex: 1,
                              child: FlatButton(
                                  padding: EdgeInsets.all(0),
                                  onPressed: () => _groupSelect(context),
                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(_groupStr,
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
                          border: Border(
                              bottom: BorderSide(
                                  width: Adaptor.onePx(),
                                  color: AppColors.appBorder))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('支付方式',
                              style: TextStyle(
                                  color: AppColors.appTextDark,
                                  fontSize: Adaptor.px(28.0))),
                          Expanded(
                              flex: 1,
                              child: FlatButton(
                                  padding: EdgeInsets.all(0),
                                  onPressed: () => _payMethodSelect(context),
                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                          _selectedChannel != null
                                              ? _selectedChannel.desc
                                              : '请选择付款方式',
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
                          Text('账单备注',
                              style: TextStyle(
                                  color: AppColors.appTextDark,
                                  fontSize: Adaptor.px(28.0))),
                          Expanded(
                              flex: 1,
                              child: Container(
                                  child: TextField(
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              right: Adaptor.px(6.0)),
                                          hintText: '请输入备注',
                                          fillColor: Colors.transparent,
                                          filled: true,
                                          border: InputBorder.none),
                                      keyboardType: TextInputType.text,
                                      style: TextStyle(
                                        fontSize: Adaptor.px(28.0),
                                        color: AppColors.appTextNormal,
                                      ),
                                      cursorWidth: 1.0,
                                      cursorColor: AppColors.appTextDark,
                                      textAlign: TextAlign.right,
                                      focusNode: _descFocus,
                                      controller: _descController)))
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
                          Text('是否确认',
                              style: TextStyle(
                                  color: AppColors.appTextDark,
                                  fontSize: Adaptor.px(28.0))),
                          Container(
                              child: Switch.adaptive(
                                  value: _switchValue,
                                  activeColor: AppColors.appYellow,
                                  activeTrackColor: AppColors.appYellowLight,
                                  inactiveThumbColor: AppColors.appTextNormal,
                                  inactiveTrackColor: AppColors.appTextLight,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _switchValue = value;
                                    });
                                  }))
                        ],
                      ),
                    ),
                    GestureDetector(
                        onTap: _editTask,
                        child: Container(
                            width: Adaptor.px(1000.0),
                            height: Adaptor.px(100.0),
                            padding: EdgeInsets.only(
                                left: Adaptor.px(16.0),
                                right: Adaptor.px(16.0)),
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
                                        fontSize: Adaptor.px(32.0),
                                        fontWeight: FontWeight.normal,
                                        color: AppColors.appTextDark)))))
                  ],
                ))));
  }
}
