import 'package:bill/adaptor.dart';
import 'package:bill/bean/statistics.dart';
import 'package:bill/colors.dart';
import 'package:bill/iconfont.dart';
import 'package:bill/router.dart';
import 'package:bill/stores/statistics.dart';
import 'package:bill/stores/stores.dart';
import 'package:bill/stores/user.dart';
import 'package:bill/widgets/empty.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class WealthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WealthState();
}

class WealthState extends State<WealthPage> {
  String _currentYear;
  int _selectedIndex = -1;

  final StatisticsStore statisticsStore = AppStores.statisticsStore;

  final UserStore userStore = AppStores.userStore;

  @override
  void initState() {
    super.initState();
    _initPage();
  }

  void _initPage() async {
    if (userStore.logined) {
      await statisticsStore.getBillYears();

      if (statisticsStore.years.length > 0) {
        setState(() {
          _selectedIndex = 0;
          _currentYear = statisticsStore.years[0];
        });
      }

      _getYearlyBills();
    }
  }

  void _getYearlyBills() {
    statisticsStore.getYearlyBills({'year': _currentYear});
  }

  @override
  void deactivate() {
    super.deactivate();
    bool current = ModalRoute.of(context).isCurrent;
    if (current) {
      _initPage();
    }
  }

  void _yearSelectOk() {
    setState(() {
      if (_selectedIndex != -1) {
        _currentYear = statisticsStore.years[_selectedIndex];
      }
    });
    Navigator.of(context).pop();
  }

