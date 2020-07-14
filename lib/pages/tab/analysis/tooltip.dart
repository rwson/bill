import 'dart:math';

import 'package:bill/adaptor.dart';

import 'package:charts_flutter/flutter.dart';
import 'package:charts_flutter/src/text_element.dart' as ChartText;
import 'package:charts_flutter/src/text_style.dart' as ChartStyle;

import 'package:flutter/material.dart';

String _title;

String _subTitle;

class ToolTipMgr {
  static String get title => _title;

  static String get subTitle => _subTitle;

  static setTitle(Map<String, dynamic> data) {
    if (data['title'] != null && data['title'].length > 0) {
      _title = data['title'];
    }

    if (data['subTitle'] != null && data['subTitle'].length > 0) {
      _subTitle = data['subTitle'];
    }
  }
}

class CustomCircleSymbolRenderer extends CircleSymbolRenderer {
  double maxLeft = Adaptor.px(1060);

  @override
  void paint(ChartCanvas canvas, Rectangle<num> bounds,
      {List<int> dashPattern,
      Color fillColor,
      FillPatternType fillPattern,
      Color strokeColor,
      double strokeWidthPx}) {
    super.paint(canvas, bounds,
        dashPattern: dashPattern,
        fillColor: fillColor,
        strokeColor: strokeColor,
        strokeWidthPx: strokeWidthPx);

    String title = ToolTipMgr.title;

    String subTitle = ToolTipMgr.subTitle;

    // print(title);
    // print(subTitle);

    if (title != null && title.length > 0 && subTitle != null && subTitle.length > 0) {


      double top = -4;
      int titleFontSize = Adaptor.px(24).round();
      int subTitleFontSize = Adaptor.px(18).round();
      int titleWidth = (title.length * titleFontSize / 2).round();
      int subTitleWidth = (subTitle.length * subTitleFontSize / 2).round();

      int maxWidth = titleWidth;
      int left = bounds.left.ceil();

      int _titleLeft;
      int _subTitleLeft;

      if (subTitleWidth > maxWidth) {
        maxWidth = subTitleWidth;
      }

      _titleLeft = left + (((maxWidth - titleWidth) / 2)).round();
      _subTitleLeft = left + (((maxWidth - subTitleWidth) / 2)).round();

      canvas.drawRRect(
          Rectangle(left, top, maxWidth + 10, 26),
          fill: MaterialPalette.blue.shadeDefault,
          radius: Adaptor.px(6.0),
          roundTopLeft: true,
          roundBottomLeft: true,
          roundTopRight: true,
          roundBottomRight: true
          );

      ChartStyle.TextStyle titleTextStyle = ChartStyle.TextStyle();
      titleTextStyle.color = Color.white;
      titleTextStyle.fontSize = Adaptor.px(24).toInt();
      canvas.drawText(ChartText.TextElement(title, style: titleTextStyle), _titleLeft + 8, (top + 3).round());

      ChartStyle.TextStyle subTitleTextStyle = ChartStyle.TextStyle();
      subTitleTextStyle.color = Color.white;
      subTitleTextStyle.fontSize = Adaptor.px(18).toInt();
      canvas.drawText(ChartText.TextElement(subTitle, style: subTitleTextStyle), _subTitleLeft, (top + 15).round());
    }
  }
}
