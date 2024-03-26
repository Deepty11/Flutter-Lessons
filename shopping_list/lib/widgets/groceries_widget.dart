import 'package:flutter/material.dart';
import 'package:shopping_list/data/dummy_items.dart';
import 'package:shopping_list/model/grocery_item.dart';
import 'package:shopping_list/widgets/new_item.dart';

class Groceries extends StatefulWidget {
  const Groceries({super.key});

  @override
  State<Groceries> createState() => _GroceriesState();
}

class _GroceriesState extends State<Groceries> {
  final List<GroceryItem> _groceries = [];

  void _onPressAddButton(BuildContext context) async {
    final addedItem = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const NewItem()));

    setState(() {
      _groceries.add(addedItem);
    });
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

    activeWidget = _groceries.isEmpty
        ? activeWidget
        : ListView.builder(
            itemCount: _groceries.length,
            itemBuilder: (context, index) {
              return Dismissible(
                onDismissed: (direction) {
                  setState(() {
                    _groceries.remove(_groceries[index]);
                  });
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
