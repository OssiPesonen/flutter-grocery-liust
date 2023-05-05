import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list_app/models/list_item.dart';
import 'package:shopping_list_app/providers/items_provider.dart';

class ListCard extends StatefulWidget {
  final ListItem item;

  const ListCard({Key? key, required this.item}) : super(key: key);

  @override
  State<ListCard> createState() => _ListCardState();
}

class _ListCardState extends State<ListCard> {
  Color getColor(Set<MaterialState> states) {
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      key: const Key('list-card'),
      elevation: 2,
      shadowColor: const Color.fromRGBO(0, 0, 0, 0.3),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
        child: Row(
          children: [
            Checkbox(
              key: const Key('list-card-item-toggle'),
              checkColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              fillColor: MaterialStateProperty.resolveWith(getColor),
              value: widget.item.isComplete,
              onChanged: (bool? value) {
                context.read<ItemsProvider>().toggleItem(widget.item.title);
              },
            ),
            Expanded(
              child: Text(
                key: const Key('list-card-item-title'),
                widget.item.title,
                textAlign: TextAlign.left,
              ),
            ),
            Row(
              children: [
                IconButton(
                  key: const Key('list-card-item-button-decrease'),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.remove_circle_outline_rounded,
                    size: 16,
                  ),
                ),
                const Text("1"),
                IconButton(
                  key: const Key('list-card-item-button-increase'),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.add_circle_outline_rounded,
                    size: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
