import 'dart:developer';

enum LogMode { debug, live }

class Logger {
  static LogMode _logMode = LogMode.debug;

  static void init(LogMode mode) {
    Logger._logMode = mode;
  }

  static void logPrint(dynamic value, {StackTrace? stackTrace}) {
    if (_logMode == LogMode.debug) log("my-tag: $value");
  }
}
