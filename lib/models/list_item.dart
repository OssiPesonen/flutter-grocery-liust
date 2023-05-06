class ListItem {
  /// UUID
  final String id;
  /// Item title / description
  String title;
  /// Has the item been picked up
  bool isPickedUp;
  /// How many items are there to pick up
  int amount;

  ListItem({
    required this.id,
    required this.title,
    required this.isPickedUp,
    required this.amount,
  });
}
