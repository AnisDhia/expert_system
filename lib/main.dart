import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:expert_system/engine/engine.dart';
import 'package:expert_system/shared/styles/themes.dart';
import 'package:expert_system/ui/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());

  doWhenWindowReady(() {
    final win = appWindow;
    const initialSize = Size(1280, 720);
    win.minSize = initialSize;
    win.size = initialSize;
    win.alignment = Alignment.center;
    win.title = "Expert System";
    win.show();
  });
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (create) => ThemeNotifier()),
        ChangeNotifierProvider(create: (create) => Engine()),
      ],
      child: Consumer<ThemeNotifier>(
        builder: (context, value, child) {
          return MaterialApp(
            title: 'Expert System',
            debugShowCheckedModeBanner: false,
            theme: value.darkTheme ? MyThemes.darkTheme : MyThemes.lightTheme,
            home: const Navigation(),
          );
        }
      ),
    );
  }
}


