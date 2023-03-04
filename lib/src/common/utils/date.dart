import 'package:intl/intl.dart';

String duTimeLineFormat(DateTime dt) {
  var now = DateTime.now();
  var difference = now.difference(dt);
  if (difference.inMinutes < 60) {
    return "${difference.inMinutes} m ago";
  }

  if (difference.inHours < 24) {
    return "${difference.inHours} h ago";
  } else if (difference.inDays < 30) {
    return "${difference.inDays} d ago";
  } else if (difference.inDays < 365) {
    final dtFormat = DateFormat('MM-dd');
    return dtFormat.format(dt);
  } else {
    final dtFormat = DateFormat('yyyy-MM-dd');
    var str = dtFormat.format(dt);
    return str;
  }
}

String getTime(DateTime dt) {
  String timestamp = dt.toString();
  DateTime dateTime = DateTime.parse(timestamp);
  int hour = dateTime.hour;
  int minute = dateTime.minute;
  String time = "$hour:$minute";
  return time;
}
