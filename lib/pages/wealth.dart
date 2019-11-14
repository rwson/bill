import 'package:flutter/material.dart';

import 'package:flutter_daydart/flutter_daydart.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../iconfont.dart';

class WealthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WealthState();
}

class WealthState extends State<WealthPage> {
  int currentYear = DayDart().year();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 1080, allowFontScaling: true)
      ..init(context);

    return Scaffold(
        appBar: AppBar(title: Text('资产', style: TextStyle(fontSize: 16.0))),
        body: new Container(
            padding: const EdgeInsets.all(8.0),
            child: new SingleChildScrollView(
                child: new Column(children: <Widget>[
              new Wrap(children: <Widget>[
                new Container(
                    width: ScreenUtil.getInstance().setWidth(1040),
                    height: ScreenUtil.getInstance().setHeight(400),
                    decoration: new BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0x77f4b742),
                              blurRadius: 8.0,
                              offset: Offset(2.0, 1.0))
                        ],
                        gradient: const LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                              const Color(0xFFf4b742),
                              const Color(0xFFfed279)
                            ])),
                    child: new Container(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Container(
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                new FlatButton(
                                    onPressed: () => {
                                    },
                                    child: new Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        new Text('$currentYear年',
                                            style: const TextStyle(
                                                color: const Color(0xff393421),
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.normal
                                            )),

                                        new Padding(
                                          padding: const EdgeInsets.only(left: 2.0),
                                          child: new Icon(
                                              IconFont.iconDown,
                                              size: 20,
                                              color: const Color(0xff393421)
                                          ),
                                        )
                                      ],
                                    ))
                              ],
                            )
                          ),
                          new Container(
                            margin:
                                const EdgeInsets.only(bottom: 20.0),
                            child: new Column(children: <Widget>[
                              new Text('全年结余',
                                  style: const TextStyle(
                                      fontSize: 16.0,
                                      color: const Color(0xff393421))),
                              new Text('0',
                                  style: const TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xff393421)))
                            ]),
                          ),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              new Container(
                                  width: ScreenUtil.getInstance().setWidth(518),
                                  decoration: new BoxDecoration(
                                      border: const Border(
                                          right: const BorderSide(
                                              width: 0.5,
                                              color: const Color(0xff393421)))),
                                  child: new Column(
                                    children: <Widget>[
                                      new Text('全年支出',
                                          style: const TextStyle(
                                              fontSize: 14.0,
                                              color: const Color(0xff393421))),
                                      new Text('0.00',
                                          style: const TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xff393421)))
                                    ],
                                  )),
                              new Container(
                                  width: ScreenUtil.getInstance().setWidth(515),
                                  child: new Column(
                                    children: <Widget>[
                                      new Text('全年收入',
                                          style: const TextStyle(
                                              fontSize: 14.0,
                                              color: const Color(0xff393421))),
                                      new Text('0.00',
                                          style: const TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xff393421)))
                                    ],
                                  )),
                            ],
                          )
                        ],
                      ),
                    )),
                new Container(
                    width: ScreenUtil.getInstance().setWidth(1060),
                    margin: const EdgeInsets.only(top: 10.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: new BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0x1E000000), blurRadius: 5.0)
                        ]),
                    child: new Column(children: <Widget>[
                      new Container(
                          width: ScreenUtil.getInstance().setWidth(1040),
                          height: ScreenUtil.getInstance().setWidth(90.0),
                          padding:
                              const EdgeInsets.only(bottom: 10.0, top: 5.0),
                          decoration: new BoxDecoration(
                              border: const Border(
                                  bottom: const BorderSide(
                                      width: 0.5, color: Color(0xffdddddd)))),
                          child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                new Container(
                                  child: new Text('月份'),
                                ),
                                new Container(
                                  child: new Text('收入'),
                                ),
                                new Container(
                                  child: new Text('支出'),
                                ),
                                new Container(
                                  child: new Text('结余'),
                                )
                              ])),
                      new Container(
                          width: ScreenUtil.getInstance().setWidth(1040),
                          height: ScreenUtil.getInstance().setWidth(100.0),
                          padding:
                              const EdgeInsets.only(bottom: 10.0, top: 10.0),
                          decoration: new BoxDecoration(
                              border: const Border(
                                  bottom: const BorderSide(
                                      width: 0.5, color: Color(0xffdddddd)))),
                          child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                new Container(
                                  child: new Text('2019-11'),
                                ),
                                new Container(
                                  child: new Text(
                                    '1000000',
                                    style: const TextStyle(color: Colors.teal),
                                  ),
                                ),
                                new Container(
                                    child: new Text('1000000',
                                        style: const TextStyle(
                                            color: Colors.redAccent))),
                                new Container(
                                  child: new Text('800000'),
                                ),
                              ]))
                    ]))
              ])
            ]))));
  }
}
