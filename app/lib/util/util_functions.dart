import 'package:intl/intl.dart';

class UtilFunctions {

  parseTime(fetchedDateTime, String format) {
    var dateTime = DateTime.parse(fetchedDateTime);
    var time = DateFormat(format).format(dateTime);
    return time;

  }

  parseDate(fetchedDateTime, String format) {
    var dateTime = DateTime.parse(fetchedDateTime);
    var date = DateFormat(format).format(dateTime);
    return date;
  }
  
}