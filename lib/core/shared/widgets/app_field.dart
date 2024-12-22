import 'package:brite_eye/core/extentions/color_theme.dart';
import 'package:brite_eye/core/extentions/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppField extends StatelessWidget {
  const AppField({
    super.key,
    required this.controller,
    required this.label,
    this.suffixIcon,
    this.obscureText = false,
    this.enabled = true,
    this.validator,
    this.textInputAction = TextInputAction.next,
    this.padding,
    this.radius = 32,
    this.inputFormatters,
    this.focusNode,
    this.centerInput = false,
    this.onEditingComplete,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String label;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool enabled;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final EdgeInsetsGeometry? padding;
  final double radius;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final bool centerInput;
  final VoidCallback? onEditingComplete;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    //styleName: Text/Regular/Medium;
    // font-family: Outfit;

    return TextFormField(
      focusNode: focusNode,
      enabled: enabled,
      controller: controller,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      validator: validator,
      onEditingComplete: onEditingComplete,
      style: context.titleMedium.copyWith(
        color: context.onSurface,
      ),
      onTapOutside: (focusNode) {
        FocusScope.of(context).unfocus();
      },
      obscureText: obscureText,
      inputFormatters: inputFormatters,
      textAlign: centerInput ? TextAlign.center : TextAlign.start,
      decoration: buildAppInputDecoration(context,
          padding: padding, suffixIcon: suffixIcon, radius: radius),
    );
  }

  InputDecoration buildAppInputDecoration(
    BuildContext context, {
    EdgeInsetsGeometry? padding,
    Widget? suffixIcon,
    double radius = 32,
  }) {
    return InputDecoration(
      contentPadding:
          padding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.w),
      hintText: label,
      hintStyle: context.titleMedium,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide.none),
      filled: true,
      fillColor: context.secondaryContainer,
    );
  }
}
