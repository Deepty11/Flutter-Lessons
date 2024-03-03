import 'package:expense_tracker/widgets/component/expenses_list.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpenseState();
  }
}

class _ExpenseState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 99.0,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Buy Book',
      amount: 4.99,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => NewExpense(
        onAddExpense: _addExpense,
      ),
      isScrollControlled: true,
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  /// On dismissing, the user will be prompted with a snackbar, sowing `deleting expense, and
  /// there will be a undo button, on selecting which, the deleted expense will be again
  /// inserted in the particular index.
  void _removeExpense(int index) {
    final Expense expense = _registeredExpenses[index];
    setState(() {
      _registeredExpenses.removeAt(index);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Deleting expense'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(index, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainWidget = const Center(
      child: Text('No Expense found!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainWidget = ExpensesList(
        expenseList: _registeredExpenses,
        onDismissRow: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              // since, there is a column is under another column, flutter doesn't know how to
              // render the view, that's why needs to be wraped using Expanded widget to specify that
              // the child column will take the parent column's width and size.
              child: mainWidget),
        ],
      ),
    );
  }
}
