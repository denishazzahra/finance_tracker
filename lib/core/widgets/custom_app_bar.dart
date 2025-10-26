import 'package:finance_tracker/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../services/auth_service.dart';
import '../theme/theme_service.dart';
import '../utils/custom_converter.dart';
import 'custom_text.dart';

class CustomAppBar {
  static AppBar basic({
    required String title,
    required String currentThemeName,
    required Function onChanged,
    required Function confirmLogout,
    required BuildContext context,
  }) {
    return AppBar(
      title: CustomText.big(title, context: context),
      actions: [
        CustomButton.dropdown(
          selectedItem: currentThemeName,
          items: ThemeService.themes,
          onChanged: onChanged,
          context: context,
        ),
        CustomButton.icon(
          Symbols.logout,
          context: context,
          onPressed: confirmLogout,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ],
    );
  }

  static AppBar date({
    required int monthDiff,
    required BuildContext context,
    required Function changeMonth,
    TabController? tabController,
    List<String>? tabs,
  }) {
    bool isLight = Theme.of(context).brightness == Brightness.light;
    Color? chipCol = Theme.of(context).chipTheme.backgroundColor;
    Color? onPrimary = Theme.of(context).colorScheme.onPrimary;
    return AppBar(
      leading: Visibility(
        visible:
            CustomConverter.nMonthDiff(
              monthDiff - 1,
            ).isAfter(AuthService.getCreationTime()) ||
            CustomConverter.nMonthDiff(
              monthDiff - 1,
            ).isAtSameMomentAs(AuthService.getCreationTime()),
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        child: CustomButton.icon(
          Symbols.arrow_back_ios,
          context: context,
          onPressed: () => changeMonth(-1),
        ),
      ),
      title: CustomText.h3(
        DateFormat('MMMM yyyy').format(CustomConverter.nMonthDiff(monthDiff)),
        context: context,
        color: isLight ? onPrimary : null,
      ),
      centerTitle: true,
      actions: [
        Visibility(
          visible: monthDiff + 1 < 1,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: CustomButton.icon(
            Symbols.arrow_forward_ios,
            context: context,
            onPressed: () => changeMonth(1),
          ),
        ),
      ],
      bottom: (tabController != null && tabs != null)
          ? TabBar(
              controller: tabController,
              dividerColor: chipCol,
              tabs: tabs
                  .asMap()
                  .values
                  .map(
                    (tab) =>
                        Tab(child: CustomText.normal(tab, context: context)),
                  )
                  .toList(),
            )
          : null,
    );
  }
}
