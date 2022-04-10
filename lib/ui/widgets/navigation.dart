import 'package:expert_system/ui/pages/home_page.dart';
import 'package:expert_system/ui/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/octicons_icons.dart';

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
                icon: Icon(Octicons.repo), label: Text('Home')),
            NavigationRailDestination(
                icon: Icon(Icons.history), label: Text('History')),
            NavigationRailDestination(
                icon: Icon(Octicons.settings), label: Text('Settings')),
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
            const SettingsPage(),
          ],
        ))
      ],
    );
  }
}