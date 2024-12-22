import 'package:flutter/material.dart';

/// Extension on [BuildContext] to provide easy access to text theme styles.
extension TextThemeEx on BuildContext {
  /// Retrieves the [TextTheme] from the current [Theme].
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Big Title in auth section.
  TextStyle get titleLarge => textTheme.titleLarge!;

  /// Description in auth section.
  TextStyle get titleMedium => textTheme.titleMedium!;

  /// Medium headline style.
  TextStyle get headlineMedium => textTheme.headlineMedium!;

  /// Large body text style.
  TextStyle get bodyLarge => textTheme.bodyLarge!;

  /// Small body text style.
  TextStyle get bodySmall => textTheme.bodySmall!;

  /// Small title style.
  TextStyle get titleSmall => textTheme.titleSmall!;

  /// [SecondaryContainer] label style.
  TextStyle get labelSmall => textTheme.titleSmall!;
}
