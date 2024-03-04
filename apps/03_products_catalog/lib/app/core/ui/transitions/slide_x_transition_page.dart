import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class SlideXTransitionPage extends CustomTransitionPage {
  SlideXTransitionPage({
    required super.child,
    super.transitionDuration,
    super.reverseTransitionDuration,
    super.maintainState,
    super.fullscreenDialog,
    super.opaque,
    super.barrierDismissible,
    super.barrierColor,
    super.barrierLabel,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  }) : super(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final tween = Tween(begin: const Offset(-1, 0), end: Offset.zero)
                .chain(CurveTween(curve: Curves.easeOutBack));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
}
