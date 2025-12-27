import 'package:demo/core/app_constants.dart';
import 'package:flutter/material.dart';

class CommonUi {
  /// EMPTY STATE WIDGET
  static Widget emptyState({bool scroll = true}) {
    return CustomScrollView(
      physics:
          scroll
              ? const AlwaysScrollableScrollPhysics()
              : const NeverScrollableScrollPhysics(),
      slivers: [
        SliverFillRemaining(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [Text("Empty State")],
          ),
        ),
      ],
    );
  }

  /// ON TAP EFFECT WIDGET.
  static Widget onTapEffect({
    BoxDecoration? decoration,
    double borderRadius = 12,
    void Function()? onTap,
    required Widget child,
  }) {
    return Ink(
      decoration: decoration,
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        splashColor: Colors.grey.withOpacity(0.2),
        splashFactory: InkSparkle.splashFactory,
        onTap: () {
          AppConstants.hapticFeedback();
          onTap?.call();
        },
        child: child,
      ),
    );
  }
}
