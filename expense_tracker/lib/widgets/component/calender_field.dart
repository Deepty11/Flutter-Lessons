import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';

class CalenderField extends StatelessWidget {
  final DateTime? _dateSelected;
  final void Function() _presentCalender;

  const CalenderField(this._dateSelected, this._presentCalender, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          _dateSelected == null
              ? 'Select Date'
              : formatter.format(_dateSelected),
        ),
        IconButton(
          onPressed: _presentCalender,
          icon: const Icon(Icons.calendar_month),
        ),
      ],
    );
  }
}
