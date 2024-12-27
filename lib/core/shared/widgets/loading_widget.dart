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
    var loadingSize = this.loadingSize ?? 56;
    return Container(
      width: size ?? double.infinity,
      height: size ?? double.infinity,
      color: Colors.transparent,
      child: UnconstrainedBox(
        child: Container(
          width: loadingSize + 32,
          height: loadingSize + 32,
          decoration: BoxDecoration(
            color: context.surface.withOpacity(0.9),
            borderRadius: BorderRadius.circular(16),
          ),
          child: LoadingAnimationWidget.inkDrop(
              color: context.tertiary, size: loadingSize),
        ),
      ),
    );
  }
}
