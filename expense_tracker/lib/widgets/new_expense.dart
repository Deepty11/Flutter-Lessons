import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widgets/component/amount_field.dart';
import 'package:expense_tracker/widgets/component/calender_field.dart';
import 'package:expense_tracker/widgets/component/category_dropdown.dart';
import 'package:expense_tracker/widgets/component/submit_button.dart';
import 'package:expense_tracker/widgets/component/title_field.dart';
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

    return LayoutBuilder(builder: (cxt, constraints) {
      final width = constraints.maxWidth;

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
                if (width >= 600)
                  Row(
                    children: [
                      Expanded(child: TitleField(_titleController)),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(child: AmountField(_amountController)),
                    ],
                  )
                else
                  TitleField(_titleController),
                if (width >= 600)
                  Row(
                    children: [
                      CalenderField(_dateSelected, _presentCalender),
                      const Spacer(),
                      CategoryDropdown(_selectedCategory, _onSelectCategory),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: AmountField(_amountController),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: CalenderField(_dateSelected, _presentCalender),
                      )
                    ],
                  ),
                const SizedBox(
                  height: 16,
                ),
                if (width >= 600)
                  SubmitButton(
                    () {
                      Navigator.pop(context);
                    },
                    _onSubmit,
                  )
                else
                  Row(
                    children: [
                      CategoryDropdown(_selectedCategory, _onSelectCategory),
                      const Spacer(),
                      SubmitButton(
                        () {
                          Navigator.pop(context);
                        },
                        _onSubmit,
                      )
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
