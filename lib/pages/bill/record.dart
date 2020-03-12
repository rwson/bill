import 'dart:math';

import 'package:bill/adaptor.dart';
import 'package:bill/bean/group.dart';
import 'package:bill/colors.dart';
import 'package:bill/methods-icons.dart';
import 'package:bill/pay-channels.dart';
import 'package:bill/router.dart';
import 'package:bill/stores/bill.dart';
import 'package:bill/stores/group.dart';
import 'package:bill/stores/stores.dart';
import 'package:bill/util.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_daydart/flutter_daydart.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class TypeItem {
  String type;
  IconData icon;
  String desc;
  bool checked;

  TypeItem({this.icon, this.type, this.desc, this.checked});
}

class RecordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RecordState();
}

class RecordState extends State<RecordPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  final TextEditingController _paymentInputController = TextEditingController();

  final FocusNode _paymentInputFocus = FocusNode();

  final TextEditingController _incomeInputController = TextEditingController();

  final FocusNode _incomeInputFocus = FocusNode();

  final TextEditingController _payMarkController = TextEditingController();

  final FocusNode _payMarkFocus = FocusNode();

  final TextEditingController _incomeMarkController = TextEditingController();

  final FocusNode _incomeMarkFocus = FocusNode();

  Color _mainColor = AppColors.appYellow;

  int _currentIndex = 0;

  int _selectedIndex = 0;

  int _payChannelIndex = 0;

  ChannelItem _selectedChannel = PayChannels.payChannels[0];

  List<TypeItem> _payTypes = [];

  List<TypeItem> _incomeTypes = [];

  List<ChannelItem> _payChannels = List.from(PayChannels.payChannels);

  List<GroupItem> _groups = [];

  GroupItem _groupItem;

  int _groupIndex;

  final int _precision = 2;

  String _currentType = 'pay';

  String _billDate = DayDart().format(fm: 'YYYY-MM-DD');

  final BillStore billStote = AppStores.billStore;
  final GroupStore groupStore = AppStores.groupStote;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 2);
    _tabController..addListener(_handleTabChange);

    _initGroups();

    MethodsIcons.paymentIcons.forEach((item) {
      _payTypes.add(TypeItem(
          icon: item.icon, type: item.type, desc: item.desc, checked: false));
    });

    MethodsIcons.incomeIcons.forEach((item) {
      _incomeTypes.add(TypeItem(
          icon: item.icon, type: item.type, desc: item.desc, checked: false));
    });
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
          });
        }
        _groups.add(_tmp);
      }
    } else {
      BotToast.showText(text: '查询记账圈子失败!');
      AppRouter.back(context);
    }
  }

  void _handleTabChange() {
    _unFocus();
    if (_tabController.indexIsChanging) {
      setState(() {
        _currentIndex = _tabController.index;
        _mainColor = (_tabController.index == 0)
            ? AppColors.appYellow
            : AppColors.appGreen;

        FlutterStatusbarManager.setColor(_mainColor);

        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            // navigation bar color
            statusBarColor: _mainColor));
      });
    }
  }

  void _showDatePicker(String type) async {
    _unFocus();
    DateTime newDateTime = await showRoundedDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
      borderRadius: 0,
      theme: ThemeData(
          primarySwatch: _currentIndex == 0
              ? AppColors.appYellowMaterial
              : AppColors.appGreenMaterial),
      locale: Locale('zh', 'CN'),
    );

    setState(() {
      _billDate = DayDart.fromDateTime(newDateTime).format(fm: 'YYYY-MM-DD');
    });
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

  void _groupSelectOk() {
    setState(() {
      _groupItem = _groups[_groupIndex];
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

  @override
  void dispose() {
    FlutterStatusbarManager.setColor(AppColors.appWhite);
    _tabController.dispose();

    _paymentInputController.dispose();
    _paymentInputFocus.dispose();
    _incomeInputController.dispose();
    _incomeInputFocus.dispose();
    _payMarkController.dispose();
    _payMarkFocus.dispose();
    _incomeMarkController.dispose();
    _incomeMarkFocus.dispose();

    super.dispose();
  }

  void _unFocus() {
    if (_currentIndex == 0) {
      _paymentInputFocus.unfocus();
      _payMarkFocus.unfocus();
    } else {
      _incomeInputFocus.unfocus();
      _incomeMarkFocus.unfocus();
    }
  }

  void _createBill(type) async {
    int _length;
    Map<String, dynamic> _bill;
    TypeItem _tmp;
    TypeItem _category;

    _unFocus();

    if (type == 'income') {
      if (_incomeInputController.text.length == 0) {
        BotToast.showText(text: '变动金额不能为空');
        return;
      }

      _length = _incomeTypes.length;

      for (int i = 0; i < _length; i++) {
        _tmp = _incomeTypes[i];
        if (_tmp.checked) {
          _category = _tmp;
          break;
        }
      }

      _bill = {
        'amount': _incomeInputController.text,
        'billType': '1',
        'category': _category.type,
        'billDate': _billDate,
        'remark': _payMarkController.text
      };
    } else {
      if (_paymentInputController.text.length == 0) {
        BotToast.showText(text: '变动金额不能为空');
        return;
      }

      _length = _payTypes.length;

      for (int i = 0; i < _length; i++) {
        _tmp = _payTypes[i];
        if (_tmp.checked) {
          _category = _tmp;
          break;
        }
      }

      _bill = {
        'amount': _paymentInputController.text,
        'billType': '0',
        'category': _category.type,
        'billDate': _billDate,
        'groupId': _groupItem.id,
        'payMethod': _selectedChannel.type,
        'remark': _payMarkController.text
      };
    }

    print(_bill);

    bool createSuccess = await billStote.createBill(_bill);

    if (createSuccess) {
      AppRouter.back(context);
    }
  }

  Widget _buildPayment(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            child: Wrap(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(color: AppColors.appYellow),
          child: TextField(
              controller: _paymentInputController,
              focusNode: _paymentInputFocus,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(Adaptor.px(20.0)),
                  hintText: '请输入支出金额',
                  fillColor: AppColors.appYellow,
                  filled: true,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.appTextDark, width: Adaptor.onePx()),
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColors.appTextDark,
                          width: Adaptor.onePx()))),
              inputFormatters: [PrecisionLimitFormatter(_precision)],
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              style: TextStyle(
                fontSize: Adaptor.px(32.0),
                color: AppColors.appTextDark,
              ),
              cursorWidth: 1.0,
              cursorColor: AppColors.appTextDark),
        ),
        Container(
            margin: EdgeInsets.only(top: Adaptor.px(20.0)),
            height: Adaptor.px(380.0),
            child: Swiper(
                index: _selectedIndex,
                loop: false,
                itemBuilder: (context, index) {
                  List _subRow = _payTypes.sublist((index * 8),
                      min((index + 1) * 8, MethodsIcons.paymentLength));
                  return Container(
                      child: Wrap(
                          children: List.generate(_subRow.length, (int i) {
                    TypeItem _item = _subRow[i];
                    return GestureDetector(
                        onTap: () {
                          _unFocus();
                          int position = (index * 8) + i;
                          setState(() {
                            _selectedIndex = index;
                            _payTypes.asMap().keys.forEach((int cur) => {
                                  if (cur == position)
                                    {_payTypes[cur].checked = true}
                                  else
                                    {_payTypes[cur].checked = false}
                                });
                          });
                        },
                        child: Container(
                            width: Adaptor.screenW() / 4,
                            height: Adaptor.px(170.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      width: Adaptor.px(100),
                                      height: Adaptor.px(100),
                                      margin: EdgeInsets.only(
                                          bottom: Adaptor.px(10.0)),
                                      decoration: BoxDecoration(
                                          color: _item.checked
                                              ? AppColors.appYellow
                                              : AppColors.appBorder,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(Adaptor.px(50)))),
                                      child: Icon(
                                        _item.icon,
                                        size: Adaptor.px(50.0),
                                        color: _item.checked
                                            ? AppColors.appWhite
                                            : AppColors.appTextDark,
                                      )),
                                  Text(_item.desc,
                                      style: TextStyle(
                                          fontSize: Adaptor.px(24.0),
                                          color: AppColors.appTextDark))
                                ])));
                  }).toList()));
                },
                itemCount: (MethodsIcons.paymentLength / 8).ceil(),
                pagination: SwiperPagination(
                    alignment: Alignment.bottomCenter,
                    builder: RectSwiperPaginationBuilder(
                        color: AppColors.appBorder,
                        activeColor: AppColors.appYellow,
                        size: Size(18, 3),
                        activeSize: Size(18, 3),
                        space: 0.2)),
                autoplay: false,
                scrollDirection: Axis.horizontal,
                onIndexChanged: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                })),
        Container(
          padding: EdgeInsets.only(
              top: Adaptor.px(16.0),
              bottom: Adaptor.px(16.0),
              left: Adaptor.px(20.0),
              right: Adaptor.px(32.0)),
          height: Adaptor.px(100.0),
          decoration: BoxDecoration(
              border: Border(
            top: BorderSide(width: Adaptor.onePx(), color: AppColors.appBorder),
            bottom:
                BorderSide(width: Adaptor.onePx(), color: AppColors.appBorder),
          )),
          child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    child: Text(
                  '付款方式',
                  style: TextStyle(
                    fontSize: Adaptor.px(28.0),
                    color: AppColors.appTextDark,
                  ),
                )),
                Expanded(
                    child: GestureDetector(
                        onTap: () => _payMethodSelect(context),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                                _selectedChannel != null
                                    ? _selectedChannel.desc
                                    : '请选择付款方式',
                                style: TextStyle(
                                    color: AppColors.appTextDark,
                                    fontSize: Adaptor.px(28.0),
                                    fontWeight: FontWeight.normal)))))
              ]),
        ),
        Container(
          padding: EdgeInsets.only(
              top: Adaptor.px(16.0),
              bottom: Adaptor.px(16.0),
              left: Adaptor.px(20.0),
              right: Adaptor.px(32.0)),
          height: Adaptor.px(100.0),
          decoration: BoxDecoration(
              border: Border(
            top: BorderSide(width: Adaptor.onePx(), color: AppColors.appBorder),
            bottom:
                BorderSide(width: Adaptor.onePx(), color: AppColors.appBorder),
          )),
          child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    child: Text(
                  '记账圈子',
                  style: TextStyle(
                    fontSize: Adaptor.px(28.0),
                    color: AppColors.appTextDark,
                  ),
                )),
                Expanded(
                    child: GestureDetector(
                        onTap: () => _groupSelect(context),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                                _groupItem != null
                                    ? _groupItem.name
                                    : '请选择记账圈子',
                                style: TextStyle(
                                    color: AppColors.appTextDark,
                                    fontSize: Adaptor.px(28.0),
                                    fontWeight: FontWeight.normal)))))
              ]),
        ),
        Container(
          padding: EdgeInsets.only(
              top: Adaptor.px(16.0),
              bottom: Adaptor.px(16.0),
              left: Adaptor.px(20.0),
              right: Adaptor.px(32.0)),
          height: Adaptor.px(100.0),
          decoration: BoxDecoration(
              border: Border(
            top: BorderSide(width: Adaptor.onePx(), color: AppColors.appBorder),
            bottom:
                BorderSide(width: Adaptor.onePx(), color: AppColors.appBorder),
          )),
          child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    child: Text(
                  '账单日期',
                  style: TextStyle(
                    fontSize: Adaptor.px(28.0),
                    color: AppColors.appTextDark,
                  ),
                )),
                Expanded(
                    child: GestureDetector(
                        onTap: () => _showDatePicker('pay'),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(_billDate,
                                style: TextStyle(
                                    color: AppColors.appTextDark,
                                    fontSize: Adaptor.px(28.0),
                                    fontWeight: FontWeight.normal)))))
              ]),
        ),
        Container(
          padding:
              EdgeInsets.only(left: Adaptor.px(20.0), right: Adaptor.px(32.0)),
          height: Adaptor.px(100.0),
          decoration: BoxDecoration(
              border: Border(
            bottom:
                BorderSide(width: Adaptor.onePx(), color: AppColors.appBorder),
          )),
          child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    child: Text(
                  '账单备注',
                  style: TextStyle(
                    fontSize: Adaptor.px(28.0),
                    color: AppColors.appTextDark,
                  ),
                )),
                Expanded(
                    child: Container(
                        width: Adaptor.px(500.0),
                        height: Adaptor.px(68.0),
                        padding: EdgeInsets.only(left: Adaptor.px(40.0)),
                        child: TextField(
                            controller: _payMarkController,
                            focusNode: _payMarkFocus,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                                hintText: '请输入账单备注',
                                fillColor: Colors.transparent,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 10.0),
                                filled: true,
                                border: InputBorder.none),
                            style: TextStyle(
                              fontSize: Adaptor.px(28.0),
                              color: AppColors.appTextDark,
                              fontWeight: FontWeight.normal,
                            ),
                            cursorWidth: 1.0,
                            cursorColor: AppColors.appTextDark)))
              ]),
        ),
        GestureDetector(
            onTap: () => _createBill('payment'),
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
                    borderRadius:
                        BorderRadius.all(Radius.circular(Adaptor.px(10.0)))),
                child: Center(
                    child: Text('记一笔',
                        style: TextStyle(
                            fontSize: Adaptor.px(30.0),
                            fontWeight: FontWeight.normal,
                            color: AppColors.appTextDark)))))
      ],
    )));
  }

  Widget _buildInCome(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            child: Wrap(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(color: AppColors.appGreen),
          child: TextField(
              controller: _incomeInputController,
              focusNode: _incomeInputFocus,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(Adaptor.px(20.0)),
                  hintText: '请输入收入金额',
                  fillColor: AppColors.appGreen,
                  filled: true,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.appTextDark, width: Adaptor.onePx()),
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColors.appTextDark,
                          width: Adaptor.onePx()))),
              inputFormatters: [PrecisionLimitFormatter(_precision)],
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              style: TextStyle(
                fontSize: Adaptor.px(32.0),
                color: AppColors.appTextDark,
              ),
              cursorWidth: 1.0,
              cursorColor: AppColors.appTextDark),
        ),
        Container(
            margin: EdgeInsets.only(top: Adaptor.px(20.0)),
            height: Adaptor.px(380.0),
            child: Wrap(
              children: <Widget>[
                Row(
                  children:
                      List.generate(MethodsIcons.incomeRowLengthMax, (int i) {
                    TypeItem _item = _incomeTypes[i];
                    return Container(
                        width: Adaptor.screenW() / 4,
                        height: Adaptor.px(170.0),
                        child: GestureDetector(
                            onTap: () {
                              _unFocus();
                              setState(() {
                                _incomeTypes.asMap().keys.forEach((int cur) => {
                                      if (cur == i)
                                        {_incomeTypes[cur].checked = true}
                                      else
                                        {_incomeTypes[cur].checked = false}
                                    });
                              });
                            },
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      width: Adaptor.px(100),
                                      height: Adaptor.px(100),
                                      margin: EdgeInsets.only(
                                          bottom: Adaptor.px(10.0)),
                                      decoration: BoxDecoration(
                                          color: _item.checked
                                              ? AppColors.appGreen
                                              : AppColors.appBorder,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(Adaptor.px(50)))),
                                      child: Icon(
                                        _item.icon,
                                        size: Adaptor.px(50.0),
                                        color: _item.checked
                                            ? AppColors.appWhite
                                            : AppColors.appTextDark,
                                      )),
                                  Text(_item.desc,
                                      style: TextStyle(
                                          fontSize: Adaptor.px(24.0),
                                          color: AppColors.appTextDark))
                                ])));
                  }).toList(),
                ),
                Row(
                  children:
                      List.generate(MethodsIcons.incomeRowLengthMax, (int i) {
                    int index = i + 4;
                    TypeItem _item = _incomeTypes[i + 4];
                    return Container(
                        width: Adaptor.screenW() / 4,
                        height: Adaptor.px(170.0),
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _incomeTypes.asMap().keys.forEach((int cur) => {
                                      if (cur == index)
                                        {_incomeTypes[cur].checked = true}
                                      else
                                        {_incomeTypes[cur].checked = false}
                                    });
                              });
                            },
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      width: Adaptor.px(100),
                                      height: Adaptor.px(100),
                                      margin: EdgeInsets.only(
                                          bottom: Adaptor.px(10.0)),
                                      decoration: BoxDecoration(
                                          color: _item.checked
                                              ? AppColors.appGreen
                                              : AppColors.appBorder,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(Adaptor.px(50)))),
                                      child: Icon(
                                        _item.icon,
                                        size: Adaptor.px(50.0),
                                        color: _item.checked
                                            ? AppColors.appWhite
                                            : AppColors.appTextDark,
                                      )),
                                  Text(_item.desc,
                                      style: TextStyle(
                                          fontSize: Adaptor.px(24.0),
                                          color: AppColors.appTextDark))
                                ])));
                  }).toList(),
                )
              ],
            )),
        Container(
          padding: EdgeInsets.only(
              top: Adaptor.px(16.0),
              bottom: Adaptor.px(16.0),
              left: Adaptor.px(20.0),
              right: Adaptor.px(32.0)),
          height: Adaptor.px(100.0),
          decoration: BoxDecoration(
              border: Border(
            top: BorderSide(width: Adaptor.onePx(), color: AppColors.appBorder),
            bottom:
                BorderSide(width: Adaptor.onePx(), color: AppColors.appBorder),
          )),
          child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    child: Text(
                  '账单日期',
                  style: TextStyle(
                    fontSize: Adaptor.px(28.0),
                    color: AppColors.appTextDark,
                  ),
                )),
                Expanded(
                    child: GestureDetector(
                        onTap: () => _showDatePicker('pay'),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(_billDate,
                                style: TextStyle(
                                    color: AppColors.appTextDark,
                                    fontSize: Adaptor.px(28.0),
                                    fontWeight: FontWeight.normal)))))
              ]),
        ),
        Container(
          padding:
              EdgeInsets.only(left: Adaptor.px(20.0), right: Adaptor.px(32.0)),
          height: Adaptor.px(100.0),
          decoration: BoxDecoration(
              border: Border(
            bottom:
                BorderSide(width: Adaptor.onePx(), color: AppColors.appBorder),
          )),
          child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    child: Text(
                  '账单备注',
                  style: TextStyle(
                    fontSize: Adaptor.px(28.0),
                    color: AppColors.appTextDark,
                  ),
                )),
                Expanded(
                    child: Container(
                        width: Adaptor.px(500.0),
                        height: Adaptor.px(68.0),
                        padding: EdgeInsets.only(left: Adaptor.px(40.0)),
                        child: TextField(
                            controller: _incomeMarkController,
                            focusNode: _incomeMarkFocus,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                                hintText: '请输入账单备注',
                                fillColor: Colors.transparent,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 10.0),
                                filled: true,
                                border: InputBorder.none),
                            style: TextStyle(
                              fontSize: Adaptor.px(28.0),
                              color: AppColors.appTextDark,
                              fontWeight: FontWeight.normal,
                            ),
                            cursorWidth: 1.0,
                            cursorColor: AppColors.appTextDark)))
              ]),
        ),
        GestureDetector(
            onTap: () => _createBill('income'),
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
                    color: AppColors.appGreen,
                    borderRadius:
                        BorderRadius.all(Radius.circular(Adaptor.px(10.0)))),
                child: Center(
                    child: Text('记一笔',
                        style: TextStyle(
                            fontSize: Adaptor.px(30.0),
                            fontWeight: FontWeight.normal,
                            color: AppColors.appTextDark)))))
      ],
    )));
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarManager.setColor(_mainColor);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('记账',
              style: TextStyle(
                  fontSize: Adaptor.px(32.0), color: AppColors.appTextDark)),
          backgroundColor: _mainColor,
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.transparent,
            tabs: <Widget>[
              Tab(
                  child: Text('支出',
                      style: TextStyle(
                          fontSize:
                              Adaptor.px(_currentIndex == 0 ? 36.0 : 32.0),
                          fontWeight: _currentIndex == 0
                              ? FontWeight.w500
                              : FontWeight.w400))),
              Tab(
                  child: Text('收入',
                      style: TextStyle(
                          fontSize:
                              Adaptor.px(_currentIndex == 1 ? 36.0 : 32.0),
                          fontWeight: _currentIndex == 1
                              ? FontWeight.w500
                              : FontWeight.w400)))
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[_buildPayment(context), _buildInCome(context)],
        ),
      ),
    );
  }
}
