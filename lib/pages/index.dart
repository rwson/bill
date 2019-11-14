import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../assets.dart';
import '../iconfont.dart';
import '../colors.dart';

class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<IndexPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 1080, allowFontScaling: true)
      ..init(context);

    return Scaffold(
        appBar: AppBar(title: Text('首页', style: TextStyle(fontSize: 16.0))),
        body: new Container(
            padding: const EdgeInsets.all(8.0),
            child: new Column(children: <Widget>[
              new Wrap(
                children: <Widget>[
                  new Container(
                      width: ScreenUtil.getInstance().setWidth(504),
                      height: ScreenUtil.getInstance().setHeight(260),
                      decoration: new BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0)),
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.appYellowShadow,
                                blurRadius: 8.0,
                                offset: Offset(2.0, 1.0))
                          ],
                          gradient: const LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [
                                AppColors.appYellow,
                                AppColors.appYellowLight
                              ]
                          )),
                      child: new Container(
                        margin: const EdgeInsets.only(left: 20.0),
                        child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text(
                                '支出',
                                style: const TextStyle(
                                  color: const Color(0xFFFFFFFF),
                                  fontSize: 14.0,
                                ),
                              ),
                              new Padding(
                                padding: const EdgeInsets.only(
                                    top: 3.0, bottom: 3.0),
                                child: new Text('100.00',
                                    style: const TextStyle(
                                        color: const Color(0xFFFFFFFF),
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w500)),
                              ),
                              new Text('比上月多100000',
                                  style: const TextStyle(
                                    color: const Color(0xFFFFFFFF),
                                    fontSize: 14.0,
                                  )),
                            ]),
                      )),
                  new Container(
                      width: ScreenUtil.getInstance().setWidth(504),
                      height: ScreenUtil.getInstance().setHeight(260),
                      margin: const EdgeInsets.only(left: 8.0),
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          boxShadow: [
                            BoxShadow(
                                color: const Color(0x7703c789),
                                blurRadius: 8.0,
                                offset: Offset(2.0, 1.0))
                          ],
                          gradient: const LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [
                                const Color(0xFF03c789),
                                const Color(0xFF47e48b)
                              ])),
                      child: new Container(
                        margin: const EdgeInsets.only(left: 20.0),
                        child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text(
                                '收入',
                                style: const TextStyle(
                                    color: const Color(0xFFFFFFFF),
                                    fontSize: 14.0),
                              ),
                              new Padding(
                                padding: const EdgeInsets.only(
                                    top: 3.0, bottom: 3.0),
                                child: new Text('100.00',
                                    style: const TextStyle(
                                        color: const Color(0xFFFFFFFF),
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w500)),
                              ),
                              new Text('比上月多100000',
                                  style: const TextStyle(
                                    color: const Color(0xFFFFFFFF),
                                    fontSize: 14.0,
                                  )),
                            ]),
                      )),
                ],
              ),
              new Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  width: ScreenUtil.getInstance().setWidth(1020),
                  padding: const EdgeInsets.all(10.0),
                  decoration: new BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0x1E000000), blurRadius: 5.0)
                      ]),
                  child: new Wrap(children: <Widget>[
                    new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Text(
                            '本月预算',
                            style: const TextStyle(
                                color: const Color(0xFF666666), fontSize: 16.0),
                          ),
                          new Text('设置预算')
                        ]),
                    new Container(
                      margin: const EdgeInsets.only(top: 6.0),
                      child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Text('￥100'),
                            new Text('￥100000')
                          ]),
                    ),
                    new LinearPercentIndicator(
                        width: ScreenUtil.getInstance().setWidth(960),
                        animation: true,
                        lineHeight: 8.0,
                        animationDuration: 2000,
                        percent: 0.01,
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: const Color(0xFFfed279))
                  ])),
              new Container(
                  margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  width: ScreenUtil.getInstance().setWidth(1020),
                  height: ScreenUtil.getInstance().setHeight(120),
                  decoration: new BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0x1E000000), blurRadius: 5.0)
                      ]),
                  child: new FlatButton(
                      onPressed: () => {},
                      child: new Wrap(
                        children: <Widget>[
                          new Icon(IconFont.iconEdit,
                              size: 16.0, color: const Color(0xFF666666)),
                          new Text('记一笔',
                              style: const TextStyle(
                                  color: const Color(0xFF666666)))
                        ],
                      ))),
              new Container(
                  child: Expanded(
                      child: new ListView(children: <Widget>[
                new Container(
                    margin: const EdgeInsets.only(
                        left: 3.0, right: 3.0, bottom: 5.0, top: 1.0),
                    padding: const EdgeInsets.all(8.0),
                    decoration: new BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0x1E000000), blurRadius: 5.0)
                        ]),
                    child: new Wrap(children: <Widget>[
                      new Container(
                          padding: const EdgeInsets.only(top: 5.0, bottom: 8.0),
                          decoration: new BoxDecoration(
                              border: const Border(
                            bottom: const BorderSide(
                                width: 0.5, color: Color(0xffdddddd)),
                          )),
                          child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Text('2019-11-12',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: const Color(0xFF666666))),
                                new Text('支出7.50',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: const Color(0xFF666666))),
                              ])),
                      new Wrap(children: <Widget>[
                        new Container(
                            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                            decoration: new BoxDecoration(
                                border: const Border(
                              bottom: const BorderSide(
                                  width: 0.5, color: Color(0xffdddddd)),
                            )),
                            child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  new Column(children: <Widget>[
                                    new Row(children: <Widget>[
                                      new Image.asset(
                                        Assets.iconSave,
                                        width: 45,
                                        height: 45,
                                      ),
                                      new Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                new Text('交通',
                                                    style: const TextStyle(
                                                        fontSize: 16.0,
                                                        color: const Color(
                                                            0xFF333333))),
                                                new Text('地铁',
                                                    style: const TextStyle(
                                                        fontSize: 12.0,
                                                        color: const Color(
                                                            0xFF333333)))
                                              ]))
                                    ])
                                  ]),
                                  new Text('3.00',
                                      style: const TextStyle(
                                        fontSize: 20.0,
                                        color: const Color(0xFFff6a6a),
                                      ))
                                ])),
                        new Container(
                            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  new Column(children: <Widget>[
                                    new Row(children: <Widget>[
                                      new Image.asset(
                                        Assets.iconSave,
                                        width: 45,
                                        height: 45,
                                      ),
                                      new Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                new Text('交通',
                                                    style: const TextStyle(
                                                        fontSize: 16.0,
                                                        color: const Color(
                                                            0xFF333333))),
                                                new Text('地铁',
                                                    style: const TextStyle(
                                                        fontSize: 12.0,
                                                        color: const Color(
                                                            0xFF333333)))
                                              ]))
                                    ])
                                  ]),
                                  new Text('3.00',
                                      style: const TextStyle(
                                        fontSize: 20.0,
                                        color: const Color(0xFFff6a6a),
                                      ))
                                ]))
                      ])
                    ])),
                new Container(
                    margin: const EdgeInsets.only(
                        left: 3.0, right: 3.0, top: 5.0, bottom: 5.0),
                    padding: const EdgeInsets.all(8.0),
                    decoration: new BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0x1E000000), blurRadius: 5.0)
                        ]),
                    child: new Wrap(children: <Widget>[
                      new Container(
                          padding: const EdgeInsets.only(top: 5.0, bottom: 8.0),
                          decoration: new BoxDecoration(
                              border: const Border(
                            bottom: const BorderSide(
                                width: 0.5, color: Color(0xffdddddd)),
                          )),
                          child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Text('2019-11-12',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: const Color(0xFF666666))),
                                new Text('支出7.50',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: const Color(0xFF666666))),
                              ])),
                      new Wrap(children: <Widget>[
                        new Container(
                            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                            decoration: new BoxDecoration(
                                border: const Border(
                              bottom: const BorderSide(
                                  width: 0.5, color: Color(0xffdddddd)),
                            )),
                            child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  new Column(children: <Widget>[
                                    new Row(children: <Widget>[
                                      new Image.asset(
                                        Assets.iconSave,
                                        width: 45,
                                        height: 45,
                                      ),
                                      new Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                new Text('交通',
                                                    style: const TextStyle(
                                                        fontSize: 16.0,
                                                        color: const Color(
                                                            0xFF333333))),
                                                new Text('地铁',
                                                    style: const TextStyle(
                                                        fontSize: 12.0,
                                                        color: const Color(
                                                            0xFF333333)))
                                              ]))
                                    ])
                                  ]),
                                  new Text('3.00',
                                      style: const TextStyle(
                                        fontSize: 20.0,
                                        color: const Color(0xFFff6a6a),
                                      ))
                                ])),
                        new Container(
                            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  new Column(children: <Widget>[
                                    new Row(children: <Widget>[
                                      new Image.asset(
                                        Assets.iconSave,
                                        width: 45,
                                        height: 45,
                                      ),
                                      new Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                new Text('交通',
                                                    style: const TextStyle(
                                                        fontSize: 16.0,
                                                        color: const Color(
                                                            0xFF333333))),
                                                new Text('地铁',
                                                    style: const TextStyle(
                                                        fontSize: 12.0,
                                                        color: const Color(
                                                            0xFF333333)))
                                              ]))
                                    ])
                                  ]),
                                  new Text('3.00',
                                      style: const TextStyle(
                                        fontSize: 20.0,
                                        color: const Color(0xFFff6a6a),
                                      ))
                                ]))
                      ])
                    ]))
              ])))
            ])));
  }
}
