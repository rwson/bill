import 'package:bill/adaptor.dart';
import 'package:bill/colors.dart';
import 'package:bill/methods-icons.dart';
import 'package:bill/router.dart';
import 'package:bill/stores/group.dart';
import 'package:bill/stores/stores.dart';
import 'package:bill/stores/user.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class GroupDetailPage extends StatefulWidget {
  GroupDetailPage({@required this.id});

  final String id;

  @override
  State<StatefulWidget> createState() => GroupDetailState();
}

class GroupDetailState extends State<GroupDetailPage> {
  final GroupStore groupStote = AppStores.groupStote;

  final UserStore userStore = AppStores.userStore;

  AppLifecycleState appLifecycleState;

  @override
  void initState() {
    super.initState();
    groupStote.getDetail(widget.id);
  }

  @override
  void deactivate() {
    super.deactivate();
    bool current = ModalRoute.of(context).isCurrent;
    if (current) {
      groupStote.getDetail(widget.id);
    }
  }

  Future<void> _disband() async {
    // bool deleteSuccess = await reminderStore.deleteReminder(widget.id);
    // if (deleteSuccess) {
    //   AppRouter.back(context);
    // }
  }

  Future<void> _exit() async {
    // bool deleteSuccess = await reminderStore.deleteReminder(widget.id);
    // if (deleteSuccess) {
    //   AppRouter.back(context);
    // }
  }

