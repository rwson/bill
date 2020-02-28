import 'package:bill/adaptor.dart';
import 'package:bill/colors.dart';
import 'package:bill/iconfont.dart';
import 'package:bill/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:bill/bean/bill.dart';
import 'package:bill/stores/stores.dart';
import 'package:bill/stores/bill.dart';
import 'package:bill/stores/statistics.dart';
import 'package:bill/methods-icons.dart';
import 'package:percent_indicator/percent_indicator.dart';

class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<IndexPage> {
  final BillStore billStore = AppStores.billStore;
  final StatisticsStore statisticsStore = AppStores.statisticsStore;

  @override
  void initState() {
    super.initState();
    _initPage();
  }

  void _initPage() {
    statisticsStore.compareLast();
    billStore.getMonthBills();
  }

  @override
  void deactivate() {
    super.deactivate();
    bool current = ModalRoute.of(context).isCurrent;
    if (current) {
      _initPage();
    }
  }

  void _toRecord(context) {
    AppRouter.toPage(context, 'record');
  }

  void _toLimitset(context) {
    AppRouter.toPage(context, 'limit-set');
  }

  Widget _buildBills() {
    return Container(
        child: Expanded(
            child: ListView.builder(
                itemCount: billStore.homeBills.length,
                itemBuilder: (BuildContext context, int index) {
                  BillItem _currentBill = billStore.homeBills[index];
                  return Container(
                      margin: EdgeInsets.only(
                          left: Adaptor.px(6.0),
                          right: Adaptor.px(6.0),
                          bottom: Adaptor.px(10.0),
                          top: Adaptor.onePx()),
                      padding: EdgeInsets.all(Adaptor.px(16.0)),
                      decoration: BoxDecoration(
                          color: AppColors.appWhite,
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.appBlackShadow,
                                blurRadius: 5.0,
                                offset: Offset(0, 1.0))
                          ]),
                      child: Wrap(children: <Widget>[
                        Wrap(children: <Widget>[
                          Container(
                              padding: EdgeInsets.only(
                                  top: Adaptor.px(16.0),
                                  bottom: Adaptor.px(16.0)),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                    width: Adaptor.onePx(),
                                    color: AppColors.appBorder),
                              )),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('${_currentBill.billDate}',
                                        style: TextStyle(
                                            fontSize: Adaptor.px(28.0),
                                            color: AppColors.appTextNormal)),
                                    Wrap(
                                      children: <Widget>[
                                        Text('支出${_currentBill.totalPay}',
                                            style: TextStyle(
                                                fontSize: Adaptor.px(28.0),
                                                color: AppColors.appOutlay)),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: Adaptor.px(20.0)),
                                          child: Text(
                                              '收入${_currentBill.totalIncome}',
                                              style: TextStyle(
                                                  fontSize: Adaptor.px(28.0),
                                                  color: AppColors.appIncome)),
                                        )
                                      ],
                                    ),
                                  ])),
                          ...List.generate(_currentBill.bills.length,
                              (int billIndex) {
                            BillRow _billRow = _currentBill.bills[billIndex];
                            bool _isIncome = _billRow.billType == '1';
                            IconItem _rowType;

                            if (_isIncome) {
                              _rowType = MethodsIcons
                                  .incomeIconMaps[_billRow.category];
                            } else {
                              _rowType = MethodsIcons
                                  .paymentIconMaps[_billRow.category];
                            }

                            return Container(
                                padding: EdgeInsets.only(
                                    top: Adaptor.px(20.0),
                                    bottom: Adaptor.px(20.0)),
                                decoration: BoxDecoration(
                                    border: Border(
                                  bottom: BorderSide(
                                      width: Adaptor.onePx(),
                                      color: AppColors.appBorder),
                                )),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Column(children: <Widget>[
                                        Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                width: Adaptor.px(80.0),
                                                height: Adaptor.px(80.0),
                                                decoration: BoxDecoration(
                                                    color: AppColors.appYellow,
                                                    borderRadius: BorderRadius
                                                        .all(Radius.circular(
                                                            Adaptor.px(40.0)))),
                                                child: Center(
                                                    child: Icon(_rowType.icon,
                                                        size:
                                                            Adaptor.px(50.0))),
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: Adaptor.px(20.0)),
                                                  child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(_rowType.desc,
                                                            style: TextStyle(
                                                                fontSize:
                                                                    Adaptor.px(
                                                                        30.0),
                                                                color: AppColors
                                                                    .appTextDark)),
                                                        Text(
                                                            _billRow.remark ??
                                                                '',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    Adaptor.px(
                                                                        24.0),
                                                                color: AppColors
                                                                    .appTextDark))
                                                      ]))
                                            ])
                                      ]),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(_billRow.amount,
                                              style: TextStyle(
                                                  fontSize: Adaptor.px(36.0),
                                                  color: _isIncome
                                                      ? AppColors.appIncome
                                                      : AppColors.appOutlay))
                                        ],
                                      )
                                    ]));
                          }).toList()
                        ])
                      ]));
                })));
  }

  Widget _buildProgress() {
    if (statisticsStore.compared == null) {
      return SizedBox.shrink();
    }

    bool _isSetted = statisticsStore.compared.limitSetted;
    double _percent = statisticsStore.compared.percent;

    Color _lineColor;

    if (_isSetted) {
      if (_percent <= 0.2) {
        _lineColor = AppColors.appSufficient;
      } else if (_percent <= 0.6)  {
        _lineColor = AppColors.appRegular;
      } else if (_percent <= 0.8) {
        _lineColor = AppColors.appWarning;
      } else if (_percent > 0.8) {
        _lineColor = AppColors.appDanger;
      }
    }

    return Container(
        margin: EdgeInsets.only(top: Adaptor.px(20.0)),
        width: Adaptor.px(1020),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: AppColors.appWhite,
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            boxShadow: [
              BoxShadow(
                  color: AppColors.appBlackShadow,
                  blurRadius: 5.0,
                  offset: Offset(0, 1.0))
            ]),
        child: Wrap(children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '本月消费',
                  style: TextStyle(
                      color: AppColors.appTextDark, fontSize: Adaptor.px(28.0)),
                ),
                GestureDetector(
                  onTap: () => _toLimitset(context),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        IconFont.iconSettings,
                        size: Adaptor.px(26.0),
                        color: AppColors.appTextDark,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: Adaptor.px(4.0)),
                        child: Text('设置预算',
                            style: TextStyle(
                                color: AppColors.appTextDark,
                                fontSize: Adaptor.px(28.0))),
                      )
                    ],
                  ),
                )
              ]),
          Container(
            margin: const EdgeInsets.only(top: 6.0, bottom: 6.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('￥${statisticsStore.compared.totalPay}',
                      style: TextStyle(
                          color: AppColors.appTextDark,
                          fontSize: Adaptor.px(28.0))),
                  Text('￥${statisticsStore.compared.limit}',
                      style: TextStyle(
                          color: AppColors.appTextDark,
                          fontSize: Adaptor.px(28.0))),
                ]),
          ),
          _isSetted ?
          LinearPercentIndicator(
            lineHeight: Adaptor.px(28.0),
            percent: _percent > 1 ? 1 : _percent,
            animation: true,
            center: Text(
              '${(_percent * 100).toStringAsFixed(2)}%',
              style: TextStyle(
                fontSize: Adaptor.px(20.0),
                color: AppColors.appTextDark
              ),
            ),
            linearStrokeCap: LinearStrokeCap.roundAll,
            backgroundColor: Colors.transparent,
            progressColor: _lineColor,
          ) : SizedBox.shrink()
        ]));
  }

  Widget _buildIncomePayment() {
    if (statisticsStore.compared == null) {
      return SizedBox.shrink();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
              height: Adaptor.px(180.0),
              margin: EdgeInsets.only(
                  left: Adaptor.px(8.0), right: Adaptor.px(8.0)),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.appYellowShadow,
                        blurRadius: 8.0,
                        offset: Offset(2.0, 1.0))
                  ],
                  gradient: const LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [AppColors.appYellow, AppColors.appYellowLight])),
              child: Container(
                margin: const EdgeInsets.only(left: 20.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '支出',
                        style: TextStyle(
                          color: AppColors.appWhite,
                          fontSize: Adaptor.px(26.0),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: Adaptor.px(6.0), bottom: Adaptor.px(6.0)),
                        child: Text(statisticsStore.compared.totalPay,
                            style: TextStyle(
                                color: AppColors.appWhite,
                                fontSize: Adaptor.px(34.0),
                                fontWeight: FontWeight.w500)),
                      ),
                      Text('比上月多${statisticsStore.compared.totalPayCompare}',
                          style: TextStyle(
                              color: AppColors.appWhite,
                              fontSize: Adaptor.px(26.0))),
                    ]),
              )),
        ),
        Expanded(
            flex: 1,
            child: Container(
                height: Adaptor.px(180.0),
                margin: EdgeInsets.only(
                    left: Adaptor.px(8.0), right: Adaptor.px(8.0)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.appGreenShadow,
                          blurRadius: 8.0,
                          offset: Offset(2.0, 1.0))
                    ],
                    gradient: const LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [AppColors.appGreen, AppColors.appGreenLight])),
                child: Container(
                  margin: const EdgeInsets.only(left: 20.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('收入',
                            style: TextStyle(
                                color: AppColors.appWhite,
                                fontSize: Adaptor.px(26.0))),
                        Padding(
                          padding: EdgeInsets.only(
                              top: Adaptor.px(6.0), bottom: Adaptor.px(6.0)),
                          child: Text(statisticsStore.compared.totalIncome,
                              style: TextStyle(
                                  color: AppColors.appWhite,
                                  fontSize: Adaptor.px(34.0),
                                  fontWeight: FontWeight.w500)),
                        ),
                        Text(
                            '比上月多${statisticsStore.compared.totalIncomeCompare}',
                            style: TextStyle(
                              color: AppColors.appWhite,
                              fontSize: Adaptor.px(26.0),
                            )),
                      ]),
                )))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('首页', style: TextStyle(fontSize: 16.0))),
        body: Observer(builder: (_) {
          return Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: <Widget>[
              _buildIncomePayment(),
              _buildProgress(),
              Container(
                  margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  width: Adaptor.px(1020.0),
                  height: Adaptor.px(80.0),
                  decoration: BoxDecoration(
                      color: AppColors.appWhite,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.appBlackShadow,
                            blurRadius: 5.0,
                            offset: Offset(0, 1.0))
                      ]),
                  child: GestureDetector(
                      onTap: () => _toRecord(context),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(IconFont.iconEdit,
                              size: Adaptor.px(28.0),
                              color: AppColors.appTextNormal),
                          Padding(
                            padding: EdgeInsets.only(left: Adaptor.px(10.0)),
                            child: Text('记一笔',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: AppColors.appTextDark,
                                    fontSize: Adaptor.px(28.0))),
                          )
                        ],
                      ))),
              _buildBills()
            ]),
          );
        }));
  }
}
