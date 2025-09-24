import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'custom_color.dart';

class CustomTheme {
  static ColorScheme lightScheme = ColorScheme.light(
    primary: CustomColor.primaryLight,
    onPrimary: CustomColor.onPrimaryLight,
    surface: CustomColor.cardLight,
    onSurface: CustomColor.onCardLight,
  );

  static ThemeData lightTheme = ThemeData(
    primaryColor: CustomColor.primaryLight,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    scaffoldBackgroundColor: CustomColor.backgroundLight,
    cardColor: CustomColor.cardLight,
    chipTheme: ChipThemeData(
      backgroundColor: CustomColor.chipLight,
      labelStyle: TextStyle(color: CustomColor.onChipLight),
    ),
    useMaterial3: true,
    colorScheme: lightScheme,
    appBarTheme: AppBarTheme(
      // centerTitle: true,
      backgroundColor: CustomColor.backgroundLight,
      scrolledUnderElevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: lightScheme.surface, // bar background
      indicatorColor: lightScheme.primary,
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(color: lightScheme.onPrimary);
        }
        return IconThemeData(color: lightScheme.onSurface);
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return TextStyle(
            color: lightScheme.onSurface,
            fontWeight: FontWeight.w600,
          );
        }
        return TextStyle(color: lightScheme.onSurface);
      }),
    ),
    extensions: [CustomColor.financeLight],
  );

  static ColorScheme darkScheme = ColorScheme.dark(
    primary: CustomColor.primaryDark,
    onPrimary: CustomColor.onPrimaryDark,
    surface: CustomColor.cardDark,
    onSurface: CustomColor.onCardDark,
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: CustomColor.primaryDark,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    scaffoldBackgroundColor: CustomColor.backgroundDark,
    cardColor: CustomColor.cardDark,
    chipTheme: ChipThemeData(
      backgroundColor: CustomColor.chipDark,
      labelStyle: TextStyle(color: CustomColor.onChipDark),
    ),
    useMaterial3: true,
    colorScheme: darkScheme,
    appBarTheme: AppBarTheme(
      // centerTitle: true,
      backgroundColor: CustomColor.backgroundDark,
      scrolledUnderElevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: darkScheme.surface, // bar background
      indicatorColor: darkScheme.primary,
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(color: darkScheme.onPrimary);
        }
        return IconThemeData(color: darkScheme.onSurface);
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return TextStyle(
            color: darkScheme.onSurface,
            fontWeight: FontWeight.w600,
          );
        }
        return TextStyle(color: darkScheme.onSurface);
      }),
    ),
    snackBarTheme: SnackBarThemeData(backgroundColor: Colors.black),
    extensions: [CustomColor.financeDark],
  );
}
