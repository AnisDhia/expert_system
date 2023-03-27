import 'package:expert_system/shared/styles/themes.dart';
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
              trailing:
                  Consumer<ThemeNotifier>(builder: (context, value, child) {
                return Switch(
                    value: value.darkTheme,
                    onChanged: (newValue) {
                      value.toggleTheme();
                    });
              }),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(CupertinoIcons.globe),
              title: const Text('Language'),
              trailing: DropdownButton<String>(
                items: const [
                  DropdownMenuItem(child: Text('English')),
                ],
                onChanged: (value) {},
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
