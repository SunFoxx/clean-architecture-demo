import 'package:flutter/material.dart';
import 'package:jimmy_test/core/theme/theme.dart';

/// Display bar with either loading or error message
/// Has priority for displaying loading, if passed both loading and error
/// If [isLoading] is [false] and [errorMessage] is [null] - the bar hides itself from the vision
class ListStatusOverlay extends StatelessWidget {
  final bool isLoading;
  final String? errorMessage;

  const ListStatusOverlay({
    Key? key,
    this.isLoading = false,
    this.errorMessage,
  }) : super(key: key);

  bool get _isVisible => isLoading || errorMessage != null;

  @override
  Widget build(BuildContext context) {
    Widget content = const SizedBox();

    if (isLoading) {
      content = _buildLoader();
    } else if (errorMessage != null) {
      content = _buildError();
    }

    return AnimatedSlide(
      duration: const Duration(milliseconds: 500),
      offset: _isVisible ? Offset.zero : const Offset(0, 1),
      curve: Curves.easeInOut,
      child: Container(
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppTheme.colors.backgroundActive,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.elliptical(150, 50),
            topRight: Radius.elliptical(150, 50),
          ),
        ),
        child: AnimatedSwitcher(
          switchInCurve: Curves.easeOutCirc,
          switchOutCurve: Curves.easeInCirc,
          duration: const Duration(milliseconds: 750),
          transitionBuilder: (child, animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: content,
        ),
      ),
    );
  }

  Widget _buildLoader() {
    return const CircularProgressIndicator(color: Colors.white, strokeWidth: 8);
  }

  Widget _buildError() {
    return Text(
      errorMessage!,
      style: AppTheme.typography.semiboldNegative,
      textAlign: TextAlign.center,
    );
  }
}
