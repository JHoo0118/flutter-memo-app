import 'package:timeago/timeago.dart';

class MyCustomMessages implements LookupMessages {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '지금부터';
  @override
  String suffixAgo() => '전';
  @override
  String suffixFromNow() => '후';
  @override
  String lessThanOneMinute(int seconds) => '$seconds초';
  @override
  String aboutAMinute(int minutes) => '1분';
  @override
  String minutes(int minutes) => '$minutes분';
  @override
  String aboutAnHour(int minutes) => '1시간';
  @override
  String hours(int hours) => '$hours시간';
  @override
  String aDay(int hours) => '1일';
  @override
  String days(int days) => '$days일';
  @override
  String aboutAMonth(int days) => '1달';
  @override
  String months(int months) => '$months달';
  @override
  String aboutAYear(int year) => '1년';
  @override
  String years(int years) => '$years년';
  @override
  String wordSeparator() => ' ';
}
