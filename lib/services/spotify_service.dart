import 'dart:convert';
import 'package:http/http.dart' as http;

class SpotifyService {
  static const _baseUrl = 'https://api.spotify.com/v1';

  Future<Map<String, dynamic>> fetchProfile(String accessToken) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/me'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to fetch Spotify profile (${response.statusCode})',
      );
    }

    return json.decode(response.body);
  }
}
