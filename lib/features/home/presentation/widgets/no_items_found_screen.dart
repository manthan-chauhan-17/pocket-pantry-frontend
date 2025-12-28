import 'package:flutter/material.dart';

class NoItemsFoundScreen extends StatelessWidget {
  const NoItemsFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('No items found.')));
  }
}
