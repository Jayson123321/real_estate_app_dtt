import 'package:flutter/material.dart';

class HouseListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('House List'),
    ),
    body: Center(
      child: Text('This is the house list view'),
    ),
    );
  }
}