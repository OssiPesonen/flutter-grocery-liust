import 'package:flutter/material.dart';
import 'package:shopping_list_app/providers/items_provider.dart';
import 'package:shopping_list_app/widgets/empty_list.dart';
import 'package:shopping_list_app/widgets/bottom_navigation.dart';
import 'package:shopping_list_app/widgets/add_item_input.dart';
import 'package:shopping_list_app/widgets/item_list.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var listItemCount = context.watch<ItemsProvider>().items.length;

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: const BottomNavigation(),
        appBar: AppBar(
          key: const Key('home-appbar'),
          backgroundColor: Colors.white,
          foregroundColor: const Color.fromRGBO(50, 50, 50, 1),
          shadowColor: Colors.transparent,
          toolbarHeight: 100,
          title: const AddItemInput(),
        ),
        body: listItemCount == 0
            ? const EmptyList()
            : SafeArea(
                key: const Key('home-body'),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ItemList(
                        items: context
                            .read<ItemsProvider>()
                            .items
                            .where((element) => !element.isPickedUp)
                            .toList(),
                      ),
                      const SizedBox(height: 8),
                      if (context
                          .read<ItemsProvider>()
                          .items
                          .reversed
                          .where((element) => element.isPickedUp)
                          .toList()
                          .isNotEmpty)
                        const Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            'Picked up items',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ItemList(
                        items: context
                            .read<ItemsProvider>()
                            .items
                            .where((element) => element.isPickedUp)
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
