import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list_app/models/list_item.dart';
import 'package:shopping_list_app/providers/items_provider.dart';
import 'package:shopping_list_app/widgets/number_input.dart';
import 'package:shopping_list_app/utils/constants.dart' as constants;
import 'custom_dialog.dart';

class EditItemDialog extends StatefulWidget {
  final ListItem item;

  const EditItemDialog({super.key, required this.item});

  @override
  State<EditItemDialog> createState() => _EditItemDialogState();
}

class _EditItemDialogState extends State<EditItemDialog> {
  final itemTitleController = TextEditingController();
  final itemAmountController = TextEditingController();
  final priceController = TextEditingController();
  int amount = 0;

  @override
  void initState() {
    itemTitleController.text = widget.item.title;
    itemAmountController.text = widget.item.amount.toString();
    priceController.text = widget.item.price.toString();
    amount = widget.item.amount;

    super.initState();
  }

  @override
  void dispose() {
    itemTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      children: [
        const Text(
          'Edit item',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 56,
          child: TextField(
            controller: itemTitleController,
            decoration: InputDecoration(
              filled: true,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              fillColor: constants.inputBackgroundFill,
              labelText: "Title",
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text('Price'),
        const SizedBox(height: 8),
        SizedBox(
          height: 56,
          child: TextField(
            controller: priceController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              filled: true,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              fillColor: constants.inputBackgroundFill,
              labelText: "Price",
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text('Amount'),
        const SizedBox(height: 8),
        NumberInput(
          amount: amount,
          decreaseCallback: () {
            if (amount > 0) {
              setState(() {
                amount--;
              });
            }
          },
          increaseCallback: () {
            setState(() {
              amount++;
            });
          },
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextButton(
              child:
                  const Text('Cancel', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            const SizedBox(width: 8),
            FilledButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    // Change your radius here
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                backgroundColor:
                    const MaterialStatePropertyAll<Color>(Colors.black),
                foregroundColor:
                    const MaterialStatePropertyAll<Color>(Colors.white),
              ),
              child: const Text('Save'),
              onPressed: () {
                ListItem item = widget.item;

                item.title = itemTitleController.text;
                item.amount = amount;
                item.price = double.parse(priceController.text);

                context
                    .read<ItemsProvider>()
                    .editItem(item);

                Navigator.of(context).pop(false);
              },
            ),
          ],
        ),
      ],
    );
  }
}
