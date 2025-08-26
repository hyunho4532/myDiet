import 'package:flutter/material.dart';

class Item<T> extends StatefulWidget {
  final List<T> data;

  const Item({
    super.key,
    required this.data
  });

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
