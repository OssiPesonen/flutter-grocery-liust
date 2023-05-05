import 'package:flutter/material.dart';
import 'package:shopping_list_app/providers/items_provider.dart';
import 'package:provider/provider.dart';

class HomeBottomNavigation extends StatelessWidget {
  const HomeBottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: const Key('home-bottom-navigation'),
      height: 80,
      child: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: const Color.fromRGBO(0, 0, 0, 0.05),
              radius: 28,
              child: IconButton(
                color: Colors.black,
                key: const Key('home-bottom-navigation-button-clear-list'),
                onPressed: () {
                  context.read<ItemsProvider>().clearItems();
                },
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                icon: const Icon(
                  Icons.delete_outline_outlined,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
