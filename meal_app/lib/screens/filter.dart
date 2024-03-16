import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/widgets/filter_option.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FilterState();
  }
}

class _FilterState extends State<FilterScreen> {
  var _isGlutenFree = false;
  var _isVegan = false;
  var _isVegetarian = false;
  var _isLactoseFree = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your filters'),
      ),
      body: Column(
        children: [
          FilterOption(
              enabled: _isGlutenFree,
              subtitle: 'Only include gluten-free meals.',
              title: 'Gluten-free',
              onChangeValue: (value) {
                setState(() {
                  _isGlutenFree = value;
                });
              }),
          FilterOption(
              enabled: _isLactoseFree,
              subtitle: 'Only include lactose-free meals.',
              title: 'Lactose-free',
              onChangeValue: (value) {
                setState(() {
                  _isLactoseFree = value;
                });
              }),
          FilterOption(
              enabled: _isVegan,
              subtitle: 'Only include vegan meals.',
              title: 'Vegan',
              onChangeValue: (value) {
                setState(() {
                  _isVegan = value;
                });
              }),
          FilterOption(
              enabled: _isVegetarian,
              subtitle: 'Only include vegetarian meals.',
              title: 'Vegeterian',
              onChangeValue: (value) {
                setState(() {
                  _isVegetarian = value;
                });
              })
        ],
      ),
    );
  }
}
