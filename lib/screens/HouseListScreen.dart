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
            // sort houses by price. Cheapest first
            houses.sort((a,b) => a.price.compareTo(b.price));


            return ListView.builder(
              itemCount: houses.length,
              itemBuilder: (context, index) {
                final house = houses[index];
                return Card(
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: Image.network(
                      'https://intern.d-tt.nl${house.image}',
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    title: Text('\$${house.price}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Row(
                        children: [
                        Text(house.zip),
                        SizedBox(width: 8),
                        Text(house.city),
                    ],
                  ),
                      SizedBox(height: 6),
                      Row(
                      children: [
                        SvgPicture.asset('assets/icons/ic_bed.svg', width: 16, height: 16),
                        SizedBox(width: 4),
                        Text('${house.bedrooms}'),
                        SizedBox(width: 12),

                        SvgPicture.asset('assets/icons/ic_bath.svg', width: 16, height: 16),
                        SizedBox(width: 4),
                        Text('${house.bathrooms}'),
                        SizedBox(width: 12),

                        SvgPicture.asset('assets/icons/ic_layers.svg', width: 16, height: 16),
                        SizedBox(width: 4),
                        Text('${house.size} m²'),
                        SizedBox(width: 12),

                        SvgPicture.asset('assets/icons/ic_location.svg', width: 16, height: 16),
                        SizedBox(width: 4),
                        Text('${house.latitude}'),
                      ],
                    ),
                    ],
                    ),
                    onTap: () {
                      print('Tapped on house ID ${house.id}');
                    },
                  ),
                );
              },
            );
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
