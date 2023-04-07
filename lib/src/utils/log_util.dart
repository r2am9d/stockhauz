import 'package:logger/logger.dart';
import 'package:flutter/foundation.dart';

/// A better logger utility class with enhanced styling and such.
///
/// Configuration:
/// {@tool snippet}
/// ```dart
/// main() {
///   LogUtil.initialize(
///     colors: false,
///     ...
///   );
/// }
/// ```
/// {@end-tool}
///
/// Usage:
/// {@tool snippet}
/// ```dart
/// LogUtil.debug('Debug');
/// LogUtil.warning('Warning');
/// LogUtil.error('Error');
/// ```
/// {@end-tool}
class LogUtil {
  LogUtil._internal();

  static late final bool _colors;
  static late final bool _printTime;
  static late final int _lineLength;
  static late final bool _printEmojis;
  static late final bool _noBoxingByDefault;
  static late final int _stackTraceBeginIndex;

  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      colors: _colors,
      printTime: _printTime,
      lineLength: _lineLength,
      printEmojis: _printEmojis,
      noBoxingByDefault: _noBoxingByDefault,
      stackTraceBeginIndex: _stackTraceBeginIndex,
    ),
  );

  static void initialize({
    bool colors = true,
    bool printTime = false,
    int lineLength = 120,
    bool printEmojis = false,
    bool noBoxingByDefault = false,
    int stackTraceBeginIndex = 1,
  }) {
    _colors = colors;
    _printTime = printTime;
    _lineLength = lineLength;
    _printEmojis = printEmojis;
    _noBoxingByDefault = noBoxingByDefault;
    _stackTraceBeginIndex = stackTraceBeginIndex;
  }

  static void debug(dynamic message) {
    if (!kReleaseMode) {
      _logger.d(message);
    }
  }

  static void warning(dynamic message) {
    if (!kReleaseMode) {
      _logger.w(message);
    }
  }

  static void error(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (!kReleaseMode) {
      _logger.e(message, error, stackTrace);
    }
  }
}
