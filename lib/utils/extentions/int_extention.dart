import 'package:intl/intl.dart';

extension FarsiseparatePrice on int? {
  String get separateFarsiPrice => NumberFormat("#,###", 'fa_IR').format(this);
}
