import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widgets/component/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenseList,
    required this.onDismissRow,
  });

  final void Function(int index) onDismissRow;

  final List<Expense> expenseList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenseList.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(expenseList[index]),
        child: ExpenseItem(expenseList[index]),
        onDismissed: (direction) {
          onDismissRow(index);
        },
      ),
    );
  }
}
