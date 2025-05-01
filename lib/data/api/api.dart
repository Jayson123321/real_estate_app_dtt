import 'package:flutter_dotenv/flutter_dotenv.dart';




class Api {
  static const String REALESTATE_BASE_URL = "https://intern.d-tt.nl/api/house";
  static String get accessKey => dotenv.env['DTT_API_KEY'] ?? '';
}
