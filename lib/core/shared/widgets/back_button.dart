import 'package:brite_eye/core/extentions/color_theme.dart';
import 'package:flutter/material.dart';

import '../../helpers/lang_helper.dart';
import '../../helpers/navigation_helper.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton(
      {super.key,
      this.onTap,
      this.iconSize,
      this.buttonSize,
      this.padding,
      this.borderRadius});

  final VoidCallback? onTap;
  final double? iconSize;
  final double? buttonSize;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: LangHelper.instance.isRtl ? 2 : 0,
      child: Container(
        width: buttonSize ?? 56,
        height: buttonSize ?? 56,
        decoration: BoxDecoration(
          color: context.secondaryContainer,
          borderRadius: BorderRadius.circular(borderRadius ?? 16),
        ),
        child: IconButton(
          padding: padding,
          icon: Icon(Icons.arrow_back,size: iconSize ?? 24,),
          onPressed: () {
            if (onTap != null) {
              onTap!();
            } else {
              NavigationHelper.pop();
            }
          },
        ),
      ),
    );
  }
}
