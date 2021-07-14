import 'package:flutter/material.dart';

void main() {
  runApp(ShoppingCart());
}

class ShoppingCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Cart',
      home: CartScreen(),
    );
  }
}

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<String> _itemList = <String>[];
  final _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('To-do List')),
      ),
      body: ListView(children: _getItems()),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayDialog(context),
        tooltip: 'Add Item',
        child: Icon(Icons.add),
      ),
    );
  }

  void _addItem(String title) {
    setState(() {
      _itemList.add(title);
    });
    _textController.clear();
    _focusNode.requestFocus();
  }

  void _deleteItem(String title) {
    setState(() {
      _itemList.remove(title);
    });
  }

  Widget _buildItem(String title) {
    return Card(
      child: ListTile(
        title: Text(title),
        trailing: IconButton(
          onPressed: () async => _deleteItem(title),
          icon: Icon(
            Icons.delete_outlined,
          ),
        ),
      ),
      color: Colors.amber.shade200,
    );
  }

  _displayDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add your item to the list'),
          content: TextField(
            controller: _textController,
            decoration: const InputDecoration(hintText: 'Enter item here'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ADD'),
              onPressed: () {
                Navigator.of(context).pop();
                _addItem(_textController.text);
              },
              focusNode: _focusNode,
            ),
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  List<Widget> _getItems() {
    final List<Widget> _itemWidgets = <Widget>[];
    for (String title in _itemList) {
      _itemWidgets.add(_buildItem(title));
    }
    return _itemWidgets;
  }
}
