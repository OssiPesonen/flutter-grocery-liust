import 'package:hive/hive.dart';
import 'package:nanoid/nanoid.dart';

part 'list_item.g.dart';

@HiveType(typeId: 1)
class ListItem {
  /// Identifier
  @HiveField(1)
  final String id;

  /// Used to target item on list with actions
  String? targetId;

  /// Item title / description
  @HiveField(2)
  String title;

  /// Has the item been picked up
  @HiveField(3, defaultValue: false)
  bool isPickedUp;

  /// How many items are there to pick up
  @HiveField(4, defaultValue: 1)
  int amount;

  /// Product price
  @HiveField(5, defaultValue: 0.0)
  double price;

  ListItem({
    required this.id,
    required this.title,
    this.targetId,
    this.amount = 1,
    this.isPickedUp = false,
    this.price = 0.00,
  });
}
