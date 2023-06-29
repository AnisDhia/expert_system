import 'package:expert_system/shared/styles/themes.dart';
import 'package:expert_system/shared/utils/locale_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _HomePageState();
}

class _HomePageState extends State<SettingsPage> {
  Offset distance = const Offset(28, 28);
  double blur = 30;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _newCard(
              CupertinoIcons.moon_stars,
              AppLocalizations.of(context)!.darkMode,
              Consumer<ThemeNotifier>(builder: (context, value, child) {
                return Switch(
                    value: value.darkTheme,
                    onChanged: (newValue) {
                      value.toggleTheme();
                    });
              }),
            ),
            _newCard(
                CupertinoIcons.globe, AppLocalizations.of(context)!.language,
                Consumer<LocaleNotifier>(builder: (context, locale, child) {
              return DropdownButton<String>(
                value: locale.locale,
                alignment: Alignment.bottomCenter,
                items: const [
                  DropdownMenuItem(
                    value: 'en',
                    child: Text(
                      'English',
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'fr',
                    child: Text('Francais'),
                  ),
                  DropdownMenuItem(
                    value: 'ar',
                    child: Text('العربية'),
                  ),
                ],
                onChanged: (value) {
                  locale.changeLocale(value!);
                },
              );
            })),
            Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        blurRadius: blur,
                        offset: -distance,
                        // spreadRadius: -blur,
                      ),
                      BoxShadow(
                        color: const Color(0xFFA7A9AF),
                        blurRadius: blur,
                        offset: distance,
                        // spreadRadius: -blur,
                      ),
                    ]),
                margin: const EdgeInsets.only(top: 16),
                child: const SizedBox(
                  height: 200,
                  width: 200,
                )),
          ],
        ),
      ),
    );
  }

  Card _newCard(IconData icon, String title, Widget trailing) {
    return Card(
        margin: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Row(
            children: [
              Icon(icon),
              const SizedBox(width: 16),
              Expanded(child: Text(title)),
              trailing
            ],
          ),
        ));
  }
}
