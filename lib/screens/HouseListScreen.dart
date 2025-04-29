import 'package:flutter/material.dart';

import '../models/RealEstateModel.dart';
import '../services/RealEstateService.dart';

class HouseListScreen extends StatefulWidget {
  @override
  State<HouseListScreen> createState() => _HouseListViewState();
}

class _HouseListViewState extends State<HouseListScreen> {
  late Future<List<RealEstateModel>> futureHouses;

  @override
  void initState() {
    super.initState();
    futureHouses = RealEstateService().fetchHouses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Houses'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: '',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
          // Handle bottom navigation
        },
      ),
    );
  }
}