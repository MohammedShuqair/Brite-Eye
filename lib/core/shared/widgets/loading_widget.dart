import 'package:brite_eye/core/extentions/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    this.size,
    this.loadingSize,
  });

  final double? size;
  final double? loadingSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size ?? double.infinity,
      height: size ?? double.infinity,
      color: Colors.transparent,
      child: LoadingAnimationWidget.inkDrop(
          color: context.primary, size: loadingSize ?? 56),
    );
  }
}
