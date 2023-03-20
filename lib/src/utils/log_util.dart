import 'package:flutter/foundation.dart';

import 'package:logger/logger.dart';

class LogUtil {
  factory LogUtil() => _instance;

  LogUtil._internal() {
    _logger = Logger(
      printer: PrettyPrinter(
        lineLength: 80,
        printEmojis: false,
        stackTraceBeginIndex: 1,
      ),
    );
  }

  late final Logger _logger;
  static final LogUtil _instance = LogUtil._internal();

  void debug(dynamic message) {
    if (!kReleaseMode) {
      _logger.d(message);
    }
  }

  void warning(dynamic message) {
    if (!kReleaseMode) {
      _logger.w(message);
    }
  }

  void error(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (!kReleaseMode) {
      _logger.e(message, error, stackTrace);
    }
  }
}
