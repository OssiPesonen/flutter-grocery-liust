import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(
            Icons.cake_outlined,
            size: 48,
          ),
          SizedBox(
            height: 24,
          ),
          Text(
            'Start by adding an item to your shopping list!',
          ),
        ],
      ),
    );
  }
}
