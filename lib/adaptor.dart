// 屏幕适配

import 'dart:ui';

import 'package:flutter/material.dart';

class Adaptor {
  static MediaQueryData mediaQuery = MediaQueryData.fromWindow(window);
  static double _width = mediaQuery.size.width;
  static double _height = mediaQuery.size.height;
  static double _topbarH = mediaQuery.padding.top;
  static double _botbarH = mediaQuery.padding.bottom;
  static double _pixelRatio = mediaQuery.devicePixelRatio;
  static var _ratio;

  static init(int number) {
    int uiWidth = number is int ? number : 750;
    _ratio = _width / uiWidth;
  }

  static double px(double number) {
    if (!(_ratio is double || _ratio is int)) {
      Adaptor.init(750);
    }
    double result = number * _ratio;
    return result;
  }

  static double onePx() {
    return 1 / _pixelRatio;
  }

  static double screenW() {
    return _width;
  }

  static double screenH() {
    return _height;
  }

  static double padTopH() {
    return _topbarH;
  }

  static double padBotH() {
    return _botbarH;
  }
}
