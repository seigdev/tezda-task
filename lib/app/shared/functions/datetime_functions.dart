import 'package:flutter/cupertino.dart';
import 'package:tezda_task/app/shared/shared.dart';
import 'package:intl/intl.dart';

final dateFormat = DateFormat('dd MMM, y');

final timeFormat = DateFormat('h:mm a');

final dateTimeFormat = DateFormat('dd MMM y, hh:mm a');

void pickDate(
    {required void Function(DateTime) onDateTimeChanged,
    required void Function() buttonPressed}) {
  showModal(
    child: SizedBox(
      height: 300,
      width: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 250,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.dateAndTime,
              onDateTimeChanged: onDateTimeChanged,
            ),
          ),
          CustomButton(
            text: "Done",
            onPressed: buttonPressed,
          )
        ],
      ),
    ),
  );
}

void pickTime(
    {required void Function(DateTime) onDateTimeChanged,
    required void Function() buttonPressed}) {
  showModal(
    child: SizedBox(
      height: 300,
      width: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 250,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.dateAndTime,
              onDateTimeChanged: onDateTimeChanged,
            ),
          ),
          CustomButton(
            text: "Done",
            onPressed: buttonPressed,
          )
        ],
      ),
    ),
  );
}
