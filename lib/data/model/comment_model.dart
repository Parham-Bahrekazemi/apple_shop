import 'package:intl/intl.dart';
import 'package:shamsi_date/shamsi_date.dart';

class CommentModel {
  String create;
  String? id;
  String? text;
  String? productId;
  String? userId;
  String? userThumbnailUrl;
  String? userName;

  String? avatar;

  CommentModel(this.create, this.id, this.text, this.productId, this.userId,
      this.userThumbnailUrl, this.userName, this.avatar);

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    var dateString = convertDateTimeDisplay(json['created']);

    final List<String> dateComponents = dateString.split('-');
    final int year = int.parse(dateComponents[0]);
    final int month = int.parse(dateComponents[1]);
    final int day = int.parse(dateComponents[2]);

    // Create a Jalali instance using the components
    final Jalali jalaliDate = Jalali.fromDateTime(DateTime(year, month, day));

    // Get the individual components of the Jalali date
    final int jalaliYear = jalaliDate.year;
    final int jalaliMonth = jalaliDate.month;
    final int jalaliDay = jalaliDate.day;

    return CommentModel(
      '$jalaliYear/$jalaliMonth/$jalaliDay',
      json['id'] ?? '',
      json['text'] ?? '',
      json['product_id'],
      json['user_id'] ?? '',
      json['expand'] != null
          ? 'http://startflutter.ir/api/files/${json['expand']['user_id']['collectionName']}/${json['expand']['user_id']['id']}/${json['expand']['user_id']['avatar']}'
          : null,
      json['expand']['user_id']['username'] ?? '',
      json['expand']['user_id']['avatar'] ?? '',
    );
  }
}

String convertDateTimeDisplay(String date) {
  final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
  final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
  final DateTime displayDate = displayFormater.parse(date);
  final String formatted = serverFormater.format(displayDate);
  return formatted;
}
