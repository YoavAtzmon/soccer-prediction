import 'dart:convert';
import 'dart:io';

const String url =
    'https://apiv2.allsportsapi.com/football?met=Odds&APIkey=41ae247ecfb3e309b4c4099599848989c3f3f2a00d28e6b3e388ac6d8ac85fa1';

Future<dynamic> fetchOdds() async {
  final httpClient = HttpClient();
  try {
    final request = await httpClient.getUrl(Uri.parse(url));
    final response = await request.close();

    if (response.statusCode == HttpStatus.ok) {
      final jsonString = await response.transform(utf8.decoder).join();
      return json.decode(jsonString);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  } finally {
    httpClient.close();
  }
}

void main() async {
  try {
    final data = await fetchOdds();
    print(data);
  } catch (e) {
    print('Error: $e');
  }
}
