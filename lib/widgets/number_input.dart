import 'package:flutter/material.dart';
import 'package:shopping_list_app/utils/constants.dart' as constants;

import '../models/list_item.dart';

class NumberInput extends StatefulWidget {
  final int amount;
  final Function decreaseCallback;
  final Function increaseCallback;

  const NumberInput({Key? key,required this.decreaseCallback, required this.increaseCallback, required this.amount}) : super(key: key);

  @override
  State<NumberInput> createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: constants.inputBackgroundFill,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          decreaseAmountButton(context, widget.decreaseCallback),
          Expanded(
            flex: 4,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(widget.amount.toString(),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          increaseAmountButton(context, widget.increaseCallback),
        ],
      ),
    );
  }
}

Expanded increaseAmountButton(BuildContext context, Function callback) {
  return Expanded(
    flex: 1,
    child: IconButton(
      onPressed: () {
        callback();
      },
      icon: const Icon(
        Icons.add_circle_outline_sharp,
        size: 24,
        color: Colors.black,
      ),
    ),
  );
}

Expanded decreaseAmountButton(BuildContext context, Function callback) {
  return Expanded(
    flex: 1,
    child: IconButton(
      onPressed: () {
        callback();
      },
      icon: const Icon(
        Icons.remove_circle_outline_sharp,
        size: 24,
        color: Colors.black,
      ),
    ),
  );
}
