import 'package:flutter/material.dart';
import 'package:shopping_list_app/models/list_item.dart';
import 'package:shopping_list_app/widgets/list_card.dart';

class ItemList extends StatelessWidget {
  final List<ListItem> items;

  const ItemList({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListCard(item: items[index]);
      },
    );
  }
}
