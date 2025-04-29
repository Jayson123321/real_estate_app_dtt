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
  String searchQuery = '';

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
            // Sort houses by price. Cheapestf First
            houses.sort((a, b) => a.price.compareTo(b.price));
            // Filter houses based on search query
            final filteredHouses = houses.where((house) {
              return house.zip.contains(searchQuery);
            }).toList();

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  // Search Field looking for zip code
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Search zip',
                        // suffixIcon for incon right side
                        suffixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset('assets/icons/ic_search.svg'),
                      ),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: filteredHouses.isEmpty
                      ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/images/search_state_empty.png', width: 200,),
                        SizedBox(height: 16),
                        Text(
                          'No results found!',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Perhaps try another search?',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                      : ListView.builder(
                    itemCount: filteredHouses.length,
                    itemBuilder: (context, index) {
                      final house = filteredHouses[index];
                      return Card(
                        child: ListTile(
                          contentPadding: EdgeInsets.all(10),
                          leading: Image.network(
                            'https://intern.d-tt.nl${house.image}',
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            '\$${house.price}',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
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
                  ),
                ),
              ],
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: ''),
        ],
        currentIndex: 0,
        onTap: (index) {

        },
      ),
    );
  }
}
