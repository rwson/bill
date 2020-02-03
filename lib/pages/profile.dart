import 'dart:io';

import 'package:bill/adaptor.dart';
import 'package:bill/colors.dart';
import 'package:bill/router.dart';
import 'package:bill/stores/stores.dart';
import 'package:bill/stores/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProfileState();
}

class ProfileState extends State<ProfilePage> {
  final UserStore userStore = AppStores.userStore;
  var _image;

  String cacheSize = '0';

  @override
  initState() {
    super.initState();
    _getCacheSize();
  }

  Future<void> _getCacheSize() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    double value = await _getTotalSizeOfFilesInDir(tempPath);
    setState(() {
      cacheSize = _renderSize(value); // _cacheSizeStr用来存储大小的值
    });
  }

  Future<double> _getTotalSizeOfFilesInDir(final file) async {
    if (file is File) {
      int length = await file.length();
      return double.parse(length.toString());
    }
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      double total = 0;
      if (children != null)
        for (final FileSystemEntity child in children)
          total += await _getTotalSizeOfFilesInDir(child);
      return total;
    }
    return 0;
  }

  _renderSize(double value) {
    if (null == value) {
      return 0;
    }
    List<String> unitArr = List()..add('B')..add('KB')..add('MB')..add('GB');
    int index = 0;
    while (value > 1024) {
      index++;
      value = value / 1024;
    }
    String size = value.toStringAsFixed(2);
    return size + unitArr[index];
  }

  Future<void> _uploadAvatar() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  Future<void> _logout() async {
    userStore.logout();
    AppRouter.redirectTo(context, 'login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('个人中心',
                style: TextStyle(
                    fontSize: Adaptor.px(32.0), color: AppColors.appTextDark))),
        body: Container(
            child: Observer(
                builder: (_) => Container(
                    margin: EdgeInsets.only(
                        top: Adaptor.px(10.0),
                        left: Adaptor.px(10.0),
                        right: Adaptor.px(10.0)),
                    child: Wrap(children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(
                              top: Adaptor.px(20.0),
                              left: Adaptor.px(10.0),
                              right: Adaptor.px(10.0),
                              bottom: Adaptor.px(20.0)),
                          padding: EdgeInsets.only(
                              left: Adaptor.px(14.0), right: 6.0),
                          decoration: BoxDecoration(
                              color: AppColors.appWhite,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0)),
                              boxShadow: [
                                BoxShadow(
                                    color: AppColors.appBlackShadow,
                                    blurRadius: 8.0,
                                    offset: Offset(0, 1.0))
                              ]),
                          child: Wrap(children: <Widget>[
                            Container(
                                height: Adaptor.px(100.0),
                                decoration: BoxDecoration(
                                    color: AppColors.appWhite,
                                    border: Border(
                                        bottom: BorderSide(
                                            width: Adaptor.onePx(),
                                            color: AppColors.appBorderLight))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: Adaptor.px(12.0)),
                                      child: Text(
                                        '头像',
                                        style: TextStyle(
                                            color: AppColors.appTextDark,
                                            fontSize: Adaptor.px(28.0),
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    GestureDetector(
                                        onTap: _uploadAvatar,
                                        child: Padding(
                                            padding: EdgeInsets.only(
                                                right: Adaptor.px(12.0)),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Adaptor.px(30.0)),
                                                child: Image.network(
                                                    userStore.userInfo.avatar,
                                                    width: Adaptor.px(60.0),
                                                    height: Adaptor.px(60.0)))))
                                  ],
                                )),
                            Container(
                                height: Adaptor.px(100.0),
                                decoration: BoxDecoration(
                                    color: AppColors.appWhite,
                                    border: Border(
                                        bottom: BorderSide(
                                            width: Adaptor.onePx(),
                                            color: AppColors.appBorderLight))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: Adaptor.px(12.0)),
                                      child: Text(
                                        '昵称',
                                        style: TextStyle(
                                            color: AppColors.appTextDark,
                                            fontSize: Adaptor.px(28.0),
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            right: Adaptor.px(12.0)),
                                        child: Text(
                                          userStore.userInfo.nickname,
                                          style: TextStyle(
                                              color: AppColors.appTextDark,
                                              fontSize: Adaptor.px(28.0),
                                              fontWeight: FontWeight.normal),
                                        ))
                                  ],
                                )),
                            Container(
                                height: Adaptor.px(100.0),
                                decoration: BoxDecoration(
                                    color: AppColors.appWhite,
                                    border: Border(
                                        bottom: BorderSide(
                                            width: Adaptor.onePx(),
                                            color: AppColors.appBorderLight))),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: Adaptor.px(12.0)),
                                        child: Text(
                                          '手机号',
                                          style: TextStyle(
                                              color: AppColors.appTextDark,
                                              fontSize: Adaptor.px(28.0),
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              right: Adaptor.px(12.0)),
                                          child: Text(
                                            userStore.userInfo.mobile,
                                            style: TextStyle(
                                                color: AppColors.appTextDark,
                                                fontSize: Adaptor.px(28.0),
                                                fontWeight: FontWeight.normal),
                                          ))
                                    ])),
                            Container(
                                height: Adaptor.px(100.0),
                                decoration: BoxDecoration(
                                    color: AppColors.appWhite,
                                    border: Border(
                                        bottom: BorderSide(
                                            width: Adaptor.onePx(),
                                            color: AppColors.appBorderLight))),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: Adaptor.px(12.0)),
                                        child: Text(
                                          '上次登录',
                                          style: TextStyle(
                                              color: AppColors.appTextDark,
                                              fontSize: Adaptor.px(28.0),
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              right: Adaptor.px(12.0)),
                                          child: Text(
                                            userStore.userInfo.lastLogin,
                                            style: TextStyle(
                                                color: AppColors.appTextDark,
                                                fontSize: Adaptor.px(28.0),
                                                fontWeight: FontWeight.normal),
                                          ))
                                    ])),
                            Container(
                                height: Adaptor.px(100.0),
                                decoration: BoxDecoration(
                                    color: AppColors.appWhite,
                                    border: Border(
                                        bottom: BorderSide(
                                            width: Adaptor.onePx(),
                                            color: AppColors.appBorderLight))),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: Adaptor.px(12.0)),
                                        child: Text(
                                          '应用缓存',
                                          style: TextStyle(
                                              color: AppColors.appTextDark,
                                              fontSize: Adaptor.px(28.0),
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              right: Adaptor.px(12.0)),
                                          child: Text(
                                            cacheSize,
                                            style: TextStyle(
                                                color: AppColors.appTextDark,
                                                fontSize: Adaptor.px(28.0),
                                                fontWeight: FontWeight.normal),
                                          ))
                                    ]))
                          ])),
                      Container(
                          width: Adaptor.px(1020.0),
                          height: Adaptor.px(80.0),
                          margin: EdgeInsets.only(
                              top: Adaptor.px(20.0),
                              left: Adaptor.px(20.0),
                              right: Adaptor.px(20.0)),
                          decoration: BoxDecoration(
                              color: AppColors.appYellow,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Adaptor.px(10.0)))),
                          child: FlatButton(
                              onPressed: _logout,
                              child: Text('退出登录',
                                  style: TextStyle(
                                      fontSize: Adaptor.px(32.0),
                                      fontWeight: FontWeight.normal,
                                      color: AppColors.appTextDark))))
                    ])))));
  }
}
