import 'dart:math';

import 'package:bill/adaptor.dart';
import 'package:bill/colors.dart';
import 'package:bill/methods-icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CircleItem {
  String type;
  IconData icon;
  String desc;
  bool checked;

  CircleItem({this.icon, this.type, this.desc, this.checked});
}

class CreateGroupPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CreateGroupState();
}

class CreateGroupState extends State<CreateGroupPage> {
  final _nameController = TextEditingController();

  final FocusNode _focus = FocusNode();

  List<CircleItem> _circleItems = [];

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    MethodsIcons.circleTypes.forEach((item) => {
          _circleItems.add(CircleItem(
              checked: false,
              icon: item.icon,
              desc: item.desc,
              type: item.type))
        });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('添加记账圈子',
                style: TextStyle(
                    fontSize: Adaptor.px(32.0), color: AppColors.appTextDark))),
        body: new Container(
            margin: EdgeInsets.all(Adaptor.px(10.0)),
            padding: EdgeInsets.only(
                left: Adaptor.px(10.0), right: Adaptor.px(10.0)),
            decoration: new BoxDecoration(color: AppColors.appWhite),
            width: Adaptor.px(1060.0),
            child: new Wrap(
              children: <Widget>[
                new Container(
                  height: Adaptor.px(380),
                  child: new Swiper(
                      index: _currentIndex,
                      loop: false,
                      autoplay: false,
                      itemCount: (MethodsIcons.circleTypesLength / 8).ceil(),
                      itemBuilder: (context, index) {
                        List _subRow = _circleItems.sublist(
                            (index * 8),
                            min((index + 1) * 8,
                                MethodsIcons.circleTypesLength));
                        return new Container(
                            child: new Wrap(
                                children:
                                    List.generate(_subRow.length, (int i) {
                          CircleItem _item = _subRow[i];
                          return new Container(
                            width: Adaptor.px(177.0),
                            height: Adaptor.px(170.0),
                            child: new FlatButton(
                                onPressed: () {
                                  int position = (index * 8) + i;
                                  setState(() {
                                    _currentIndex = index;
                                    _circleItems
                                        .asMap()
                                        .keys
                                        .forEach((int cur) => {
                                              if (cur == position)
                                                {
                                                  _circleItems[cur].checked =
                                                      true
                                                }
                                              else
                                                {
                                                  _circleItems[cur].checked =
                                                      false
                                                }
                                            });
                                  });
                                },
                                child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Container(
                                          width: Adaptor.px(100),
                                          height: Adaptor.px(100),
                                          margin: EdgeInsets.only(
                                              bottom: Adaptor.px(10.0)),
                                          decoration: new BoxDecoration(
                                              color: _item.checked
                                                  ? AppColors.appYellow
                                                  : AppColors.appBorder,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      Adaptor.px(50)))),
                                          child: new Icon(
                                            _item.icon,
                                            size: Adaptor.px(50.0),
                                            color: AppColors.appTextDark,
                                          )),
                                      new Text(_item.desc,
                                          style: TextStyle(
                                              fontSize: Adaptor.px(24.0),
                                              color: AppColors.appTextDark))
                                    ])),
                          );
                        }).toList()));
                      },
                      pagination: new SwiperPagination(
                          alignment: Alignment.bottomCenter,
                          builder: new RectSwiperPaginationBuilder(
                              color: AppColors.appBorder,
                              activeColor: AppColors.appYellow,
                              size: Size(18, 3),
                              activeSize: Size(18, 3),
                              space: 0.2)),
                      scrollDirection: Axis.horizontal),
                ),
                new Container(
                  width: Adaptor.px(1060.0),
                  height: Adaptor.px(80.0),
                  padding: EdgeInsets.only(
                      left: Adaptor.px(16.0), right: Adaptor.px(16.0)),
                  margin: EdgeInsets.only(
                      left: Adaptor.px(10.0), right: Adaptor.px(10.0)),
                  decoration: new BoxDecoration(
                      color: AppColors.appWhite,
                      border: Border(
                          bottom: BorderSide(
                              width: Adaptor.onePx(),
                              color: AppColors.appBorder))),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text('圈子名称',
                          style: TextStyle(
                              color: AppColors.appTextDark,
                              fontSize: Adaptor.px(24.0))),
                      new Expanded(
                          flex: 1,
                          child: new Container(
                              child: new TextField(
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          right: Adaptor.px(6.0)),
                                      hintText: '请输入圈子名称',
                                      fillColor: Colors.transparent,
                                      filled: true,
                                      border: InputBorder.none),
                                  autocorrect: false,
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(
                                    fontSize: Adaptor.px(24.0),
                                    color: AppColors.appTextDark,
                                  ),
                                  cursorWidth: 1.0,
                                  cursorColor: AppColors.appTextDark,
                                  textAlign: TextAlign.right,
                                  focusNode: _focus,
                                  controller: _nameController)))
                    ],
                  ),
                ),
                new Container(
                    width: Adaptor.px(1000.0),
                    height: Adaptor.px(80.0),
                    padding: EdgeInsets.only(
                        left: Adaptor.px(16.0), right: Adaptor.px(16.0)),
                    margin: EdgeInsets.only(
                        top: Adaptor.px(40.0),
                        left: Adaptor.px(10.0),
                        right: Adaptor.px(10.0)),
                    decoration: new BoxDecoration(
                        color: AppColors.appYellow,
                        borderRadius: BorderRadius.all(
                            Radius.circular(Adaptor.px(10.0)))),
                    child: new FlatButton(
                        onPressed: () {},
                        child: new Text('确定',
                            style: TextStyle(
                                fontSize: Adaptor.px(32.0),
                                fontWeight: FontWeight.normal,
                                color: AppColors.appTextDark))))
              ],
            )));
  }
}
