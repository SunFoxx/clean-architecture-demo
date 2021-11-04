import 'package:flutter/material.dart';
import 'package:jimmy_test/core/theme/theme.dart';

class NoManufacturersMessage extends StatelessWidget {
  final VoidCallback onRetryPressed;

  const NoManufacturersMessage({
    Key? key,
    required this.onRetryPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('👀', style: TextStyle(fontSize: 48)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Text(
              'We were unable to find any manufacturers this time',
              textAlign: TextAlign.center,
              style: AppTheme.typography.semibold,
            ),
          ),
          MaterialButton(
            elevation: 2,
            color: AppTheme.colors.activeButtonStrongColor,
            onPressed: onRetryPressed,
            child: Text(
              'Try again',
              style: AppTheme.typography.backgrounded,
            ),
          ),
        ],
      ),
    );
  }
}
