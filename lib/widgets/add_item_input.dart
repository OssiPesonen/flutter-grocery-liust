import 'package:flutter/material.dart';
import 'package:nanoid/nanoid.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list_app/models/list_item.dart';
import 'package:shopping_list_app/providers/items_provider.dart';
import 'package:shopping_list_app/utils/constants.dart' as constants;

class AddItemInput extends StatefulWidget {
  const AddItemInput({Key? key}) : super(key: key);

  @override
  State<AddItemInput> createState() => _AddItemInputState();
}

class _AddItemInputState extends State<AddItemInput> {
  final appBarTextFieldController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    appBarTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          key: const Key('appbar-textfield'),
          controller: appBarTextFieldController,
          onSubmitted: (value) {
            context.read<ItemsProvider>().addItem(
                  ListItem(
                    id: nanoid(),
                    title: value,
                    isPickedUp: false,
                    amount: 1,
                  ),
                );

            appBarTextFieldController.text = '';
          },
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
            labelText: "Add item to list",
          ),
        ),
      ],
    );
  }
}
