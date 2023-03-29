import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

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
                  child: TextButton(
                    onPressed: null,
                    child: Text(AppLocalizations.of(context)!.file),
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
                          child: Text(AppLocalizations.of(context)!.open)),
                      PopupMenuItem(
                          onTap: () async {
                            await _saveFile(value);
                            _showFlushBar(
                                'Saved',
                                'Engine saved into JSON file',
                                Colors.blue,
                                CupertinoIcons.checkmark_circle);
                          },
                          height: 30,
                          child: Text(AppLocalizations.of(context)!.save)),
                      PopupMenuItem(
                          onTap: () {
                            exit(0);
                          },
                          height: 30,
                          child: Text(AppLocalizations.of(context)!.exit)),
                    ];
                  },
                ),
                PopupMenuButton(
                  tooltip: '',
                  padding: const EdgeInsets.all(0),
                  offset: const Offset(0, 30),
                  child: TextButton(
                    onPressed: null,
                    child: Text(AppLocalizations.of(context)!.help),
                  ),
                  itemBuilder: (itemBuilder) {
                    return [
                      PopupMenuItem(
                          onTap: () async {
                            // TODO add a quick guide
                          },
                          height: 30,
                          child: Text(AppLocalizations.of(context)!.guide)),
                      PopupMenuItem(
                          onTap: () async {
                            // TODO add an about page
                          },
                          height: 30,
                          child: Text(AppLocalizations.of(context)!.about)),
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

  _showFlushBar(
      String title, String message, Color color, IconData icon) async {
    await Flushbar(
      shouldIconPulse: true,
      icon: Icon(
        icon,
        color: color,
        weight: 30,
        size: 30,
      ),
      leftBarIndicatorColor: color,
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
      _showFlushBar('Error', 'No file selected', Colors.red,
          CupertinoIcons.exclamationmark_circle);
      return null;
    }
    final path = result.files.single.path!;
    final file = await File(path).readAsString();
    final jsonData = json.decode(file);
    return jsonData;
  }

  _saveFile(Engine engine) async {
    final jasonString = engine.toJSON();
    String? outputFile = await FilePicker.platform.saveFile(
      dialogTitle: 'Please select an output file:',
      fileName: 'engine.json',
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (outputFile == null) {
      // User canceled the picker
      _showFlushBar('Error', 'No path selected', Colors.red,
          CupertinoIcons.exclamationmark_circle);
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
