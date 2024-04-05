import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list/data/dummy_categories.dart';
import 'package:shopping_list/data/dummy_items.dart';
import 'package:shopping_list/model/category.dart';
import 'package:shopping_list/model/grocery_item.dart';
import 'package:shopping_list/widgets/new_item.dart';

class Groceries extends StatefulWidget {
  const Groceries({super.key});

  @override
  State<Groceries> createState() => _GroceriesState();
}

class _GroceriesState extends State<Groceries> {
  List<GroceryItem> _groceries = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadItem();
  }

  void _loadItem() async {
    final url = Uri.https(
        'fir-prep-91db6-default-rtdb.firebaseio.com', 'shopping-list.json');
    try {
      final response = await http.get(url);
      if (response.statusCode >= 400) {
        setState(() {
          _error = "Failed to fetch items now. Try again later!";
        });
      }

      if (response.body == 'null') {
        setState(() {
          _isLoading = false;
          return;
        });
      }

      final Map<String, dynamic> listItems = json.decode(response.body);
      List<GroceryItem> list = [];

      for (final item in listItems.entries) {
        final Category category = categories.entries
            .where(
              (element) => element.value.title == item.value['category'],
            )
            .first
            .value;

        list.add(
          GroceryItem(
            id: item.key,
            name: item.value['name'],
            category: category,
            quantity: item.value['quantity'],
          ),
        );
      }

      setState(() {
        _groceries = list;
        _isLoading = false;
      });
    } catch (error) {
      _error = "Something was wrong. Try again later!";
    }
  }

  void _onPressAddButton(BuildContext context) async {
    final newItem = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const NewItem()));

    setState(() {
      _groceries.add(newItem);
    });
  }

  void _onRemoveItem(GroceryItem item) async {
    final index = _groceries.indexOf(item);

    setState(() {
      _groceries.remove(item);
    });

    final Uri url = Uri.https('fir-prep-91db6-default-rtdb.firebaseio.com',
        'shopping-list/${item.id}.json');

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      setState(() {
        _groceries.insert(index, item);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activeWidget = Center(
      child: Text(
        'You got no grocery yet',
        style: Theme.of(context).textTheme.titleLarge,
        textAlign: TextAlign.center,
      ),
    );

    if (_isLoading) {
      activeWidget = const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_error != null) {
      activeWidget = Center(
        child: Text(_error!),
      );
    }

    activeWidget = _groceries.isEmpty
        ? activeWidget
        : ListView.builder(
            itemCount: _groceries.length,
            itemBuilder: (context, index) {
              return Dismissible(
                onDismissed: (direction) {
                  _onRemoveItem(_groceries[index]);
                },
                key: ValueKey(_groceries[index].id),
                child: ListTile(
                  title: Text(_groceries[index].name),
                  leading: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: _groceries[index].category.color,
                    ),
                  ),
                  trailing: Text(_groceries[index].quantity.toString()),
                ),
              );
            });

    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Groceries'),
          actions: [
            IconButton(
              onPressed: () {
                _onPressAddButton(context);
              },
              icon: const Icon(Icons.add),
            )
          ],
        ),
        body: activeWidget);
  }
}
