import 'package:intl/intl.dart';

extension MyDateTime on DateTime {
  // Returns relative time in human-readable format
  String get toRelativeTime {
    Duration difference = DateTime.now().difference(this);
    if (difference.inDays >= 365) {
      return "${(difference.inDays / 365).floor()} years ago";
    } else if (difference.inDays >= 30) {
      return "${(difference.inDays / 30).floor()} months ago";
    } else if (difference.inDays >= 7) {
      return "${(difference.inDays / 7).floor()} weeks ago";
    } else if (difference.inDays > 0) {
      return "${difference.inDays} days ago";
    } else if (difference.inHours > 0) {
      return "${difference.inHours} hours ago";
    } else if (difference.inMinutes > 0) {
      return "${difference.inMinutes} minutes ago";
    } else {
      return "Just now";
    }
  }

  // Returns true if the time is within 1 minute (for online status)
  bool get isOnline {
    Duration difference = DateTime.now().difference(this);
    return difference.inMinutes < 1;
  }

  // Returns relative time in short format
  String get toRelativeTimeShort {
    Duration difference = DateTime.now().difference(this);
    if (difference.inDays >= 365) {
      return "${(difference.inDays / 365).floor()}y";
    } else if (difference.inDays >= 30) {
      return "${(difference.inDays / 30).floor()}mon";
    } else if (difference.inDays >= 7) {
      return "${(difference.inDays / 7).floor()}w";
    } else if (difference.inDays > 0) {
      return "${difference.inDays}d";
    } else if (difference.inHours > 0) {
      return "${difference.inHours}h";
    } else if (difference.inMinutes > 0) {
      return "${difference.inMinutes}min";
    } else {
      return "Just now";
    }
  }

  // New function to calculate the exact number of days since a date
  int get daysSince {
    Duration difference = DateTime.now().difference(this);
    return difference.inDays;
  }
}

// Function to get relative time from a date string
String getRelativeTimeFromDateString(String dateString) {
  try {
    // Parse the date string into DateTime
    DateTime dateTime = DateFormat("yyyy-MM-ddTHH:mm:ss.SSSSSSZ").parse(dateString, true).toLocal();

    // Return the relative time using the extension
    return dateTime.toRelativeTime;
  } catch (e) {
    // Handle parsing errors
    print("Error parsing date string: $e");
    return "Invalid date";
  }
}

// Function to calculate the days since the given date string
int getDaysSinceFromDateString(String dateString) {
  try {
    // Parse the date string into DateTime
    DateTime dateTime = DateFormat("yyyy-MM-ddTHH:mm:ss.SSSSSSZ").parse(dateString, true).toLocal();

    // Use the daysSince function from the extension
    return dateTime.daysSince;
  } catch (e) {
    // Handle parsing errors
    print("Error parsing date string: $e");
    return -1; // Return -1 for error cases
  }
}
