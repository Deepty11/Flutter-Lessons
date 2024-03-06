import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _dateSelected;
  Category? _selectedCategory = Category.leisure;

  void _presentCalender() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    var pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);

    setState(() {
      _dateSelected = pickedDate;
    });
  }

  void _onSelectCategory(Category? value) {
    if (value == null) {
      return;
    }

    setState(() {
      _selectedCategory = value;
    });
  }

  void _onSubmit() {
    final amount = double.tryParse(_amountController.text);
    //double.tryParse("jj") => null, double.tryParse("1.12") => 1.12

    final isAmountInvalid = amount == null || amount <= 0;

    if (_titleController.text.trim().isEmpty ||
        isAmountInvalid ||
        _dateSelected == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              'Please make sure the valid title, amount or catalog is selected'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Ok'),
            )
          ],
        ),
      );
      return;
    }

    widget.onAddExpense(
      Expense(
          title: _titleController.text,
          amount: amount,
          date: _dateSelected!,
          category: _selectedCategory!),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return SizedBox(
      height: double.infinity, // so that modal gets full height of the screen
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
          child: Column(
            children: [
              Text(
                'Add New Expense',
                style: GoogleFonts.lato(fontSize: 22),
                textAlign: TextAlign.left,
              ),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  label: Text(
                    'Title',
                    style: GoogleFonts.lato(fontSize: 14),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixText: '\$',
                        label: Text(
                          'Amount',
                          style: GoogleFonts.lato(fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          _dateSelected == null
                              ? 'Select Date'
                              : formatter.format(_dateSelected!),
                        ),
                        IconButton(
                          onPressed: _presentCalender,
                          icon: const Icon(Icons.calendar_month),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  DropdownButton(
                      value: _selectedCategory,
                      items: Category.values
                          .map((category) => DropdownMenuItem(
                                value: category,
                                child: Text(
                                  category.name.toUpperCase(),
                                ),
                              ))
                          .toList(),
                      onChanged: _onSelectCategory),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: _onSubmit,
                    child: const Text('Save Expense'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
