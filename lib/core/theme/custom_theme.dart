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
        statusBarColor: CustomColor.backgroundLight,
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
    datePickerTheme: DatePickerThemeData(
      backgroundColor: lightScheme.surface,
      headerBackgroundColor: lightScheme.primary,
      headerForegroundColor: lightScheme.onPrimary,

      dayForegroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return lightScheme.onSurface.withValues(alpha: 0.3);
        } else if (states.contains(WidgetState.selected)) {
          return lightScheme.onPrimary;
        }
        return lightScheme.onSurface;
      }),

      dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return lightScheme.primary;
        }
        return Colors.transparent;
      }),

      todayForegroundColor: WidgetStateProperty.all(lightScheme.onSurface),
      todayBorder: BorderSide(color: lightScheme.primary),

      yearForegroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return lightScheme.onPrimary;
        }
        return lightScheme.onSurface;
      }),

      yearBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return lightScheme.primary;
        }
        return Colors.transparent;
      }),

      cancelButtonStyle: TextButton.styleFrom(
        foregroundColor: CustomColor.onCardLight,
      ),
      confirmButtonStyle: TextButton.styleFrom(
        foregroundColor: lightScheme.onPrimary,
        backgroundColor: lightScheme.primary,
      ),
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
        statusBarColor: CustomColor.backgroundDark,
        statusBarIconBrightness: Brightness.light,
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
    datePickerTheme: DatePickerThemeData(
      backgroundColor: darkScheme.surface,
      headerBackgroundColor: darkScheme.primary,
      headerForegroundColor: darkScheme.onPrimary,

      dayForegroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return lightScheme.onSurface.withValues(alpha: 0.3);
        } else if (states.contains(WidgetState.selected)) {
          return darkScheme.onPrimary;
        }
        return darkScheme.onSurface;
      }),

      dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return darkScheme.primary;
        }
        return Colors.transparent;
      }),

      todayForegroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return darkScheme.onPrimary;
        }
        return darkScheme.primary;
      }),
      todayBorder: BorderSide(color: darkScheme.primary),

      yearForegroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return darkScheme.onPrimary;
        }
        return darkScheme.onSurface;
      }),

      yearBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return darkScheme.primary;
        }
        return Colors.transparent;
      }),

      cancelButtonStyle: TextButton.styleFrom(
        foregroundColor: darkScheme.onSurface,
      ),
      confirmButtonStyle: TextButton.styleFrom(
        foregroundColor: darkScheme.primary,
      ),
    ),
    extensions: [CustomColor.financeDark],
  );
}
