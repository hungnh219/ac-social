import 'package:cloud_firestore/cloud_firestore.dart';

mixin Methods {
  String calculateTimeFromNow(DateTime time) {
    var now = DateTime.now();
    var date = time;
    var diff = now.difference(date);
    var timeString = '';

    if (diff.inSeconds <= 0) {
      timeString = 'Just now';
    } else if (diff.inMinutes == 0) {
      timeString = 'Just now';
    } else if (diff.inHours == 0) {
      timeString = '${diff.inMinutes} minutes ago';
    } else if (diff.inDays == 0) {
      timeString = '${diff.inHours} hours ago';
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      timeString = '${diff.inDays} day${diff.inDays > 1 ? 's' : ''} ago';
    } else {
      timeString = '${(diff.inDays / 7).floor()} week${(diff.inDays / 7).floor() > 1 ? 's' : ''} ago';
    }

    return timeString;
  }
}