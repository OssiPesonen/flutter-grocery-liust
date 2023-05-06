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
      key: Key("list-card-${widget.item.id}"),
      elevation: widget.item.isPickedUp ? 0 : 2,
      shadowColor: const Color.fromRGBO(0, 0, 0, 0.3),
      color: widget.item.isPickedUp
          ? const Color.fromRGBO(0, 0, 0, 0.05)
          : Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
        child: Row(
          children: [
            Checkbox(
              key: Key("list-card-item-toggle-${widget.item.id}"),
              checkColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              fillColor: MaterialStateProperty.resolveWith(getColor),
              value: widget.item.isPickedUp,
              onChanged: (bool? value) {
                context.read<ItemsProvider>().toggleItemPicked(widget.item.id);
              },
            ),
            Expanded(
              child: Text(
                key: Key("list-card-item-title-${widget.item.id}"),
                widget.item.title,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: widget.item.isPickedUp
                      ? const Color.fromRGBO(0, 0, 0, 0.5)
                      : Colors.black,
                ),
              ),
            ),
            Row(
              children: [
                if (!widget.item.isPickedUp)
                  SizedBox(
                    width: 48,
                    child: IconButton(
                      key: Key(
                          "list-card-item-button-decrease-${widget.item.id}"),
                      onPressed: () {
                        context
                            .read<ItemsProvider>()
                            .decreaseAmount(widget.item.id);
                      },
                      icon: const Icon(
                        Icons.remove_circle_outline_rounded,
                        size: 16,
                      ),
                    ),
                  ),
                Text(widget.item.amount.toString(),
                    key: Key("list-card-item-amount-${widget.item.id}")),
                if (!widget.item.isPickedUp)
                  SizedBox(
                    width: 48,
                    child: IconButton(
                      key: Key(
                          "list-card-item-button-increase-${widget.item.id}"),
                      onPressed: () {
                        context
                            .read<ItemsProvider>()
                            .increaseAmount(widget.item.id);
                      },
                      icon: const Icon(
                        Icons.add_circle_outline_rounded,
                        size: 16,
                      ),
                    ),
                  )
                else
                  const SizedBox(width: 48),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
