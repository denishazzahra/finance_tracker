import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../../core/theme/theme_service.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final String currentThemeName;
  final Function onChanged;
  final Function confirmLogout;
  const CustomAppBar({
    super.key,
    required this.title,
    required this.currentThemeName,
    required this.onChanged,
    required this.confirmLogout,
  });

  @override
  Widget build(BuildContext context) {
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
}
