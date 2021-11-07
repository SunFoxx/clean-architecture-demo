import 'package:flutter/material.dart';
import 'package:jimmy_test/core/theme/theme.dart';

/// Prefix 'Custom' needed to avoid collision with 'Card' from material library
class CustomCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color? backgroundColor;

  const CustomCard({
    Key? key,
    this.onPressed,
    this.backgroundColor,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? AppTheme.colors.backgroundMain,
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              spreadRadius: 2,
              color: AppTheme.colors.shadowColor,
            )
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: child,
      ),
    );
  }
}
