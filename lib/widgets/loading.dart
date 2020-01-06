import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  LoadingView();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: FractionalOffset.center,
      child: CircularProgressIndicator(),
    );
  }
}