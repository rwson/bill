import 'dart:math';

import 'package:bill/adaptor.dart';
import 'package:bill/colors.dart';
import 'package:bill/router.dart';
import 'package:bill/stores/stores.dart';
import 'package:bill/stores/bill.dart';
import 'package:bill/methods-icons.dart';
import 'package:bill/pay-channels.dart';
import 'package:bill/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:flutter_daydart/flutter_daydart.dart';
import 'package:flutter/cupertino.dart';

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

  TextEditingController _paymentInputController;

  TextEditingController _incomeInputController;

  TextEditingController _payMarkController;

  TextEditingController _incomeMarkController;

  Color _mainColor = AppColors.appYellow;

  int _currentIndex = 0;

  int _selectedIndex = 0;

  int _payChannelIndex = 0;

  ChannelItem _selectedChannel;

  List<TypeItem> _payTypes = [];

  List<TypeItem> _incomeTypes = [];

  List<ChannelItem> _payChannels = [];

  final int _precision = 2;

  String _currentType = 'pay';

  String _billDate = DayDart().format(fm: 'YYYY-MM-DD');

  final BillStore billStote = AppStores.billStore;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 2);
    _tabController..addListener(_handleTabChange);

    _paymentInputController = TextEditingController();
    _incomeInputController = TextEditingController();
    _payMarkController = TextEditingController();
    _incomeMarkController = TextEditingController();

    MethodsIcons.paymentIcons.forEach((item) {
      _payTypes.add(TypeItem(
          icon: item.icon, type: item.type, desc: item.desc, checked: false));
    });

    MethodsIcons.incomeIcons.forEach((item) {
      _incomeTypes.add(TypeItem(
          icon: item.icon, type: item.type, desc: item.desc, checked: false));
    });

    PayChannels.payChannels.forEach((item) {
      _payChannels.add(ChannelItem(type: item.type, desc: item.desc));
    });
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _currentIndex = _tabController.index;
        _payChannelIndex = 0;
        _selectedChannel = null;
        _billDate = DayDart().format(fm: 'YYYY-MM-DD');
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

  void _payMethodSelect(BuildContext context) {
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
                            onTap: () {
                              setState(() {
                                _selectedChannel =
                                    _payChannels[_payChannelIndex];
                              });
                            },
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
    _incomeInputController.dispose();
    _payMarkController.dispose();
    _incomeMarkController.dispose();

    super.dispose();
  }

  void _createBill(type) async {
    bool createSuccess;
    if (type == 'income') {
      createSuccess = await billStote.createIncomeBill({
        'date': _billDate,
        'amount': _incomeInputController.text,
        'remark': _payMarkController.text,
        'recordType': '0',
        'groupId': 0
      });
    } else {
      createSuccess = await billStote.createPaymentBill({
        'date': _billDate,
        'amount': _paymentInputController.text,
        'remark': _payMarkController.text,
        'channel': _selectedChannel.type,
        'recordType': '0',
        'groupId': 0
      });
    }

    if (createSuccess) {
      AppRouter.back(context);
    }
  }

  Widget _buildPayment(BuildContext context) {
    return Container(
        child: Wrap(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(color: AppColors.appYellow),
          child: TextField(
              controller: _paymentInputController,
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
                                        color: _item.checked ? AppColors.appWhite : AppColors.appTextDark,
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
                            child: Text(_selectedChannel != null ? _selectedChannel.desc : '请选择付款方式',
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
    ));
  }

  Widget _buildInCome(BuildContext context) {
    return Container(
        child: Wrap(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(color: AppColors.appGreen),
          child: TextField(
              controller: _incomeInputController,
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
                                        color: _item.checked ? AppColors.appWhite : AppColors.appTextDark,
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
                                        color: _item.checked ? AppColors.appWhite : AppColors.appTextDark,
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
    ));
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
