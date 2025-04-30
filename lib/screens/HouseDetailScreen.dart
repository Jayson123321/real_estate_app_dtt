import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/RealEstateModel.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HouseDetailScreen extends StatelessWidget {
  final RealEstateModel house;

  const HouseDetailScreen({super.key, required this.house});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.network(
                'https://intern.d-tt.nl${house.image}',
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 40,
                left: 16,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.arrow_back, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              padding: EdgeInsets.all(20),
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${house.price}',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset('assets/icons/ic_bed.svg', width: 18),
                          SizedBox(width: 4),
                          Text('${house.bedrooms}'),
                          SizedBox(width: 12),
                          SvgPicture.asset('assets/icons/ic_bath.svg', width: 18),
                          SizedBox(width: 4),
                          Text('${house.bathrooms}'),
                          SizedBox(width: 12),
                          SvgPicture.asset('assets/icons/ic_layers.svg', width: 18),
                          SizedBox(width: 4),
                          Text('${house.size}'),
                          SizedBox(width: 12),
                          SvgPicture.asset('assets/icons/ic_location.svg', width: 18),
                          SizedBox(width: 4),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Text('Description', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text(house.description),
                  SizedBox(height: 24),

                  Text('Location', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      height: 200,
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(house.latitude, house.longitude),
                          zoom: 14,
                        ),
                        markers: {
                          Marker(
                            markerId: MarkerId('house-location'),
                            position: LatLng(house.latitude, house.longitude),
                          ),
                        },
                        zoomControlsEnabled: false,
                        myLocationButtonEnabled: false,
                        liteModeEnabled: true,
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
