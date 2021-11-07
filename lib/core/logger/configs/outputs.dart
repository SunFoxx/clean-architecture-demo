import 'package:logger/logger.dart';

class DebugConsoleOutput extends LogOutput {
  final ConsoleOutput _consoleOutput = ConsoleOutput();

  DebugConsoleOutput();

  @override
  void output(OutputEvent event) {
    _consoleOutput.output(event);
  }
}
