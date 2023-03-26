import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../shared/styles/colors.dart';

class ToolBar extends StatelessWidget {
  const ToolBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: WindowTitleBarBox(
        child: Container(
          color: Theme.of(context).appBarTheme.backgroundColor,
          child: Row(
            children: [
              const SizedBox(width: 10),
              Icon(
                CupertinoIcons.ant_circle_fill,
                color: Theme.of(context).primaryColor,
                size: 20,
              ),
              const SizedBox(width: 10),
              PopupMenuButton(
                tooltip: null,
                padding: EdgeInsets.all(0),
                offset: Offset(0, 30),
                child: TextButton(
                  child: Text('File'),
                  onPressed: null,
                ),
                itemBuilder: (itemBuilder) {
                  return [
                    PopupMenuItem(height: 30, child: Text("Open")),
                    PopupMenuItem(height: 30, child: Text("Save")),
                    PopupMenuItem(height: 30, child: Text("Exit")),
                  ];
                },
              ),
              Expanded(
                  child: MoveWindow(
                child: Container(),
              )),
              const WindowButtons()
            ],
          ),
        ),
      ),
    );
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(
          colors: buttonColors,
          animate: true,
        ),
        MaximizeWindowButton(colors: buttonColors, animate: true),
        CloseWindowButton(colors: closeButtonColors, animate: true),
      ],
    );
  }
}
