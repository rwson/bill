import 'package:bill/adaptor.dart';
import 'package:bill/colors.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //     title: Text('我的',
        //         style: TextStyle(
        //             fontSize: Adaptor.px(32.0), color: AppColors.appTextDark))),
        body: Container(
            color: AppColors.appBorder,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  "https://tva1.sinaimg.cn/large/006y8mN6gy1g7aa03bmfpj3069069mx8.jpg",
                  width: Adaptor.px(130.0),
                  height: Adaptor.px(130.0),
                ),
              ),
            )));
  }
}
