import 'package:bill/adaptor.dart';
import 'package:bill/colors.dart';
import 'package:bill/stores/statistics.dart';
import 'package:bill/stores/stores.dart';
import 'package:bill/stores/user.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import './tooltip.dart';

class SelectionLineHighlight extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;


  SelectionLineHighlight(this.seriesList, {this.animate});

  factory SelectionLineHighlight.withSampleData() {
    return new SelectionLineHighlight(
      _createSampleData(),
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(
      seriesList,
      animate: animate,
      defaultRenderer: charts.LineRendererConfig(
        includeArea: true,
        includePoints: false,
        includeLine: false,
        stacked: true,
      ),
      behaviors: [
        new charts.LinePointHighlighter(
            symbolRenderer: CustomCircleSymbolRenderer()),
        new charts.SelectNearest(eventTrigger: charts.SelectionTrigger.tapAndDrag)
      ],
      selectionModels: [
        charts.SelectionModelConfig(
            changedListener: (charts.SelectionModel model) {
          if (model.hasDatumSelection) {
            int index = model.selectedSeries[0].measureFn(model.selectedDatum[0].index);
            int len = seriesList.length;

            for (int i = 0; i < len; i ++) {
              charts.Series _tmp = seriesList[i];

              print(_tmp.data.length);
            }

            ToolTipMgr.setTitle({
              'title': '${model.selectedSeries[0].measureFn(model.selectedDatum[0].index)}',
              'subTitle': '111133'
            });
//            print(${model.selectedSeries[0].measureFn(model.selectedDatum[0].datum.year)});
          }
        })
      ]
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 5),
      new LinearSales(1, 25),
      new LinearSales(2, 1000),
      new LinearSales(3, 75),
      new LinearSales(4, 75),
      new LinearSales(6, 100)
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

class PieOutsideLabelChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  PieOutsideLabelChart(this.seriesList, {this.animate});

  /// Creates a [PieChart] with sample data and no transition.
  factory PieOutsideLabelChart.withSampleData() {
    return new PieOutsideLabelChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList,
        animate: animate,
        // Add an [ArcLabelDecorator] configured to render labels outside of the
        // arc with a leader line.
        //
        // Text style for inside / outside can be controlled independently by
        // setting [insideLabelStyleSpec] and [outsideLabelStyleSpec].
        //
        // Example configuring different styles for inside/outside:
        //       new charts.ArcLabelDecorator(
        //          insideLabelStyleSpec: new charts.TextStyleSpec(...),
        //          outsideLabelStyleSpec: new charts.TextStyleSpec(...)),
        defaultRenderer: new charts.ArcRendererConfig(arcRendererDecorators: [
          new charts.ArcLabelDecorator(
              labelPosition: charts.ArcLabelPosition.outside)
        ]));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 10),
      new LinearSales(1, 75),
      new LinearSales(2, 25),
      new LinearSales(3, 5),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
        labelAccessorFn: (LinearSales row, _) => '购物: ￥${row.sales}',
      )
    ];
  }
}

class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}

class AnalysisPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AnalysisState();
}

class AnalysisState extends State<AnalysisPage> {
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
        body: Container(
            padding: EdgeInsets.only(
                left: Adaptor.px(10.0), right: Adaptor.px(10.0)),
            child: SingleChildScrollView(
                child: Container(
                    margin: EdgeInsets.only(
                        top: Adaptor.px(10.0),
                        left: Adaptor.px(10.0),
                        right: Adaptor.px(10.0)),
                    child: Wrap(children: <Widget>[
                      Container(
                        width: Adaptor.px(1060),
                        padding: EdgeInsets.only(bottom: Adaptor.px(40.0)),
                        child: Text('每日支出',
                            style: TextStyle(
                                fontSize: Adaptor.px(28.0),
                                fontWeight: FontWeight.w400,
                                color: AppColors.appTextDark)),
                      ),
                      Container(
                        width: Adaptor.px(1040),
                        height: Adaptor.px(450),
                        child: SelectionLineHighlight(
                            SelectionLineHighlight._createSampleData(),
                            animate: true),
                      ),
                      Container(
                        width: Adaptor.px(1060),
                        padding: EdgeInsets.only(
                            top: Adaptor.px(40.0), bottom: Adaptor.px(40.0)),
                        child: Text('支出分类',
                            style: TextStyle(
                                fontSize: Adaptor.px(28.0),
                                fontWeight: FontWeight.w400,
                                color: AppColors.appTextDark)),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: Adaptor.px(60.0)),
                        width: Adaptor.px(1040),
                        height: Adaptor.px(400),
                        child: PieOutsideLabelChart(
                            PieOutsideLabelChart._createSampleData(),
                            animate: true),
                      )
                    ])))));
  }
}
