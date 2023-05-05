import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  final String title;

  const ListCard({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: const Color.fromRGBO(0, 0, 0, 0.2),
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
        child: Text(title)
      ),
    );
  }
}
