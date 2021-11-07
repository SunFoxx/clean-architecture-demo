import 'package:flutter/material.dart';
import 'package:jimmy_test/core/theme/theme.dart';

/// Display the [messageText] with [messageHeading] on top of it
/// Also draws a button beneath if [onButtonPressed] is passed
/// However, if you do want to have a button, you should also pass [buttonText] for it
class InteractiveMessage extends StatelessWidget {
  final Widget messageHeading;
  final String messageText;
  final VoidCallback? onButtonPressed;
  final String? buttonText;

  const InteractiveMessage({
    Key? key,
    required this.messageHeading,
    required this.messageText,
    this.onButtonPressed,
    this.buttonText,
  })  : assert(
          onButtonPressed == null || buttonText != null,
          'If message has button to press, it should also have a text for that button',
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('💢', style: TextStyle(fontSize: 48)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Text(
              messageText,
              style: AppTheme.typography.semibold,
              textAlign: TextAlign.center,
            ),
          ),
          if (onButtonPressed != null)
            MaterialButton(
              elevation: 2,
              color: AppTheme.colors.activeButtonStrongColor,
              onPressed: onButtonPressed,
              child: Text(
                buttonText!,
                style: AppTheme.typography.backgrounded,
              ),
            ),
        ],
      ),
    );
  }
}
