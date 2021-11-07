import 'package:logger/logger.dart';

class ProductionPrinter extends LogPrinter {
  final LogPrinter _printer;

  ProductionPrinter() : _printer = PrefixPrinter(_prettyPrinter);

  @override
  List<String> log(LogEvent event) {
    return _printer.log(event);
  }
}

LogPrinter get _prettyPrinter => PrettyPrinter(
      errorMethodCount: 30,
      methodCount: 0,
    );
