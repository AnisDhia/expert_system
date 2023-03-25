import 'package:expert_system/engine/engine.dart';
import 'package:expert_system/ui/pages/edit_page.dart';
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
  late PageController _pageController;
  // Engine engine = Engine();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NavigationRail(
          groupAlignment: 0,
          selectedIndex: _selectedIndex,
          labelType: NavigationRailLabelType.selected,
          onDestinationSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
            _pageController.jumpToPage(index);
          },
          destinations: const [
            NavigationRailDestination(
                padding: EdgeInsets.all(16),
                icon: Icon(Octicons.repo),
                label: Text('Home')),
            NavigationRailDestination(
                padding: EdgeInsets.all(16),
                icon: Icon(Icons.edit),
                label: Text('Edit')),
            NavigationRailDestination(
                padding: EdgeInsets.all(16),
                icon: Icon(Octicons.settings),
                label: Text('Settings')),
          ],
        ),
        // const VerticalDivider(
        //   thickness: 1,
        //   width: 1,
        // ),
        Expanded(
            child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          // index: _selectedIndex,
          children:  [
            HomePage(),
            EditPage(),
            const SettingsPage(),
          ],
        ))
      ],
    );
  }
}
