class ListItem {
  /// UUID
  final String id;
  /// Item title / description
  String title;
  /// Has the item been picked up
  bool isPickedUp;
  /// How many items are there to pick up
  int amount;
  /// Product price
  double price;

  ListItem({
    required this.id,
    required this.title,
    required this.amount,
    this.isPickedUp = false,
    this.price = 0.00,
  });
}
