import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../models/RealEstateModel.dart';
import '../services/RealEstateService.dart';

class HouseListScreen extends StatefulWidget {
  @override
  State<HouseListScreen> createState() => _HouseListScreenState();
}

class _HouseListScreenState extends State<HouseListScreen> {
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
        title: Text('DTT Real Estate'),
      ),
      body: FutureBuilder<List<RealEstateModel>>(
        future: futureHouses,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load houses'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No houses available'));
          } else {
          final houses = snapshot.data!;

          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
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
          // Later: navigatie logica
        },
      ),
    );
  }
}
