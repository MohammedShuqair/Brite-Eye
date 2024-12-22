import 'package:flutter/material.dart';

/// Extension on [BuildContext] to provide easy access to theme colors.
extension ColorExtention on BuildContext {
  // Primary colors

  /// Primary color from the theme's color scheme.
  Color get primary => Theme.of(this).colorScheme.primary;

  /// Color for text/icons on primary color.
  Color get onPrimary => Theme.of(this).colorScheme.onPrimary;

  /// Splash color for selected button.
  Color get primaryContainer => Theme.of(this).colorScheme.primaryContainer;

  /// Highlight color for selected button.
  Color get onPrimaryContainer => Theme.of(this).colorScheme.onPrimaryContainer;

  /// Background color for intro screen.
  Color get primaryFixed => Theme.of(this).colorScheme.primaryFixed;

  // Secondary colors

  /// Background color for default filled non-primary button.
  Color get secondary => Theme.of(this).colorScheme.secondary;

  /// Color for text/icons on secondary color.
  Color get onSecondary => Theme.of(this).colorScheme.onSecondary;

  /// Background color for text fields and icon buttons.
  Color get secondaryContainer => Theme.of(this).colorScheme.secondaryContainer;

  /// Color for icons in icon buttons.
  Color get onSecondaryContainer =>
      Theme.of(this).colorScheme.onSecondaryContainer;

  // Tertiary colors

  /// Color for clickable text.
  Color get tertiary => Theme.of(this).colorScheme.tertiary;

  /// Color for text/icons on tertiary color.
  Color get onTertiary => Theme.of(this).colorScheme.onTertiary;

  /// Background color for tertiary containers.
  Color get tertiaryContainer => Theme.of(this).colorScheme.tertiaryContainer;

  /// Color for text/icons on tertiary containers.
  Color get onTertiaryContainer =>
      Theme.of(this).colorScheme.onTertiaryContainer;

  // Error colors

  /// Color for error messages and icons.
  Color get error => Theme.of(this).colorScheme.error;

  /// Color for text/icons on error color.
  Color get onError => Theme.of(this).colorScheme.onError;

  /// Background color for error containers.
  Color get errorContainer => Theme.of(this).colorScheme.errorContainer;

  /// Color for text/icons on error containers.
  Color get onErrorContainer => Theme.of(this).colorScheme.onErrorContainer;

  // Surface colors

  /// Background color for surfaces.
  Color get surface => Theme.of(this).colorScheme.surface;

  /// Color for text/icons on surface color.
  Color get onSurface => Theme.of(this).colorScheme.onSurface;

  /// Bright color for cards.
  Color get surfaceBright => Theme.of(this).colorScheme.surfaceBright;

  /// Variant color for surfaces.
  Color get surfaceVariant =>
      Theme.of(this).colorScheme.surfaceContainerHighest;

  /// Border color.
  Color get onSurfaceVariant => Theme.of(this).colorScheme.onSurfaceVariant;

  // Outline

  /// Color for hint text.
  Color get outline => Theme.of(this).colorScheme.outline;

  /// Color for dividers.
  Color get outlineVariant => Theme.of(this).colorScheme.outlineVariant;

  // Shadow

  /// Color for shadows.
  Color get shadow => Theme.of(this).colorScheme.shadow;

  // Inverse colors

  /// Inverse surface color to get user attention.
  Color get inverseSurface => Theme.of(this).colorScheme.inverseSurface;

  /// Color for text/icons on inverse surface color.
  Color get onInverseSurface => Theme.of(this).colorScheme.onInverseSurface;

  /// Inverse primary color.
  Color get inversePrimary => Theme.of(this).colorScheme.inversePrimary;

  // Scrim (used in Material Design 3 for overlays)

  /// Color for scrims.
  Color get scrim => Theme.of(this).colorScheme.scrim;
}
