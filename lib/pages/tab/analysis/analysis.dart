import 'package:bill/adaptor.dart';
import 'package:bill/colors.dart';
import 'package:bill/iconfont.dart';
import 'package:bill/stores/statistics.dart';
import 'package:bill/stores/stores.dart';
import 'package:bill/stores/user.dart';
import 'package:flutter/material.dart';
import 'package:bill/bean/statistics.dart';
import 'package:bill/methods-icons.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_daydart/flutter_daydart.dart';

class AnalysisPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AnalysisState();
}

class AnalysisState extends State<AnalysisPage>
    with SingleTickerProviderStateMixin {
  final UserStore userStore = AppStores.userStore;

  final StatisticsStore statisticsStore = AppStores.statisticsStore;

  TabController _tabController;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 3);
    _tabController..addListener(_handleTabChange);

    _initPage();
  }

  @override
  void deactivate() {
    super.deactivate();
    bool current = ModalRoute.of(context).isCurrent;
    if (current) {
      _initPage();
    }
  }

  void _initPage() async {
    if (userStore.logined) {
      statisticsStore.getMonthAnalysis();
    }
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _currentIndex = _tabController.index;
      });
    }
  }

  Widget _buildWeeklyView() {
    return SingleChildScrollView(
        child: Container(
            child: Wrap(children: <Widget>[
      Container(
        margin: EdgeInsets.only(
            top: Adaptor.px(20.0),
            left: Adaptor.px(20.0),
            right: Adaptor.px(20.0)),
        width: Adaptor.px(1020),
        padding: EdgeInsets.all(Adaptor.px(20.0)),
        decoration: BoxDecoration(
            color: AppColors.appWhite,
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            boxShadow: [
              BoxShadow(
                  color: AppColors.appBlackShadow,
                  blurRadius: 5.0,
                  offset: Offset(0, 1.0))
            ]),
        child: Wrap(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('本周',
                    style: TextStyle(
                        color: AppColors.appTextDark,
                        fontSize: Adaptor.px(28.0),
                        fontWeight: FontWeight.normal)),
                GestureDetector(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('支出',
                          style: TextStyle(
                              color: AppColors.appTextDark,
                              fontSize: Adaptor.px(28.0),
                              fontWeight: FontWeight.normal)),
                      Padding(
                        padding: EdgeInsets.only(left: Adaptor.px(4.0)),
                        child: Icon(IconFont.iconDown,
                            size: Adaptor.px(16.0),
                            color: AppColors.appTextDark),
                      )
                    ],
                  ),
                )
              ],
            ),
            Container()
          ],
        ),
      ),
      Container(
          margin: EdgeInsets.only(
              top: Adaptor.px(20.0),
              left: Adaptor.px(20.0),
              right: Adaptor.px(20.0)),
          width: Adaptor.px(1020),
          padding: EdgeInsets.all(Adaptor.px(20.0)),
          decoration: BoxDecoration(
              color: AppColors.appWhite,
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              boxShadow: [
                BoxShadow(
                    color: AppColors.appBlackShadow,
                    blurRadius: 5.0,
                    offset: Offset(0, 1.0))
              ]),
          child: Wrap(
            children: <Widget>[
              Text('支出排行榜',
                  style: TextStyle(
                      color: AppColors.appTextDark,
                      fontSize: Adaptor.px(28.0),
                      fontWeight: FontWeight.normal))
            ],
          ))
    ])));
  }

  Widget _buildMonthlyView() {
    return SingleChildScrollView(
        child: Container(
            child: Wrap(children: <Widget>[
      Container(
        margin: EdgeInsets.only(
            top: Adaptor.px(20.0),
            left: Adaptor.px(20.0),
            right: Adaptor.px(20.0)),
        width: Adaptor.px(1020),
        padding: EdgeInsets.all(Adaptor.px(20.0)),
        decoration: BoxDecoration(
            color: AppColors.appWhite,
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            boxShadow: [
              BoxShadow(
                  color: AppColors.appBlackShadow,
                  blurRadius: 5.0,
                  offset: Offset(0, 1.0))
            ]),
        child: Wrap(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('本月',
                    style: TextStyle(
                        color: AppColors.appTextDark,
                        fontSize: Adaptor.px(28.0),
                        fontWeight: FontWeight.normal)),
                GestureDetector(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('支出',
                          style: TextStyle(
                              color: AppColors.appTextDark,
                              fontSize: Adaptor.px(28.0),
                              fontWeight: FontWeight.normal)),
                      Padding(
                        padding: EdgeInsets.only(left: Adaptor.px(4.0)),
                        child: Icon(IconFont.iconDown,
                            size: Adaptor.px(16.0),
                            color: AppColors.appTextDark),
                      )
                    ],
                  ),
                )
              ],
            ),
            Container()
          ],
        ),
      ),
      Container(
          margin: EdgeInsets.only(
              top: Adaptor.px(20.0),
              left: Adaptor.px(20.0),
              right: Adaptor.px(20.0)),
          width: Adaptor.px(1020),
          padding: EdgeInsets.all(Adaptor.px(20.0)),
          decoration: BoxDecoration(
              color: AppColors.appWhite,
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              boxShadow: [
                BoxShadow(
                    color: AppColors.appBlackShadow,
                    blurRadius: 5.0,
                    offset: Offset(0, 1.0))
              ]),
          child: Wrap(
            children: <Widget>[
              Text('支出排行榜',
                  style: TextStyle(
                      color: AppColors.appTextDark,
                      fontSize: Adaptor.px(28.0),
                      fontWeight: FontWeight.normal))
            ],
          ))
    ])));
  }

  Widget _buildYearlyView() {
    return SingleChildScrollView(
        child: Container(
            child: Wrap(children: <Widget>[
      Container(
        margin: EdgeInsets.only(
            top: Adaptor.px(20.0),
            left: Adaptor.px(20.0),
            right: Adaptor.px(20.0)),
        width: Adaptor.px(1020),
        padding: EdgeInsets.all(Adaptor.px(20.0)),
        decoration: BoxDecoration(
            color: AppColors.appWhite,
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            boxShadow: [
              BoxShadow(
                  color: AppColors.appBlackShadow,
                  blurRadius: 5.0,
                  offset: Offset(0, 1.0))
            ]),
        child: Wrap(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('本月',
                    style: TextStyle(
                        color: AppColors.appTextDark,
                        fontSize: Adaptor.px(28.0),
                        fontWeight: FontWeight.normal)),
                GestureDetector(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('支出',
                          style: TextStyle(
                              color: AppColors.appTextDark,
                              fontSize: Adaptor.px(28.0),
                              fontWeight: FontWeight.normal)),
                      Padding(
                        padding: EdgeInsets.only(left: Adaptor.px(4.0)),
                        child: Icon(IconFont.iconDown,
                            size: Adaptor.px(16.0),
                            color: AppColors.appTextDark),
                      )
                    ],
                  ),
                )
              ],
            ),
            Container()
          ],
        ),
      ),
      Container(
          margin: EdgeInsets.only(
              top: Adaptor.px(20.0),
              left: Adaptor.px(20.0),
              right: Adaptor.px(20.0)),
          width: Adaptor.px(1020),
          padding: EdgeInsets.all(Adaptor.px(20.0)),
          decoration: BoxDecoration(
              color: AppColors.appWhite,
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              boxShadow: [
                BoxShadow(
                    color: AppColors.appBlackShadow,
                    blurRadius: 5.0,
                    offset: Offset(0, 1.0))
              ]),
          child: Wrap(
            children: <Widget>[
              Text('支出排行榜',
                  style: TextStyle(
                      color: AppColors.appTextDark,
                      fontSize: Adaptor.px(28.0),
                      fontWeight: FontWeight.normal))
            ],
          ))
    ])));
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              title: Text('分析',
                  style: TextStyle(
                      fontSize: Adaptor.px(32.0),
                      color: AppColors.appTextDark)),
              bottom: TabBar(
                controller: _tabController,
                indicatorColor: Colors.transparent,
                tabs: <Widget>[
                  Tab(
                      child: Text('周',
                          style: TextStyle(
                              color: _currentIndex == 0
                                  ? AppColors.appYellow
                                  : AppColors.appTextDark,
                              fontSize:
                                  Adaptor.px(_currentIndex == 0 ? 32.0 : 28.0),
                              fontWeight: _currentIndex == 0
                                  ? FontWeight.w500
                                  : FontWeight.w400))),
                  Tab(
                      child: Text('月',
                          style: TextStyle(
                              color: _currentIndex == 1
                                  ? AppColors.appYellow
                                  : AppColors.appTextDark,
                              fontSize:
                                  Adaptor.px(_currentIndex == 1 ? 32.0 : 28.0),
                              fontWeight: _currentIndex == 1
                                  ? FontWeight.w500
                                  : FontWeight.w400))),
                  Tab(
                      child: Text('年',
                          style: TextStyle(
                              color: _currentIndex == 2
                                  ? AppColors.appYellow
                                  : AppColors.appTextDark,
                              fontSize:
                                  Adaptor.px(_currentIndex == 2 ? 32.0 : 28.0),
                              fontWeight: _currentIndex == 2
                                  ? FontWeight.w500
                                  : FontWeight.w400))),
                ],
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[_buildWeeklyView(), _buildMonthlyView(), _buildYearlyView()],
            )));
  }
}
