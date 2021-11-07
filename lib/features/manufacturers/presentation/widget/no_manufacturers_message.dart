import 'package:flutter/material.dart';
import 'package:jimmy_test/core/localization/string_provider.dart';
import 'package:jimmy_test/core/widgets/interactive_message.dart';

class NoManufacturersMessage extends StatelessWidget {
  final VoidCallback onRetryPressed;

  const NoManufacturersMessage({
    Key? key,
    required this.onRetryPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final strings = context.localizedStrings(listen: false);

    return InteractiveMessage(
      messageHeading: const Text('👀', style: TextStyle(fontSize: 48)),
      messageText: strings.noManufacturersMessage,
      onButtonPressed: onRetryPressed,
      buttonText: strings.tryAgain,
    );
  }
}
