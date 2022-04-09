import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _HomePageState();
}

class _HomePageState extends State<SettingsPage> {
  bool _setting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text('Setting $index'),
                subtitle: const Text('hint'),
                trailing: CupertinoSwitch(value: _setting, onChanged: (value) {
                  setState(() {
                    _setting = value;
                  });
                }),
                onTap: () {
                  print('list tile clicked');
                },
              );
            }),
      ),
    );
  }
}
