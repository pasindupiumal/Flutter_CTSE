import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

/// Holds information about our app's flows.
class FoodItem {
  const FoodItem({
    @required this.item,
    @required this.quantity,
  })  : assert(item != null),
        assert(quantity != null);

  final DocumentSnapshot item;
  final int quantity;

}
