import 'package:logger/logger.dart';

import 'configs/filters.dart';
import 'configs/outputs.dart';
import 'configs/printers.dart';

class LoggerFactory {
  static Logger getLogger() {
    return Logger(
      filter: LogReporterFilter(),
      printer: ProductionPrinter(),
      output: DebugConsoleOutput(),
    );
  }
}
