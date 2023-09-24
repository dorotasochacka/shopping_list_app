import 'package:flutter/material.dart';
import 'package:shopping_list_app/models/grocery_item.dart';
import 'package:shopping_list_app/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groceryList = [];

  addNewItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(builder: (context) {
        return const NewItem();
      }),
    );

    if (newItem == null) {
      return;
    }

    setState(() {
      _groceryList.add(newItem);
    });
  }

  void _removeItem(GroceryItem item) {
    setState(() {
      _groceryList.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: Image(
              color: const Color.fromARGB(255, 50, 58, 60).withOpacity(1.0),
              colorBlendMode: BlendMode.darken,
              width: double.infinity,
              image: const AssetImage('assets/sad.jpeg'),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'You have no groceries!',
            style: Theme.of(context).textTheme.displaySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
    if (_groceryList.isNotEmpty) {
      content = ListView.builder(
          itemCount: _groceryList.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: ValueKey(_groceryList[index].id),
              onDismissed: (direction) => _removeItem(_groceryList[index]),
              child: ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                      color: _groceryList[index].category.color,
                      borderRadius: BorderRadius.circular(2)),
                  height: 24,
                  width: 24,
                ),
                title: Text(
                  _groceryList[index].name,
                ),
                trailing: Text(_groceryList[index].quantity.toString()),
              ),
            );
          });
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Your groceries'),
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: addNewItem,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: content);
  }
}
