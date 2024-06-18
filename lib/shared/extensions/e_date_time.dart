import 'package:intl/intl.dart';

extension EDateTime on DateTime? {
  String format([String format = 'yyyy-MM-dd HH:mm:ss']) {
    if (this == null) return '';
    final formatter = DateFormat(format);
    return formatter.format(this!);
  }

  String? formatReleaseDatePtBr() {
    if (this == null) return null;
    final day = this!.day;
    final month = this!.month;
    final year = this!.year;
    final ofYear = ' de $year';
    return '$day de ${summarizedMonth(month)}$ofYear';
  }

  String summarizedMonth(int month) {
    final map = {
      1: 'jan',
      2: 'fev',
      3: 'mar',
      4: 'abr',
      5: 'mai',
      6: 'jun',
      7: 'jul',
      8: 'ago',
      9: 'set',
      10: 'out',
      11: 'nov',
      12: 'dez',
    };

    return map[month] ?? '';
  }
}
