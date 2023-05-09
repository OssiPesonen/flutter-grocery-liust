import 'package:flutter/material.dart';
import 'package:nanoid/nanoid.dart';
import 'package:provider/provider.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
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
        TypeAheadFormField(
          key: const Key('appbar-textfield'),
          hideSuggestionsOnKeyboardHide: true,
          suggestionsBoxDecoration: SuggestionsBoxDecoration(
            elevation: 2,
            borderRadius: BorderRadius.circular(4),
          ),
          debounceDuration: const Duration(milliseconds: 200),
          textFieldConfiguration: TextFieldConfiguration(
            controller: appBarTextFieldController,
            onSubmitted: (value) {
              context.read<ItemsProvider>().addItem(
                    ListItem(
                      id: nanoid(),
                      title: value,
                    ),
                  );

              appBarTextFieldController.text = '';
            },
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  context.read<ItemsProvider>().addItem(
                        ListItem(
                          id: nanoid(),
                          title: appBarTextFieldController.text,
                        ),
                      );

                  appBarTextFieldController.text = '';
                },
                icon: const Icon(
                  Icons.playlist_add,
                  color: Colors.black,
                ),
              ),
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
          noItemsFoundBuilder: (context) {
            return Container(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
              child:
                  const Text('No items found', style: TextStyle(fontSize: 16)),
            );
          },
          suggestionsCallback: (pattern) {
            if (pattern == '') {
              return [];
            }

            return context.read<ItemsProvider>().getItems(pattern);
          },
          itemBuilder: (context, item) {
            return ListTile(
              title: Text(item.title),
            );
          },
          onSuggestionSelected: (item) {
            appBarTextFieldController.text = '';
            return context.read<ItemsProvider>().addItem(item);
          },
        ),
      ],
    );
  }
}