  void _disbandGroup() {
    BotToast.showAnimationWidget(
      onlyOne: true,
      backgroundColor: Colors.black26,
      animationDuration: Duration(milliseconds: 300),
      toastBuilder: (cancelFunc) => AlertDialog(
        title: Text('您确定要解散此记账圈子吗?',
            style: TextStyle(
                fontSize: Adaptor.px(32.0), color: AppColors.appTextDark)),
        content: Padding(
            padding: EdgeInsets.only(top: Adaptor.px(20.0)),
            child: Text('解散后当前圈子里的用户账单将被转移至各自的个人记账圈子下',
                style: TextStyle(
                    fontSize: Adaptor.px(26.0), color: AppColors.appTextDark))),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              cancelFunc();
            },
            highlightColor: const Color(0x55FF8A80),
            splashColor: const Color(0x99FF8A80),
            child: const Text(
              '取消',
              style: TextStyle(color: AppColors.appWarning),
            ),
          ),
          FlatButton(
            onPressed: () {
              cancelFunc();
              _disband();
            },
            child: const Text(
              '确定',
              style: TextStyle(color: AppColors.appDanger),
            ),
          ),
        ],
      ),
    );
  }

  void _exitGroup() {
    BotToast.showAnimationWidget(
      onlyOne: true,
      backgroundColor: Colors.black26,
      animationDuration: Duration(milliseconds: 300),
      toastBuilder: (cancelFunc) => AlertDialog(
        title: Text('您确定要退出此记账圈子吗?',
            style: TextStyle(
                fontSize: Adaptor.px(32.0), color: AppColors.appTextDark)),
        content: Padding(
            padding: EdgeInsets.only(top: Adaptor.px(20.0)),
            child: Text('退出后您在当前圈子里的账单将被转移至您的个人记账圈子下',
                style: TextStyle(
                    fontSize: Adaptor.px(26.0), color: AppColors.appTextDark))),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              cancelFunc();
            },
            highlightColor: const Color(0x55FF8A80),
            splashColor: const Color(0x99FF8A80),
            child: const Text(
              '取消',
              style: TextStyle(color: AppColors.appWarning),
            ),
          ),
          FlatButton(
            onPressed: () {
              cancelFunc();
              _disband();
            },
            child: const Text(
              '确定',
              style: TextStyle(color: AppColors.appDanger),
            ),
          ),
        ],
      ),
    );
  }

  void _editGroup() {
    AppRouter.toPage(context, 'edit-group?id=${widget.id}');
  }

  Widget _buildDetail() {
    return Observer(builder: (_) {
      bool _isAdmin = true;
      bool _isPersonal = false;
      bool _isDefault = false;

      if (groupStote.current != null) {
        _isAdmin = userStore.userInfo.id == groupStote.current.creatorId;
      }

      IconItem _groupType;

      if (groupStote.current != null) {
        _groupType = MethodsIcons.circleTypeMaps[groupStote.current.type];
        _isPersonal = groupStote.current.isPersonal == '1';
        _isDefault = groupStote.current.isDefault == '1';
      }

      return Wrap(children: <Widget>[
        Container(
          width: Adaptor.px(1060.0),
          height: Adaptor.px(100.0),
          padding:
              EdgeInsets.only(left: Adaptor.px(16.0), right: Adaptor.px(16.0)),
          margin:
              EdgeInsets.only(left: Adaptor.px(10.0), right: Adaptor.px(10.0)),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: Adaptor.onePx(), color: AppColors.appBorder))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('圈子名称',
                  style: TextStyle(
                      color: AppColors.appTextDark,
                      fontSize: Adaptor.px(28.0))),
              Expanded(
                  flex: 1,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                          groupStote.current != null
                              ? groupStote.current.name
                              : '',
                          style: TextStyle(
                              color: AppColors.appTextNormal,
                              fontSize: Adaptor.px(28.0),
                              fontWeight: FontWeight.normal))))
            ],
          ),
        ),
        Container(
          width: Adaptor.px(1060.0),
          height: Adaptor.px(100.0),
          padding:
              EdgeInsets.only(left: Adaptor.px(16.0), right: Adaptor.px(16.0)),
          margin:
              EdgeInsets.only(left: Adaptor.px(10.0), right: Adaptor.px(10.0)),
          decoration: BoxDecoration(
              color: AppColors.appWhite,
              border: Border(
                  bottom: BorderSide(
                      width: Adaptor.onePx(), color: AppColors.appBorder))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('圈子类型',
                  style: TextStyle(
                      color: AppColors.appTextDark,
                      fontSize: Adaptor.px(28.0))),
              Expanded(
                  flex: 1,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                          groupStote.current != null
                              ? _isPersonal ?
                              '私人圈子'  : _groupType.desc
                              : '',
                          style: TextStyle(
                              color: AppColors.appTextNormal,
                              fontSize: Adaptor.px(28.0),
                              fontWeight: FontWeight.normal))))
            ],
          ),
        ),
        Container(
          width: Adaptor.px(1060.0),
          height: Adaptor.px(100.0),
          padding:
              EdgeInsets.only(left: Adaptor.px(16.0), right: Adaptor.px(16.0)),
          margin:
              EdgeInsets.only(left: Adaptor.px(10.0), right: Adaptor.px(10.0)),
          decoration: BoxDecoration(
              color: AppColors.appWhite,
              border: Border(
                  bottom: BorderSide(
                      width: Adaptor.onePx(), color: AppColors.appBorder))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('成员数量',
                  style: TextStyle(
                      color: AppColors.appTextDark,
                      fontSize: Adaptor.px(28.0))),
              Expanded(
                  flex: 1,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                          groupStote.current != null
                              ? '${groupStote.current.users.length}'
                              : '',
                          style: TextStyle(
                              color: AppColors.appTextNormal,
                              fontSize: Adaptor.px(28.0),
                              fontWeight: FontWeight.normal))))
            ],
          ),
        ),
        Container(
          width: Adaptor.px(1060.0),
          height: Adaptor.px(100.0),
          padding:
              EdgeInsets.only(left: Adaptor.px(16.0), right: Adaptor.px(16.0)),
          margin:
              EdgeInsets.only(left: Adaptor.px(10.0), right: Adaptor.px(10.0)),
          decoration: BoxDecoration(
              color: AppColors.appWhite,
              border: Border(
                  bottom: BorderSide(
                      width: Adaptor.onePx(), color: AppColors.appBorder))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('管理员',
                  style: TextStyle(
                      color: AppColors.appTextDark,
                      fontSize: Adaptor.px(28.0))),
              Expanded(
                  flex: 1,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                          (groupStote.current != null &&
                                  groupStote.current.creator != null)
                              ? '${groupStote.current.creator.nickName}'
                              : '',
                          style: TextStyle(
                              color: AppColors.appTextNormal,
                              fontSize: Adaptor.px(28.0),
                              fontWeight: FontWeight.normal))))
            ],
          ),
        ),
        Container(
          width: Adaptor.px(1060.0),
          height: Adaptor.px(100.0),
          padding:
              EdgeInsets.only(left: Adaptor.px(16.0), right: Adaptor.px(16.0)),
          margin:
              EdgeInsets.only(left: Adaptor.px(10.0), right: Adaptor.px(10.0)),
          decoration: BoxDecoration(
              color: AppColors.appWhite,
              border: Border(
                  bottom: BorderSide(
                      width: Adaptor.onePx(), color: AppColors.appBorder))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('默认圈子',
                  style: TextStyle(
                      color: AppColors.appTextDark,
                      fontSize: Adaptor.px(28.0))),
              Expanded(
                  flex: 1,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                          _isDefault ? '是' : '否',
                          style: TextStyle(
                              color: AppColors.appTextNormal,
                              fontSize: Adaptor.px(28.0),
                              fontWeight: FontWeight.normal))))
            ],
          ),
        ),
        _isPersonal ?
        SizedBox.shrink()
        :
        _isAdmin
            ? Container(
                width: Adaptor.px(1000.0),
                height: Adaptor.px(100.0),
                margin: EdgeInsets.only(
                    top: Adaptor.px(30.0),
                    left: Adaptor.px(10.0),
                    right: Adaptor.px(10.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: _editGroup,
                      child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.appYellow,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Adaptor.px(10.0)))),
                          width: Adaptor.px(320.0),
                          height: Adaptor.px(80.0),
                          child: Center(
                              child: Text('编辑',
                                  style: TextStyle(
                                      fontSize: Adaptor.px(30.0),
                                      fontWeight: FontWeight.normal,
                                      color: AppColors.appTextDark)))),
                    ),
                    GestureDetector(
                        onTap: _disbandGroup,
                        child: Container(
                            width: Adaptor.px(320.0),
                            height: Adaptor.px(80.0),
                            decoration: BoxDecoration(
                                color: AppColors.appOutlay,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Adaptor.px(10.0)))),
                            child: Center(
                                child: Text('解散',
                                    style: TextStyle(
                                        fontSize: Adaptor.px(30.0),
                                        fontWeight: FontWeight.normal,
                                        color: AppColors.appWhite)))))
                  ],
                ))
            : Center(
                child: GestureDetector(
                    onTap: _exitGroup,
                    child: Container(
                        margin: EdgeInsets.only(top: Adaptor.px(30.0)),
                        width: Adaptor.px(800.0),
                        height: Adaptor.px(80.0),
                        decoration: BoxDecoration(
                            color: AppColors.appOutlay,
                            borderRadius: BorderRadius.all(
                                Radius.circular(Adaptor.px(10.0)))),
                        child: Center(
                            child: Text('退出',
                                style: TextStyle(
                                    fontSize: Adaptor.px(30.0),
                                    fontWeight: FontWeight.normal,
                                    color: AppColors.appWhite))))))
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('记账圈子详情',
                style: TextStyle(
                    fontSize: Adaptor.px(32.0), color: AppColors.appTextDark))),
        body: Container(
            margin: EdgeInsets.all(Adaptor.px(10.0)),
            padding: EdgeInsets.only(
                left: Adaptor.px(10.0), right: Adaptor.px(10.0)),
            decoration: BoxDecoration(color: AppColors.appWhite),
            width: Adaptor.px(1060.0),
            child: _buildDetail()));
  }
}
