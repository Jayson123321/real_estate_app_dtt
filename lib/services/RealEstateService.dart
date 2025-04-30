import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/RealEstateModel.dart';
import '../data/api/api.dart';


class RealEstateService {
  Future<List<RealEstateModel>> fetchHouses() async {
    final response = await http.get(
      Uri.parse(Api.REALESTATE_BASE_URL),
      headers: {
        'Access-Key': Api.accessKey,
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      print('Response data: $data');
      return data.map((houseJson) => RealEstateModel.fromJson(houseJson)).toList();
    } else {
      throw Exception('Failed to load houses');
    }
  }
}
