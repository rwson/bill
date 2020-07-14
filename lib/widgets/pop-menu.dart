import 'package:bill/adaptor.dart';
import 'package:flutter/material.dart';
import 'package:positioned_tap_detector/positioned_tap_detector.dart';

class PopupMenu extends StatefulWidget {
  PopupMenu({@required this.child, @required this.menus, this.callback});

  Widget child;
  List<PopupMenuEntry> menus;
  Function callback;

  @override
  State<StatefulWidget> createState() => _PopupMenu();
}

class _PopupMenu extends State<PopupMenu> {
  @override
  Widget build(BuildContext context) {
    return PositionedTapDetector(
      child: widget.child,
      onLongPress: (TapPosition position) {
        _showMenu(context, position);
      },
    );
  }

  PopupMenuButton _popMenu() {
    return PopupMenuButton(
      itemBuilder: (context) => widget.menus,
      onSelected: (dynamic value) {
        if (widget.callback != null) {
          widget.callback(value);
        }
      }
    );
  }

  _showMenu(BuildContext context, TapPosition position) {

    double lPos = position.relative.dx - 50;

    double tPos = position.global.dy + 20;

    if (tPos >= Adaptor.screenH() - 200) {
      tPos = tPos - 140;
    }

    PopupMenuButton pop = _popMenu();

    showMenu<dynamic>(
      context: context,
      items: pop.itemBuilder(context),
      captureInheritedThemes: false,
      elevation: 2.0,
      position: RelativeRect.fromLTRB(lPos, tPos, 15, 0),
    ).then<void>((dynamic newValue) {
      if (!mounted) return null;
      if (newValue == null) {
        if (pop.onCanceled != null) pop.onCanceled();
        return null;
      }
      if (pop.onSelected != null) pop.onSelected(newValue);
    });
  }
}
