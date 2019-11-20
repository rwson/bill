import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../adaptor.dart';
import '../colors.dart';
import '../iconfont.dart';
import '../methods-icons.dart';
import '../util.dart';

class RecordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RecordState();
}

class RecordState extends State<RecordPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  TextEditingController _paymentInputController;

  TextEditingController _incomeInputController;

  Color _mainColor = AppColors.appYellow;

  int _currentIndex = 0;

  final int _precision = 2;

//  int _paymentLength = MethodsIcons.paymentIcons.length;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 2);
    _tabController..addListener(_handleTabChange);

    _paymentInputController = TextEditingController();
    _incomeInputController = TextEditingController();
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _currentIndex = _tabController.index;
        _mainColor = (_tabController.index == 0)
            ? AppColors.appYellow
            : AppColors.appGreen;

        FlutterStatusbarManager.setColor(_mainColor);
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
                fontSize: Adaptor.px(24.0), color: AppColors.appTextDark)));
  }

  @override
  void dispose() {
    FlutterStatusbarManager.setColor(AppColors.appWhite);

    _tabController.dispose();

    _paymentInputController.dispose();
    _incomeInputController.dispose();

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
            height: Adaptor.px(330.0),
            child: new Swiper(
              index: 0,
              loop: false,
              itemBuilder: (context, index) {
                List firstRow = [];
                for (var i = (index * 2) * 4; i < (index * 2) * 4 + 4; ++i) {
                  if (i >= MethodsIcons.paymentIcons.length) {
                    break;
                  }
                  firstRow.add(MethodsIcons.paymentIcons[i]);
                }

                List secondRow = [];
                for (var i = (index * 2 + 1) * 4;
                    i < (index * 2 + 1) * 4 + 4;
                    ++i) {
                  //0-4,5-9,10-14,15-19
                  if (i >= MethodsIcons.paymentIcons.length) {
                    break;
                  }
                  secondRow.add(MethodsIcons.paymentIcons[i]);
                }

                return new Column(children: <Widget>[
                  new Container(
                      padding: EdgeInsets.only(top: 10.0),
                      child: new Row(
                        children: firstRow.map((item) {
                          return new Container(
                              width: Adaptor.screenW() / 4,
                              child: new FlatButton(
                                  onPressed: () => {print(item)},
                                  child: new Column(
                                    children: <Widget>[
                                      new Container(
                                          width: Adaptor.px(80),
                                          height: Adaptor.px(80),
                                          margin: EdgeInsets.only(
                                              bottom: Adaptor.px(10.0)),
                                          decoration: new BoxDecoration(
//                                          color: AppColors.appBorder,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      Adaptor.px(40)))),
                                          child: new Icon(
                                            item.icon,
                                            size: Adaptor.px(56.0),
                                            color: AppColors.appTextDark,
                                          )),
                                      new Text(item.desc,
                                          style: TextStyle(
                                              fontSize: Adaptor.px(24.0),
                                              color: AppColors.appTextDark))
                                    ],
                                  )));
                        }).toList(),
                      )),
                  new Container(
                      padding: EdgeInsets.only(top: 10.0),
                      child: new Row(
                        children: secondRow.map((item) {
                          return new Container(
                              width: Adaptor.screenW() / 4,
                              child: new Column(
                                children: <Widget>[
                                  new Container(
                                      width: Adaptor.px(80),
                                      height: Adaptor.px(80),
                                      margin: EdgeInsets.only(
                                          bottom: Adaptor.px(10.0)),
                                      decoration: new BoxDecoration(
                                          color: AppColors.appYellow,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(Adaptor.px(40)))),
                                      child: new Icon(
                                        item.icon,
                                        size: Adaptor.px(56.0),
                                        color: AppColors.appTextDark,
                                      )),
                                  new Text(item.desc,
                                      style: TextStyle(
                                          fontSize: Adaptor.px(24.0),
                                          color: AppColors.appTextDark))
                                ],
                              ));
                        }).toList(),
                      ))
                ]);
              },
              itemCount: (MethodsIcons.paymentLength ~/ 8).toInt() +
                  (MethodsIcons.paymentLength % 8 > 0 ? 1 : 0),
              pagination: new SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  builder: new RectSwiperPaginationBuilder(
                      color: AppColors.appBorder,
                      activeColor: AppColors.appYellow,
                      size: Size(18, 3),
                      activeSize: Size(18, 3),
                      space: 0.2)),
              autoplay: false,
              duration: 300,
              scrollDirection: Axis.horizontal,
            )),
        new Container(
          padding: EdgeInsets.only(
              top: Adaptor.px(16.0),
              bottom: Adaptor.px(16.0),
              left: Adaptor.px(20.0),
              right: Adaptor.px(32.0)),
          height: Adaptor.px(80.0),
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
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Icon(
                        IconFont.iconCalendar,
                        size: Adaptor.px(28.0),
                        color: AppColors.appTextDark,
                      ),
                      new Padding(
                        padding: EdgeInsets.only(left: Adaptor.px(10.0)),
                        child: new Text(
                          '记账日期',
                          style: TextStyle(
                            fontSize: Adaptor.px(26.0),
                            color: AppColors.appTextDark,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                new Row(
                  children: <Widget>[
                    new FlatButton(
                        onPressed: () => _showDatePicker(''),
                        child: new Text('2019-11-18',
                            style: TextStyle(
                                color: AppColors.appTextDark,
                                fontSize: Adaptor.px(24.0),
                                fontWeight: FontWeight.normal)))
                  ],
                )
              ]),
        ),
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
