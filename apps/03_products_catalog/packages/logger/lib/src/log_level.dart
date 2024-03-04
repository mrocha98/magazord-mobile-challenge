enum LogLevel {
  silent(0),
  fatal(1),
  error(2),
  warning(3),
  info(4),
  debug(5);

  const LogLevel(this._ranking);

  final int _ranking;

  bool operator >=(LogLevel other) {
    return _ranking >= other._ranking;
  }
}
