class Product {
  final String name;
  final String item;
  final int remainingDays;
  final int remainingPercent;
  final int remainingUsage;

  Product(
      {this.name,
      this.item,
      this.remainingDays,
      this.remainingPercent,
      this.remainingUsage});

  factory Product.fromJson(name, snapshot) {
    var map = new Map<String, dynamic>.from(snapshot);

    return Product(
        name: name,
        item: map['current_item'] as String,
        remainingDays: (map['remaining_days']).toInt() as int,
        remainingPercent: (map['remaining_percent'] * 100).toInt() as int,
        remainingUsage: (map['remaining_usages']).toInt() as int);
  }
}
