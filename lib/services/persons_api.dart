import 'dart:convert';
import 'package:famous/models/Person.dart';
import 'package:famous/models/Person_Details.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<Person>> fetchPersons() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/person/popular?api_key=2dfe23358236069710a379edd4c65a6b'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body)['results'];
      return jsonData.map((json) => Person.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<PersonDetails> fetchPersonDetails(int id) async {
    const String apiKey = '2dfe23358236069710a379edd4c65a6b';
    final String url =
        'https://api.themoviedb.org/3/person/$id?api_key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return PersonDetails.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load person details');
    }
  }
}
