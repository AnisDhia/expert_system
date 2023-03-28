import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import '../../engine/engine.dart';
import '../../shared/styles/colors.dart';

class ToolBar extends StatefulWidget {
  const ToolBar({Key? key}) : super(key: key);

  @override
  State<ToolBar> createState() => _ToolBarState();
}

class _ToolBarState extends State<ToolBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Engine>(builder: (context, value, child) {
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
                  tooltip: '',
                  padding: const EdgeInsets.all(0),
                  offset: const Offset(0, 30),
                  child: const TextButton(
                    onPressed: null,
                    child: Text('File'),
                  ),
                  itemBuilder: (itemBuilder) {
                    return [
                      PopupMenuItem(
                          onTap: () async {
                            final jsonData = await _openFile();
                            if (jsonData != null) {
                              value.loadFromJSON(jsonData);
                            }
                          },
                          height: 30,
                          child: const Text("Open")),
                      PopupMenuItem(
                          onTap: () {
                            _saveFile(value);
                          },
                          height: 30,
                          child: const Text("Save")),
                      const PopupMenuItem(height: 30, child: Text("Exit")),
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
    });
  }

  _showFlushBar(String title, String message) async {
    await Flushbar(
      shouldIconPulse: true,
      icon: const Icon(
        CupertinoIcons.exclamationmark_circle,
        color: Colors.red,
        weight: 30,
        size: 30,
      ),
      leftBarIndicatorColor: Colors.red,
      backgroundColor: Theme.of(context).snackBarTheme.backgroundColor!,
      titleSize: 24,
      title: title,
      message: message,
      duration: const Duration(seconds: 3),
    ).show(context);
  }

  Future<dynamic> _openFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['json']);

    if (result == null) {
      _showFlushBar('Error', 'No file selected');
      return null;
    }
    final path = result.files.single.path!;
    final file = await File(path).readAsString();
    final jsonData = json.decode(file);
    return jsonData;
  }

  void _saveFile(Engine engine) async {
    final jasonString = engine.toJSON();
    print(jasonString);
    String? outputFile = await FilePicker.platform.saveFile(
      dialogTitle: 'Please select an output file:',
      fileName: 'engine.json',
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (outputFile == null) {
      // User canceled the picker
      _showFlushBar('Error', 'No path selected');
      return;
    } else {
      final file = File(outputFile);
      file.writeAsString(json.encode(jasonString));
    }
    // FilePickerResult? result = await FilePicker.platform.saveFile();
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
