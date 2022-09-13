import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<dynamic>> getCrptoData() async {
    try {
      Uri url = Uri.parse(
          'https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=20&page=1&sparkline=false');
      http.Response response = await http.get(url);
      var decodedResponse = jsonDecode(response.body);
      final List<dynamic> cryptoData = decodedResponse as List<dynamic>;
      return cryptoData;
    } catch (exception) {
      return [];
    }
  }
}
