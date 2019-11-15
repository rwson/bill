import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';

import '../adaptor.dart';
import '../assets.dart';
import '../colors.dart';
import '../iconfont.dart';
import '../router.dart';

class MethodItem {
  String type;
  String icon;
  String desc;

  MethodItem({
    this.icon,
    this.type,
    this.desc
});
}

class PrecisionLimitFormatter extends TextInputFormatter {
  int _scale;

  PrecisionLimitFormatter(this._scale);

  RegExp exp = new RegExp("[0-9.]");
  static const String POINTER = ".";
  static const String DOUBLE_ZERO = "00";

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return TextEditingValue();
    }

    if (!exp.hasMatch(newValue.text)) {
      return oldValue;
    }

    if (newValue.text.contains(POINTER)) {
      if (newValue.text.indexOf(POINTER) !=
          newValue.text.lastIndexOf(POINTER)) {
        return oldValue;
      }
      String input = newValue.text;
      int index = input.indexOf(POINTER);

      int lengthAfterPointer = input.substring(index, input.length).length - 1;
      if (lengthAfterPointer > _scale) {
        return oldValue;
      }
    } else if (newValue.text.startsWith(POINTER) ||
        newValue.text.startsWith(DOUBLE_ZERO)) {
      return oldValue;
    }
    return newValue;
  }
}

class RecordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RecordState();
}

class RecordState extends State<RecordPage> with SingleTickerProviderStateMixin {

  TabController _tabController;

  TextEditingController _paymentInputController;

  TextEditingController _incomeInputController;

  Color _mainColor = AppColors.appYellow;

  int _currentIndex = 0;

  final int _precision = 2;

  List<MethodItem> payment = [
    MethodItem(
        type: '1',
        icon: Assets.iconSave,
        desc: '存钱'
    ),
    MethodItem(
        type: '2',
        icon: Assets.iconEtc,
        desc: 'ETC'
    ),
    MethodItem(
        type: '3',
        icon: Assets.iconTrafficBill,
        desc: '交通违章'
    ),
    MethodItem(
        type: '4',
        icon: Assets.iconTraffic,
        desc: '交通'
    ),
    MethodItem(
        type: '5',
        icon: Assets.iconCreditCard,
        desc: '信用卡'
    ),
    MethodItem(
        type: '6',
        icon: Assets.iconOffice,
        desc: '学习'
    ),
    MethodItem(
        type: '7',
        icon: Assets.iconStudy,
        desc: '学习'
    ),
    MethodItem(
        type: '8',
        icon: Assets.iconTrip,
        desc: '旅游'
    ),
    MethodItem(
        type: '9',
        icon: Assets.iconOffice,
        desc: '学习'
    ),
    MethodItem(
        type: '10',
        icon: Assets.iconStudy,
        desc: '学习'
    ),
    MethodItem(
        type: '11',
        icon: Assets.iconTrip,
        desc: '旅游'
    ),
  ];
  List<MethodItem> inCome = [];

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
        _mainColor = (_tabController.index == 0) ? AppColors.appYellow : AppColors.appGreen;
        _currentIndex = _tabController.index;

        FlutterStatusbarManager.setColor(_mainColor);
      });
    }
  }

  Widget getPayMenuChild(int index) {

  }

  @override
  void dispose() {
    FlutterStatusbarManager.setColor(AppColors.appWhite);

    _tabController.dispose();

    _paymentInputController.dispose();
    _incomeInputController.dispose();

    super.dispose();
  }

  Widget _buildPayment() {
    return new Container(
      child: new Wrap(
        children: <Widget>[
          new TextField(
            decoration: InputDecoration(
              fillColor: _mainColor,
              contentPadding: EdgeInsets.all(Adaptor.px(20.0)),
              hintText: '请输入金额',
              filled: true,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.appTextDark,
                  width: Adaptor.onePx()
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.appTextDark,
                  width: Adaptor.onePx()
                )
              )
            ),
            inputFormatters: [PrecisionLimitFormatter(_precision)],
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            style: TextStyle(
              fontSize: Adaptor.px(32.0),
              color: AppColors.appTextDark,
            ),
            cursorWidth: 1.0,
            cursorColor: AppColors.appTextDark
          ),
          new Container(
            height: Adaptor.px(20.0),
            decoration: new BoxDecoration(
              color: _mainColor,
            ),
          ),
          new Container(
            margin: EdgeInsets.only(top: Adaptor.px(30)),
            child: new GridView.count(
              shrinkWrap: true,
              crossAxisCount: 4,
              childAspectRatio: 1,
              children: payment.map((MethodItem method) {
                return new Center(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Image.asset(
                        method.icon,
                        width: Adaptor.px(70.0),
                        height: Adaptor.px(70.0)
                      ),
                      new Padding(
                        padding: EdgeInsets.only(top: Adaptor.px(10.0)),
                        child: new Text(
                          method.desc,
                          style: TextStyle(
                            fontSize: Adaptor.px(24.0),
                            color: AppColors.appTextDark
                          )
                        )
                      )
                    ],
                  )
                );
              }).toList(),
            )
          )
        ],
      )
    );
  }

  Widget _buildInCome() {
    return new Container(
    );
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
                  child: new Text(
                      '支出',
                      style: TextStyle(
                        fontSize: Adaptor.px(_currentIndex == 0 ? 36.0 : 32.0),
                        fontWeight: _currentIndex == 0 ? FontWeight.w500 : FontWeight.w400
                      )
                  )
              ),
              Tab(
                child: new Text(
                    '收入',
                    style: TextStyle(
                        fontSize: Adaptor.px(_currentIndex == 1 ? 36.0 : 32.0),
                        fontWeight: _currentIndex == 1 ? FontWeight.w500 : FontWeight.w400
                    )
                )
              )
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            _buildPayment(),
            _buildInCome()
          ],
        ),
      ),
    );
  }
}
