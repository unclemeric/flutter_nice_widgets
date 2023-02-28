import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class DateTimePickerUtil {
  static DatePickerTheme datePickerTheme = const DatePickerTheme(
    headerColor: Colors.white,
    backgroundColor: Colors.white,
    itemStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontSize: 18,
    ),
    doneStyle: TextStyle(color: Colors.black87, fontSize: 16),
  );

  /// 日期选择
  static void showDatePicker(
    BuildContext context, {
    Function(DateTime)? onChanged,
    Function(DateTime)? onConfirm,
    DateTime? minTime,
    DateTime? maxTime,
    DateTime? currTime,
    LocaleType? locale: LocaleType.zh,
  }) {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: minTime,
      maxTime: maxTime,
      currentTime: currTime ?? DateTime.now(),
      theme: datePickerTheme,
      onChanged: onChanged,
      onConfirm: onConfirm,
      locale: locale,
    );
  }

  /// 时间选择
  static void showTimePicker(BuildContext context,
      {bool showTitleActions = true,
      bool showSecondsColumn = true,
      dynamic Function(DateTime)? onChanged,
      dynamic Function(DateTime)? onConfirm,
      dynamic Function()? onCancel,
      dynamic locale = LocaleType.zh,
      DateTime? currentTime,
      DatePickerTheme? theme}) {
    DatePicker.showTimePicker(context,
        currentTime: currentTime ?? DateTime.now(),
        showSecondsColumn: showSecondsColumn,
        showTitleActions: showTitleActions,
        onChanged: onChanged,
        onConfirm: onConfirm,
        theme: datePickerTheme,
        locale: locale);
  }

  // 12小时制时间选择
  static void showTime12hPicker(BuildContext context,
      {bool showTitleActions = true,
      dynamic Function(DateTime)? onChanged,
      dynamic Function(DateTime)? onConfirm,
      dynamic Function()? onCancel,
      dynamic locale = LocaleType.zh,
      DateTime? currentTime,
      DatePickerTheme? theme}) {
    DatePicker.showTime12hPicker(
      context,
      locale: locale,
      showTitleActions: showTitleActions,
      onChanged: onChanged,
      onConfirm: onConfirm,
      theme: datePickerTheme,
      currentTime: currentTime ?? DateTime.now(),
    );
  }
}
