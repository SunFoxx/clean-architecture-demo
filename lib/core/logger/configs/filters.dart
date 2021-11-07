import 'package:logger/logger.dart';

class LogReporterFilter extends LogFilter {
  final _productionFilter = ProductionFilter();

  LogReporterFilter() {
    _productionFilter.level = Level.verbose;
  }

  @override
  bool shouldLog(LogEvent event) {
    if (!_productionFilter.shouldLog(event)) {
      return false;
    }

    return true;
  }
}
