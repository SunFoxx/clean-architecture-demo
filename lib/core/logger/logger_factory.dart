import 'package:logger/logger.dart';

import 'configs/filters.dart';
import 'configs/outputs.dart';
import 'configs/printers.dart';

/// Generates the logger. Why factory instead of constructor?
/// In the future, we may want to read current build flavor and change the logger configurations accordingly
/// for example, we can duplicate production logs to external SDK or write profiling outputs to the file
class LoggerFactory {
  static Logger getLogger() {
    return Logger(
      filter: LogReporterFilter(),
      printer: ProductionPrinter(),
      output: DebugConsoleOutput(),
    );
  }
}
