import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';

class CategoryDropdown extends StatelessWidget {
  final Category? _selectedCategory;
  final void Function(Category? value) _onSelectCategory;

  const CategoryDropdown(this._selectedCategory, this._onSelectCategory,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: _selectedCategory,
      items: Category.values
          .map((category) => DropdownMenuItem(
                value: category,
                child: Text(
                  category.name.toUpperCase(),
                ),
              ))
          .toList(),
      onChanged: _onSelectCategory,
    );
  }
}
