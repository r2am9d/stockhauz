import 'package:flutter/foundation.dart';

import 'package:logger/logger.dart';

class LoggerUtil {
  factory LoggerUtil() => _instance;

  LoggerUtil._internal() {
    _logger = Logger(printer: PrettyPrinter(printEmojis: false));
  }

  static late Logger _logger;
  static final LoggerUtil _instance = LoggerUtil._internal();

  void debug(dynamic message) {
    if (kDebugMode) {
      _logger.wtf(message);
    }
  }

  void warning(dynamic message) {
    if (kDebugMode) {
      _logger.w(message);
    }
  }

  void error(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      _logger.e(message, error, stackTrace);
    }
  }
}
