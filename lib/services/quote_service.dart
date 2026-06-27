import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/quote_model.dart';

class QuoteService {
  static Future<QuoteModel> getRandomQuote() async {
    final response = await http.get(
      Uri.parse('https://zenquotes.io/api/random'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return QuoteModel.fromJson(data[0]);
    } else {
      throw Exception('Failed to load quote');
    }
  }
}
