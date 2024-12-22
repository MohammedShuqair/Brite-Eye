import 'package:brite_eye/core/extentions/color_theme.dart';
import 'package:brite_eye/core/extentions/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.onTap,
    required this.hint,
    this.borderRadius,
    this.padding,
    this.background,
    this.foregroundColor,
    this.child,
  });

  final String? hint;
  final VoidCallback? onTap;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color? background;
  final Color? foregroundColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: padding ?? const EdgeInsets.all(16),
      elevation: 0,
      highlightElevation: 0,
      color: background ?? context.secondaryContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 16),
      ),
      onPressed: onTap,
      child: child ??
          Text(
            hint!,
            style: context.bodyLarge.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 20.sp,
              height: (24 / 20).sp,
              color: foregroundColor ?? context.onSecondaryContainer,
            ),
          ),
    );
    //styleName: Text/Bold/Large;
  }
}
