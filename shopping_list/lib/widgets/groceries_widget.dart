import 'package:flutter/material.dart';
import 'package:shopping_list/data/dummy_items.dart';

class Groceries extends StatelessWidget {
  const Groceries({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
      ),
      body: ListView.builder(
          itemCount: groceryItems.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(groceryItems[index].name),
              leading: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: groceryItems[index].category.color,
                ),
              ),
              trailing: Text("${groceryItems[index].quantity}"),
            );
          }),
    );
  }
}
