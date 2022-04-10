import 'package:expert_system/styles/themes.dart';
import 'package:expert_system/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (create) => ThemeNotifier())
      ],
      child: Consumer<ThemeNotifier>(
        builder: (context, value, child) {
          return MaterialApp(
            title: 'Expert System',
            debugShowCheckedModeBanner: false,
            theme: value.darkTheme ? ThemeData.dark() : ThemeData.light(),
            home: const Navigation(),
          );
        }
      ),
    );
  }
}


