import 'package:flutter/material.dart';

class CrossFade extends StatelessWidget {
  final bool show;
  final Widget child;
  final Widget hiddenChild;

  const CrossFade({super.key, 
    required this.show,
    required this.child,
    required this.hiddenChild,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 300),
      crossFadeState:
          show ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      firstChild: child,
      secondChild: hiddenChild,
    );
  }
}
