import 'dart:math';

import 'package:bill/adaptor.dart';
import 'package:bill/colors.dart';
import 'package:bill/methods-icons.dart';
import 'package:bill/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
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

  TextEditingController _paymentInputController;

  TextEditingController _incomeInputController;

  TextEditingController _payMarkController;

  TextEditingController _incomeMarkController;

  Color _mainColor = AppColors.appYellow;

  int _currentIndex = 0;

  int _selectedIndex = 0;

  List<TypeItem> _payTypes = [];

  List<TypeItem> _incomeTypes = [];

  final int _precision = 2;

  String _currentType = 'pay';

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
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _currentIndex = _tabController.index;
        _mainColor = (_tabController.index == 0)
            ? AppColors.appYellow
            : AppColors.appGreen;

        FlutterStatusbarManager.setColor(_mainColor);

        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(// navigation bar color
          statusBarColor: _mainColor
        ));
      });
    }
  }

  void _showDatePicker(String type) {
    DatePicker.showDatePicker(context,
        maxTime: DateTime.now(),
        locale: LocaleType.zh,
        theme: new DatePickerTheme(
            cancelStyle: TextStyle(
                fontSize: Adaptor.px(28.0), color: AppColors.appTextDark),
            doneStyle: TextStyle(
                fontSize: Adaptor.px(28.0), color: AppColors.appYellow),
            itemStyle: TextStyle(
                fontSize: Adaptor.px(32.0), color: AppColors.appTextDark)));
    setState(() {
      if (_currentType != type) {
        _currentType = type;
      }
    });
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

  Widget _buildPayment(BuildContext context) {
    return new Container(
        child: new Wrap(
      children: <Widget>[
        new Container(
          padding: EdgeInsets.only(bottom: Adaptor.px(28.0)),
          decoration: new BoxDecoration(color: AppColors.appYellow),
          child: new TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(Adaptor.px(20.0)),
                  hintText: '请输入金额',
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
        new Container(
            margin: EdgeInsets.only(top: Adaptor.px(20.0)),
            height: Adaptor.px(380.0),
            child: new Swiper(
                index: _selectedIndex,
                loop: false,
                itemBuilder: (context, index) {
                  List _subRow = _payTypes.sublist((index * 8),
                      min((index + 1) * 8, MethodsIcons.paymentLength));
                  return new Container(
                      child: new Wrap(
                          children: List.generate(_subRow.length, (int i) {
                    TypeItem _item = _subRow[i];
                    return new Container(
                      width: Adaptor.screenW() / 4,
                      height: Adaptor.px(170.0),
                      child: new FlatButton(
                          onPressed: () {
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
                          child: new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Container(
                                    width: Adaptor.px(100),
                                    height: Adaptor.px(100),
                                    margin: EdgeInsets.only(
                                        bottom: Adaptor.px(10.0)),
                                    decoration: new BoxDecoration(
                                        color: _item.checked
                                            ? AppColors.appYellow
                                            : AppColors.appBorder,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(Adaptor.px(50)))),
                                    child: new Icon(
                                      _item.icon,
                                      size: Adaptor.px(50.0),
                                      color: AppColors.appTextDark,
                                    )),
                                new Text(_item.desc,
                                    style: TextStyle(
                                        fontSize: Adaptor.px(24.0),
                                        color: AppColors.appTextDark))
                              ])),
                    );
                  }).toList()));
                },
                itemCount: (MethodsIcons.paymentLength / 8).ceil(),
                pagination: new SwiperPagination(
                    alignment: Alignment.bottomCenter,
                    builder: new RectSwiperPaginationBuilder(
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
        new Container(
          padding: EdgeInsets.only(
              top: Adaptor.px(16.0),
              bottom: Adaptor.px(16.0),
              left: Adaptor.px(20.0),
              right: Adaptor.px(32.0)),
          height: Adaptor.px(100.0),
          decoration: new BoxDecoration(
              border: Border(
            top: BorderSide(width: Adaptor.onePx(), color: AppColors.appBorder),
            bottom:
                BorderSide(width: Adaptor.onePx(), color: AppColors.appBorder),
          )),
          child: new Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Container(
                    child: new Text(
                  '记账日期',
                  style: TextStyle(
                    fontSize: Adaptor.px(28.0),
                    color: AppColors.appTextDark,
                  ),
                )),
                new Expanded(
                    child: new GestureDetector(
                        onTap: () => _showDatePicker('pay'),
                        child: new Align(
                            alignment: Alignment.centerRight,
                            child: new Text('2019-11-18',
                                style: TextStyle(
                                    color: AppColors.appTextDark,
                                    fontSize: Adaptor.px(28.0),
                                    fontWeight: FontWeight.normal)))))
              ]),
        ),
        new Container(
          padding: EdgeInsets.only(
              top: Adaptor.px(16.0),
              bottom: Adaptor.px(16.0),
              left: Adaptor.px(20.0),
              right: Adaptor.px(32.0)),
          height: Adaptor.px(100.0),
          decoration: new BoxDecoration(
              border: Border(
            bottom:
                BorderSide(width: Adaptor.onePx(), color: AppColors.appBorder),
          )),
          child: new Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Container(
                    child: new Text(
                  '账单备注',
                  style: TextStyle(
                    fontSize: Adaptor.px(28.0),
                    color: AppColors.appTextDark,
                  ),
                )),
                new Expanded(
                    child: new Container(
                        width: Adaptor.px(500.0),
                        height: Adaptor.px(68.0),
                        child: new TextField(
                            controller: _payMarkController,
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.all(Adaptor.px(20.0)),
                                hintText: '请输入账单备注',
                                fillColor: Colors.transparent,
                                filled: true,
                                border: InputBorder.none),
                            inputFormatters: [
                              PrecisionLimitFormatter(_precision)
                            ],
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            style: TextStyle(
                                fontSize: Adaptor.px(28.0),
                                color: AppColors.appTextDark,
                                fontWeight: FontWeight.normal),
                            cursorWidth: 1.0,
                            cursorColor: AppColors.appTextDark)))
              ]),
        )
      ],
    ));
  }

  Widget _buildInCome() {
    return new Container();
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
                  child: new Text('支出',
                      style: TextStyle(
                          fontSize:
                              Adaptor.px(_currentIndex == 0 ? 36.0 : 32.0),
                          fontWeight: _currentIndex == 0
                              ? FontWeight.w500
                              : FontWeight.w400))),
              Tab(
                  child: new Text('收入',
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
          children: <Widget>[_buildPayment(context), _buildInCome()],
        ),
      ),
    );
  }
}
