import 'package:expert_system/styles/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _HomePageState();
}

class _HomePageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(CupertinoIcons.moon_stars),
              title: const Text('Dark Mode'),
              // subtitle: const Text('hint'),
              trailing:
                  Consumer<ThemeNotifier>(builder: (context, value, child) {
                return CupertinoSwitch(
                    activeColor: Colors.blue,
                    value: value.darkTheme,
                    onChanged: (newValue) {
                      value.toggleTheme();
                    });
              }),
              onTap: () {
                print('list tile clicked');
              },
            )
          ],
        ),
      ),
    );
  }
}
