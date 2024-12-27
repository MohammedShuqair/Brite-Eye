import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

ThemeData get lightTheme {
  var textTheme = TextTheme(
    titleLarge: GoogleFonts.outfit(
      fontSize: 38.sp,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.76,
      color: AppColors.onSurface,
    ),
    headlineMedium: GoogleFonts.outfit(
      fontSize: 30.sp,
      fontWeight: FontWeight.bold,
      color: AppColors.onSurface,
    ),
    titleMedium: GoogleFonts.outfit(
      fontSize: 16.sp,
      color: AppColors.outline,
      letterSpacing: 0.32,
    ),
    bodyLarge: GoogleFonts.outfit(
      fontSize: 20.sp,
      letterSpacing: 0.4,
      color: AppColors.outline,
    ),
    bodySmall: GoogleFonts.outfit(
      fontSize: 14.sp,
      letterSpacing: 0.28,
      color: AppColors.outline,
    ),
    labelSmall: GoogleFonts.outfit(
      fontSize: 12.sp,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.24,
      color: AppColors.onSurface,
    ),
  );
  return ThemeData(
      scaffoldBackgroundColor: AppColors.surface,
      listTileTheme: ListTileThemeData(
        selectedColor: AppColors.primary,
        titleTextStyle: textTheme.headlineMedium?.copyWith(
          fontSize: 18.sp,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.w),
        errorMaxLines: 2,
        hintStyle: textTheme.titleMedium,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide.none),
        filled: true,
        fillColor: AppColors.secondaryContainer,
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        titleTextStyle: textTheme.headlineMedium,
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primaryFixed: AppColors.primaryFixed,
        primaryContainer: AppColors.primaryContainer,
        onPrimaryContainer: AppColors.onPrimaryContainer,
        primary: AppColors.primary,
        surface: AppColors.surface,
        inverseSurface: AppColors.inverseSurface,
        onSurface: AppColors.onSurface,
        onSurfaceVariant: AppColors.onSurfaceVariant,
        outline: AppColors.outline,
        outlineVariant: AppColors.outlineVariant,
        secondary: AppColors.secondary,
        secondaryContainer: AppColors.secondaryContainer,
        onSecondaryContainer: AppColors.onSecondaryContainer,
        surfaceBright: AppColors.surfaceBright,
        tertiary: AppColors.tertiary,
      ),
      useMaterial3: true,
      indicatorColor: AppColors.tertiary,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        elevation: 0,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.onSurface,
      ),
      textTheme: textTheme);
}

ThemeData get darkTheme => ThemeData.dark(
      useMaterial3: true,
    );
