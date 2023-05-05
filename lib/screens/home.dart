import 'package:flutter/material.dart';
import 'package:shopping_list_app/providers/items_provider.dart';
import 'package:shopping_list_app/widgets/home/home_bottom_navigation.dart';
import 'package:shopping_list_app/widgets/home/home_app_bar.dart';
import 'package:shopping_list_app/widgets/list_card.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const HomeBottomNavigation(),
      appBar: AppBar(
        key: const Key('home-appbar'),
        backgroundColor: Colors.white,
        foregroundColor: const Color.fromRGBO(50, 50, 50, 1),
        shadowColor: Colors.transparent,
        toolbarHeight: 100,
        title: const HomeAppBar(),
      ),
      body: Center(
        key: const Key('home-body'),
        child: ListView.builder(
          itemCount: context.watch<ItemsProvider>().items.length,
          itemBuilder: (context, index) {
            return ListCard(item: context.watch<ItemsProvider>().items[index]);
          },
        ),
      ),
    );
  }
}
