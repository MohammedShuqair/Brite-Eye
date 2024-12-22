import 'package:flutter/material.dart';

import 'loading_widget.dart';

class LoadableScreen extends StatelessWidget {
  const LoadableScreen({
    super.key,
    required this.isLoading,
    required this.child,
    this.size,
  });

  final bool isLoading;
  final Widget child;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Visibility(
          visible: isLoading,
          child: SafeArea(
            child: Center(
              child: LoadingWidget(
                loadingSize: size,
              ),
            ),
          ),
        )
      ],
    );
  }
}
