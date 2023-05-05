import 'package:flutter/material.dart';
import 'package:shopping_list_app/models/list_item.dart';
import 'package:shopping_list_app/providers/items_provider.dart';
import 'package:provider/provider.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
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
          key: const Key('home-appbar-textfield'),
          controller: appBarTextFieldController,
          onSubmitted: (value) {
            context.read<ItemsProvider>().addItem(
                  ListItem(
                    title: value,
                    isComplete: false,
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
            fillColor: const Color.fromRGBO(0, 0, 0, 0.05),
            labelText: "Add item to list",
          ),
        ),
      ],
    );
  }
}
