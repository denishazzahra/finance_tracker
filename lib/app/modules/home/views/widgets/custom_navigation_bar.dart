import 'package:flutter/material.dart';

import '../../../../data/models/page_model.dart';

class CustomNavigationBar extends StatelessWidget {
  final int index;
  final List<PageModel> pages;
  final Function(int) changePage;
  const CustomNavigationBar({
    super.key,
    required this.index,
    required this.changePage,
    required this.pages,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: (int index) {
        changePage(index);
      },
      selectedIndex: index,
      destinations: pages
          .map(
            (page) => NavigationDestination(
              selectedIcon: Icon(page.icon, fill: 1, weight: 600),
              icon: Icon(page.icon, fill: 0),
              label: page.name,
            ),
          )
          .toList(),
    );
  }
}
