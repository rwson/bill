import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../adaptor.dart';
import '../colors.dart';

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;

  const Indicator({
    Key key,
    this.color,
    this.text,
    this.isSquare,
    this.size = 16,
    this.textColor = const Color(0xff505050),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Container(
          width: size,
          height: size,
          decoration: new BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        new SizedBox(
          width: Adaptor.px(8.0),
        ),
        new Text(
          text,
          style: TextStyle(fontSize: Adaptor.px(24.0), color: textColor),
        )
      ],
    );
  }
}

class AnalysisPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AnalysisState();
}

class AnalysisState extends State<AnalysisPage> {
  int touchedIndex;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('分析',
                style: TextStyle(
                    fontSize: Adaptor.px(32.0), color: AppColors.appTextDark))),
        body: new Container(
            padding: EdgeInsets.only(
                left: Adaptor.px(10.0), right: Adaptor.px(10.0)),
            child: new SingleChildScrollView(
                child: new Container(
                  margin: EdgeInsets.only(
                      top: Adaptor.px(10.0),
                      left: Adaptor.px(10.0),
                      right: Adaptor.px(10.0)),
                  child: new Wrap(children: <Widget>[
                    new Container(
                      padding: EdgeInsets.only(
                          top: Adaptor.px(30.0),
                          left: Adaptor.px(20.0),
                          right: Adaptor.px(20.0)),
                      margin: EdgeInsets.only(
                        top: Adaptor.px(10.0),
                        bottom: Adaptor.px(20.0)
                      ),
                      width: Adaptor.px(1040.0),
                      decoration: new BoxDecoration(
                          color: AppColors.appWhite,
                          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.appBlackShadow, blurRadius: 5.0)
                          ]),
                      child: new Column(
                        children: <Widget>[
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('本周',
                                  style: TextStyle(
                                      color: AppColors.appTextDark,
                                      fontSize: Adaptor.px(28.0))),
                              Text('支出',
                                  style: TextStyle(
                                      color: AppColors.appTextDark,
                                      fontSize: Adaptor.px(28.0))),
                            ],
                          ),
                          AspectRatio(
                            aspectRatio: 1.7,
                            child: Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              color: AppColors.appWhite,
                              child: BarChart(
                                BarChartData(
                                    alignment: BarChartAlignment.spaceAround,
                                    maxY: 20,
                                    barTouchData: BarTouchData(
                                      enabled: false,
                                      touchTooltipData: BarTouchTooltipData(
                                        tooltipBgColor: Colors.transparent,
                                        tooltipBottomMargin: Adaptor.px(8.0),
                                        getTooltipItem: (
                                            BarChartGroupData group,
                                            int groupIndex,
                                            BarChartRodData rod,
                                            int rodIndex,
                                            ) {
                                          return BarTooltipItem(
                                            rod.y.round().toString(),
                                            TextStyle(color: AppColors.appTextDark),
                                          );
                                        },
                                      ),
                                    ),
                                    titlesData: FlTitlesData(
                                      show: true,
                                      bottomTitles: SideTitles(
                                        showTitles: true,
                                        textStyle: TextStyle(
                                            color: AppColors.appTextDark,
                                            fontSize: Adaptor.px(24.0)),
                                        margin: Adaptor.px(40.0),
                                        getTitles: (double value) {
                                          switch (value.toInt()) {
                                            case 0:
                                              return '周一';
                                            case 1:
                                              return '周二';
                                            case 2:
                                              return '周三';
                                            case 3:
                                              return '周四';
                                            case 4:
                                              return '周五';
                                            case 5:
                                              return '周六';
                                            case 6:
                                              return '周日';
                                            default:
                                              return '';
                                          }
                                        },
                                      ),
                                      leftTitles: const SideTitles(showTitles: false),
                                    ),
                                    borderData: FlBorderData(
                                      show: false,
                                    ),
                                    barGroups: [
                                      BarChartGroupData(x: 0, barRods: [
                                        BarChartRodData(y: 8, color: Colors.red)
                                      ], showingTooltipIndicators: [
                                        0
                                      ]),
                                      BarChartGroupData(x: 1, barRods: [
                                        BarChartRodData(
                                            y: 10, color: Colors.lightBlueAccent)
                                      ], showingTooltipIndicators: [
                                        0
                                      ]),
                                      BarChartGroupData(x: 2, barRods: [
                                        BarChartRodData(
                                            y: 14, color: Colors.lightBlueAccent)
                                      ], showingTooltipIndicators: [
                                        0
                                      ]),
                                      BarChartGroupData(x: 3, barRods: [
                                        BarChartRodData(
                                            y: 15, color: Colors.lightBlueAccent)
                                      ], showingTooltipIndicators: [
                                        0
                                      ]),
                                      BarChartGroupData(x: 3, barRods: [
                                        BarChartRodData(
                                            y: 13, color: Colors.lightBlueAccent)
                                      ], showingTooltipIndicators: [
                                        0
                                      ]),
                                      BarChartGroupData(x: 3, barRods: [
                                        BarChartRodData(
                                            y: 10, color: Colors.lightBlueAccent)
                                      ], showingTooltipIndicators: [
                                        0
                                      ]),
                                    ]),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    new Container(
                        width: Adaptor.px(1020.0),
                        padding: EdgeInsets.only(
                            top: Adaptor.px(30.0),
                            left: Adaptor.px(20.0),
                            right: Adaptor.px(20.0)),
                        margin: EdgeInsets.only(
                            bottom: Adaptor.px(20.0)
                        ),
                        decoration: new BoxDecoration(
                            color: AppColors.appWhite,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.appBlackShadow, blurRadius: 5.0)
                            ]),
                        child: new Column(children: <Widget>[
                          new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('本周支出排行榜',
                                    style: TextStyle(
                                        color: AppColors.appTextDark,
                                        fontSize: Adaptor.px(28.0)))
                              ]),
                          new AspectRatio(
                              aspectRatio: 1.5,
                              child: new Container(
                                  color: Colors.white,
                                  child: new Row(children: <Widget>[
                                    SizedBox(
                                      height: Adaptor.px(20.0),
                                    ),
                                    new Expanded(
                                      child: new AspectRatio(
                                        aspectRatio: 1,
                                        child: new PieChart(
                                          new PieChartData(
                                              pieTouchData: new PieTouchData(
                                                  touchCallback: (pieTouchResponse) {
                                                    setState(() {
                                                      if (pieTouchResponse.touchInput
                                                      is FlLongPressEnd ||
                                                          pieTouchResponse.touchInput
                                                          is FlPanEnd) {
                                                        touchedIndex = -1;
                                                      } else {
                                                        touchedIndex = pieTouchResponse
                                                            .touchedSectionIndex;
                                                      }
                                                    });
                                                  }),
                                              borderData: new FlBorderData(
                                                show: false,
                                              ),
                                              sectionsSpace: 0,
                                              centerSpaceRadius: 40,
                                              sections: showingSections()),
                                        ),
                                      ),
                                    ),
                                    new Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Indicator(
                                            color: Color(0xff0293ee),
                                            text: '餐饮',
                                            isSquare: true,
                                          ),
                                          SizedBox(
                                            height: Adaptor.px(8.0),
                                          ),
                                          Indicator(
                                            color: Color(0xfff8b250),
                                            text: '交通',
                                            isSquare: true,
                                          ),
                                          SizedBox(
                                            height: Adaptor.px(8.0),
                                          ),
                                          Indicator(
                                            color: Color(0xff845bef),
                                            text: '网购',
                                            isSquare: true,
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Indicator(
                                            color: Color(0xff13d38e),
                                            text: '话费',
                                            isSquare: true,
                                          ),
                                          SizedBox(
                                            height: Adaptor.px(36.0),
                                          )
                                        ]),
                                    SizedBox(width: Adaptor.px(36.0))
                                  ])))
                        ]))
                  ])
                ))));
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? Adaptor.px(48.0) : Adaptor.px(28.0);
      final double radius = isTouched ? Adaptor.px(120.0) : Adaptor.px(100.0);
      switch (i) {
        case 0:
          return new PieChartSectionData(
            color: const Color(0xff0293ee),
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle:
                TextStyle(fontSize: fontSize, color: const Color(0xffffffff)),
          );
        case 1:
          return new PieChartSectionData(
            color: const Color(0xfff8b250),
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle:
                TextStyle(fontSize: fontSize, color: const Color(0xffffffff)),
          );
        case 2:
          return new PieChartSectionData(
            color: const Color(0xff845bef),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle:
                TextStyle(fontSize: fontSize, color: const Color(0xffffffff)),
          );
        case 3:
          return new PieChartSectionData(
            color: const Color(0xff13d38e),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle:
                TextStyle(fontSize: fontSize, color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }
}
