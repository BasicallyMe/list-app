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

class ShoppingList extends StatelessWidget {
  ShoppingList({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        trailing: Icon(
          Icons.remove_outlined,
          color: Colors.white,
        ),
      ),
      color: Color.fromRGBO(255, 255, 255, 0.3),
      elevation: 0,
      margin: EdgeInsets.only(bottom: 6.0),
    );
  }
}

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _textColor = Color.fromRGBO(255, 103, 94, 1);
  final _textController = TextEditingController();
  final List<ShoppingList> _listItems = [];
  final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 103, 94, 1),
      appBar: AppBar(
        title: Center(
          child: Text(
            'Your Cart',
            style: TextStyle(
              color: _textColor,
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Flexible(
            child: Center(
              child: ListView.builder(
                padding: EdgeInsets.all(8.0),
                reverse: true,
                itemBuilder: (_, int index) => _listItems[index],
                itemCount: _listItems.length,
              ),
            ), 
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 6.0),
            child: _buildTextComposer(),
          )
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: InputDecoration(
                hintText: 'Type an item',
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              focusNode: _focusNode,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
              icon: const Icon(
                Icons.add_outlined,
                color: Colors.white,
                size: 30.0,
              ),
              onPressed: () => _handleSubmitted(_textController.text),
            ),
          )
        ],
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    ShoppingList listItem = ShoppingList(
      text: text,
    );
    setState(() {
      _listItems.insert(0, listItem);
    });
    _focusNode.requestFocus();
  }
}
