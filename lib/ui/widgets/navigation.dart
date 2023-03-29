import 'package:expert_system/ui/pages/edit_page.dart';
import 'package:expert_system/ui/pages/home_page.dart';
import 'package:expert_system/ui/pages/settings_page.dart';
import 'package:expert_system/ui/widgets/toolbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';


class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 30,
          child: ToolBar(),
        ),
        Flexible(
          fit: FlexFit.loose,
          child: Row(
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
                destinations: [
                  NavigationRailDestination(
                      padding: const EdgeInsets.all(16),
                      icon: const Icon(Octicons.repo),
                      label: Text(AppLocalizations.of(context)!.home)),
                  NavigationRailDestination(
                      padding: const EdgeInsets.all(16),
                      icon: const Icon(Icons.edit),
                      label: Text(AppLocalizations.of(context)!.editRules)),
                  NavigationRailDestination(
                      padding: const EdgeInsets.all(16),
                      icon: const Icon(Octicons.settings),
                      label: Text(AppLocalizations.of(context)!.settings)),
                ],
              ),
              Expanded(
                  child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                children: const [
                  HomePage(),
                  EditPage(),
                  SettingsPage(),
                ],
              ))
            ],
          ),
        ),
      ],
    );
  }
}
