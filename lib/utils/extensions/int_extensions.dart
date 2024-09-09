import 'package:intl/intl.dart';
import 'package:my_weather/data/models/enum/date_time_format.dart';

extension DateString on int {
  String convertDateTime(DateTimeFormat format) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(this * 1000);
    return DateFormat(format.value).format(dateTime);
  }
}
