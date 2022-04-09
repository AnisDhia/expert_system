import 'package:expert_system/ui/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/octicons_icons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
          // primarySwatch: Colors.red,
          ),
      home: const Navigation(),
    );
  }
}

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NavigationRail(
          selectedIndex: _selectedIndex,
          labelType: NavigationRailLabelType.selected,
          onDestinationSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          destinations: const [
            NavigationRailDestination(
                icon: Icon(Octicons.repo), label: Text('Repositories')),
            NavigationRailDestination(
                icon: Icon(Octicons.issue_opened), label: Text('Assigned Issues')),
            NavigationRailDestination(
                icon: Icon(Octicons.git_pull_request), label: Text('Pull Requests')),
          ],
        ),
        const VerticalDivider(
          thickness: 1,
          width: 1,
        ),
        Expanded(
            child: IndexedStack(
          index: _selectedIndex,
          children: [
            const HomePage(),
            Container(decoration: const BoxDecoration(color: Colors.purple),),
            Container(decoration: const BoxDecoration(color: Colors.amber),),
          ],
        ))
      ],
    );
  }
}
