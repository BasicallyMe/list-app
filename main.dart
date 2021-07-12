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
  ShoppingList({required this.text, required this.animationController});
  final String text;
  final AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor:
          CurvedAnimation(parent: animationController, curve: Curves.bounceOut),
      axisAlignment: 0.0,
      child: Card(
        child: ListTile(
          title: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
        color: Color.fromRGBO(255, 255, 255, 0.3),
        elevation: 0,
        margin: EdgeInsets.only(bottom: 6.0),
      ),
    );
  }
}

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with TickerProviderStateMixin {
  //Variable used in the class
  final _textColor = Color.fromRGBO(255, 103, 94, 1);
  final _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final List<ShoppingList> _listItems = [];
  bool _isComposing = false;
//Build method to create the basic visual layout of the app
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
  //build the textfield 
  Widget _buildTextComposer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: _textController,
              onChanged: (String text) {
                setState(() {
                  _isComposing = text.isNotEmpty;
                });
              },
              onSubmitted: _isComposing ? _handleSubmitted : null,
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
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            child: Center(
              child: IconButton(
                icon: const Icon(
                  Icons.add_outlined,
                  color: Colors.white,
                  size: 30.0,
                ),
                onPressed: _isComposing ? () => _handleSubmitted(_textController.text) : null,
              ),
            ),
          )
        ],
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });
    ShoppingList listItem = ShoppingList(
      text: text,
      animationController: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200),
      ),
    );
    setState(() {
      _listItems.insert(0, listItem);
    });
    _focusNode.requestFocus();
    listItem.animationController.forward();
  }

  @override
  void dispose() {
    for (var listItem in _listItems) {
      listItem.animationController.dispose();
    }
    super.dispose();
  }
}
