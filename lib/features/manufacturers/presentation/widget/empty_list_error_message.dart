import 'package:flutter/material.dart';
import 'package:jimmy_test/core/localization/string_provider.dart';
import 'package:jimmy_test/core/widgets/interactive_message.dart';

/// Used to display error when active manufacturers list is empty
class EmptyListErrorMessage extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetryPressed;

  const EmptyListErrorMessage({
    Key? key,
    required this.errorMessage,
    required this.onRetryPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final strings = context.localizedStrings(listen: false);

    return InteractiveMessage(
      messageHeading: const Text('💢', style: TextStyle(fontSize: 48)),
      messageText: errorMessage,
      onButtonPressed: onRetryPressed,
      buttonText: strings.tryAgain,
    );
  }
}
