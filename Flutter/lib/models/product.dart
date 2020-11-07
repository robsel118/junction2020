import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

class Product {
  final String item;
  // final int remainingDays;
  // final int remainingPercent;
  // final int remainingUsage;

  Product({
    this.item,
    // this.remainingDays,
    // this.remainingPercent,
    // this.remainingUsage
  });

  factory Product.fromJson(snapshot) {
    var map = new Map<String, dynamic>.from(snapshot);

    return Product(
      item: map['current_item'] as String,
    );
  }
  Product.fromSnapshot(Map<String, dynamic> json) : item = json['item'];
}