  void _showYearSelect(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Observer(
            builder: (_) {
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
                            child: Text('选择账单年度',
                                style: TextStyle(
                                    fontSize: Adaptor.px(32.0),
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.appTextDark))),
                      ),
                      Container(
                          height: Adaptor.px(350.0),
                          child: Center(
                              child: Container(
                                  width: Adaptor.px(200.0),
                                  height: Adaptor.px(300.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                          width: Adaptor.px(200.0),
                                          child: CupertinoPicker(
                                            // looping: true,
                                            itemExtent: Adaptor.px(64.0),
                                            backgroundColor: Colors.white,
                                            onSelectedItemChanged: (int i) {
                                              setState(() {
                                                _selectedIndex = i;
                                              });
                                            },
                                            children: List.generate(
                                                statisticsStore.years.length,
                                                (int index) {
                                              return Center(
                                                  child: Text(
                                                      statisticsStore
                                                          .years[index],
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .appTextDark,
                                                          fontSize:
                                                              Adaptor.px(32.0),
                                                          fontWeight: FontWeight
                                                              .normal)));
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
                                              Radius.circular(
                                                  Adaptor.px(45.0)))),
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
                                  onTap: _yearSelectOk,
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.sheetBtnBg,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  Adaptor.px(45.0)))),
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
        });
  }

  void _toMonthBillList(month) {
    AppRouter.toPage(context, 'month-bill-list?month=${month}');
  }

  void _toRecord(context) {
    AppRouter.toPage(context, 'record');
  }

  void _toLogin(context) {
    AppRouter.toPage(context, 'record');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('资产',
                style: TextStyle(
                    fontSize: Adaptor.px(32.0), color: AppColors.appTextDark))),
        body: Container(
            child: SingleChildScrollView(
                child: Container(
                    margin: EdgeInsets.only(
                        top: Adaptor.px(10.0),
                        left: Adaptor.px(10.0),
                        right: Adaptor.px(10.0)),
                    child: Observer(builder: (_) {
                      double yearlyRemain = 0;
                      double yearlyTotalPay = 0;
                      double yearlyTotalIncome = 0;

                      List<MonthliAmount> monthlyBills = [];

                      if (statisticsStore.yearlyAnalyze != null) {
                        yearlyRemain = statisticsStore
                            .yearlyAnalyze.yearlyAmounts.totalRemain;
                        yearlyTotalPay = statisticsStore
                            .yearlyAnalyze.yearlyAmounts.totalPay;
                        yearlyTotalIncome = statisticsStore
                            .yearlyAnalyze.yearlyAmounts.totalIncome;
                        monthlyBills = List.from(
                            statisticsStore.yearlyAnalyze.monthlyAmounts);
                      }

                      return Wrap(children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(
                                top: Adaptor.px(10.0),
                                left: Adaptor.px(10.0),
                                right: Adaptor.px(10.0)),
                            width: Adaptor.px(1040.0),
                            height: Adaptor.px(350.0),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                boxShadow: [
                                  BoxShadow(
                                      color: AppColors.appYellowShadow,
                                      blurRadius: 8.0,
                                      offset: Offset(0, 1.0))
                                ],
                                gradient: const LinearGradient(
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                    colors: [
                                      AppColors.appYellow,
                                      AppColors.appYellowLight
                                    ])),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  _currentYear != null
                                      ? Container(
                                          child: FlatButton(
                                              padding: EdgeInsets.all(
                                                  Adaptor.px(10.0)),
                                              onPressed: () =>
                                                  _showYearSelect(context),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Text('$_currentYear年',
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .appTextDark,
                                                          fontSize:
                                                              Adaptor.px(28.0),
                                                          fontWeight: FontWeight
                                                              .normal)),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: Adaptor.px(4.0),
                                                        right:
                                                            Adaptor.px(16.0)),
                                                    child: Icon(
                                                        IconFont.iconDown,
                                                        size: Adaptor.px(16.0),
                                                        color: AppColors
                                                            .appTextDark),
                                                  )
                                                ],
                                              )))
                                      : SizedBox(
                                          height: Adaptor.px(88.0),
                                        ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        bottom: Adaptor.px(40.0)),
                                    child: Column(children: <Widget>[
                                      Text('全年结余',
                                          style: TextStyle(
                                              fontSize: Adaptor.px(32.0),
                                              color: AppColors.appTextDark)),
                                      Text('${yearlyRemain}',
                                          style: TextStyle(
                                              fontSize: Adaptor.px(48.0),
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.appTextDark))
                                    ]),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                          flex: 1,
                                          child: Container(
                                              width:
                                                  Adaptor.px(Adaptor.screenW()),
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      right: BorderSide(
                                                          width:
                                                              Adaptor.onePx(),
                                                          color: AppColors
                                                              .appBorderDark))),
                                              child: Column(
                                                children: <Widget>[
                                                  Text('全年支出',
                                                      style: TextStyle(
                                                          fontSize:
                                                              Adaptor.px(28.0),
                                                          color: AppColors
                                                              .appTextDark)),
                                                  Text('${yearlyTotalPay}',
                                                      style: TextStyle(
                                                          fontSize:
                                                              Adaptor.px(32.0),
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: AppColors
                                                              .appTextDark))
                                                ],
                                              ))),
                                      Expanded(
                                          flex: 1,
                                          child: Container(
                                              child: Column(
                                            children: <Widget>[
                                              Text('全年收入',
                                                  style: TextStyle(
                                                      fontSize:
                                                          Adaptor.px(28.0),
                                                      color: AppColors
                                                          .appTextDark)),
                                              Text('${yearlyTotalIncome}',
                                                  style: TextStyle(
                                                      fontSize:
                                                          Adaptor.px(32.0),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: AppColors
                                                          .appTextDark))
                                            ],
                                          )))
                                    ],
                                  )
                                ],
                              ),
                            )),
                        (monthlyBills.length > 0)
                            ? Container(
                                margin: EdgeInsets.only(
                                    top: Adaptor.px(20.0),
                                    bottom: Adaptor.px(20.0),
                                    left: Adaptor.px(10.0),
                                    right: Adaptor.px(10.0)),
                                width: Adaptor.px(1040.0),
                                padding: EdgeInsets.all(Adaptor.px(20.0)),
                                decoration: BoxDecoration(
                                    color: AppColors.appWhite,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: AppColors.appBlackShadow,
                                          blurRadius: 5.0,
                                          offset: Offset(0, 1.0))
                                    ]),
                                child: Column(children: <Widget>[
                                  Container(
                                      width: Adaptor.px(1040.0),
                                      height: Adaptor.px(80.0),
                                      padding: EdgeInsets.only(
                                          bottom: Adaptor.px(20.0),
                                          top: Adaptor.px(10.0)),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  width: Adaptor.onePx(),
                                                  color: AppColors.appBorder))),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Container(
                                              child: Text('月份',
                                                  style: TextStyle(
                                                      fontSize:
                                                          Adaptor.px(30.0),
                                                      color: AppColors
                                                          .appTextDark)),
                                            ),
                                            Container(
                                              child: Text('收入',
                                                  style: TextStyle(
                                                      fontSize:
                                                          Adaptor.px(30.0),
                                                      color: AppColors
                                                          .appTextDark)),
                                            ),
                                            Container(
                                              child: Text('支出',
                                                  style: TextStyle(
                                                      fontSize:
                                                          Adaptor.px(30.0),
                                                      color: AppColors
                                                          .appTextDark)),
                                            ),
                                            Container(
                                              child: Text('结余',
                                                  style: TextStyle(
                                                      fontSize:
                                                          Adaptor.px(30.0),
                                                      color: AppColors
                                                          .appTextDark)),
                                            )
                                          ])),
                                  ...List.generate(monthlyBills.length,
                                      (int i) {
                                    MonthliAmount _billMonth = statisticsStore
                                        .yearlyAnalyze.monthlyAmounts[i];
                                    return GestureDetector(
                                        onTap: () => _toMonthBillList(
                                            _billMonth.billMonth),
                                        child: Container(
                                            width: Adaptor.px(1040.0),
                                            height: Adaptor.px(76.0),
                                            padding: EdgeInsets.only(
                                                bottom: Adaptor.px(20.0),
                                                top: Adaptor.px(20.0)),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        width: Adaptor.onePx(),
                                                        color: AppColors
                                                            .appBorder))),
                                            child: Flex(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                direction: Axis.horizontal,
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Center(
                                                        child: Text(
                                                            _billMonth
                                                                .billMonth,
                                                            style: TextStyle(
                                                                fontSize:
                                                                    Adaptor.px(
                                                                        28.0),
                                                                color: AppColors
                                                                    .appTextDark))),
                                                  ),
                                                  Expanded(
                                                      child: Center(
                                                          child: Text(
                                                    '${_billMonth.totalIncome.toStringAsFixed(2)}',
                                                    style: TextStyle(
                                                        fontSize:
                                                            Adaptor.px(28.0),
                                                        color: AppColors
                                                            .appIncome),
                                                  ))),
                                                  Expanded(
                                                      child: Center(
                                                          child: Text(
                                                              '${_billMonth.totalPay.toStringAsFixed(2)}',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      Adaptor.px(
                                                                          28.0),
                                                                  color: AppColors
                                                                      .appOutlay)))),
                                                  Expanded(
                                                      child: Center(
                                                          child: Text(
                                                              '${_billMonth.totalRemain.toStringAsFixed(2)}',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      Adaptor.px(
                                                                          28.0),
                                                                  color: AppColors
                                                                      .appTextDark)))),
                                                ])));
                                  })
                                ]))
                            : Empty(
                                top: Adaptor.px(200.0),
                                child: userStore.logined
                                    ? Wrap(
                                        children: <Widget>[
                                          Text('暂无月度账单数据,',
                                              style: TextStyle(
                                                  fontSize: Adaptor.px(24.0),
                                                  color:
                                                      AppColors.appTextLight)),
                                          Text('快去',
                                              style: TextStyle(
                                                  fontSize: Adaptor.px(24.0),
                                                  color:
                                                      AppColors.appTextLight)),
                                          GestureDetector(
                                            onTap: () => _toRecord(context),
                                            child: Text('记一笔',
                                                style: TextStyle(
                                                    fontSize: Adaptor.px(24.0),
                                                    color:
                                                        AppColors.appYellow)),
                                          ),
                                          Text('吧~',
                                              style: TextStyle(
                                                  fontSize: Adaptor.px(24.0),
                                                  color:
                                                      AppColors.appTextLight)),
                                        ],
                                      )
                                    : Wrap(
                                        children: <Widget>[
                                          Text('暂未登录,',
                                              style: TextStyle(
                                                  fontSize: Adaptor.px(24.0),
                                                  color:
                                                      AppColors.appTextLight)),
                                          Text('快去',
                                              style: TextStyle(
                                                  fontSize: Adaptor.px(24.0),
                                                  color:
                                                      AppColors.appTextLight)),
                                          GestureDetector(
                                            onTap: () => _toLogin(context),
                                            child: Text('登录/注册',
                                                style: TextStyle(
                                                    fontSize: Adaptor.px(24.0),
                                                    color:
                                                        AppColors.appYellow)),
                                          ),
                                          Text('吧~',
                                              style: TextStyle(
                                                  fontSize: Adaptor.px(24.0),
                                                  color:
                                                      AppColors.appTextLight)),
                                        ],
                                      ))
                      ]);
                    })))));
  }
}
