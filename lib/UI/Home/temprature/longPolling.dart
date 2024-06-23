import 'dart:async';
import 'dart:convert';
import 'dart:io';

class LongPolling {
  final String url;
  final Function(String) onData;
  late HttpClient _client;
  late Timer _timer;

  LongPolling(this.url, this.onData) {
    _client = HttpClient();
  }

  void start() {
    _makeRequest();
  }

  void _makeRequest() async {
    try {
      final request = await _client.getUrl(Uri.parse(url));
      request.headers.contentType = ContentType.json;
      /*request.add(
          utf8.encode(
              '{"action": "poll"}'
          )
      );*/
      final response = await request.close();

      if (response.statusCode == HttpStatus.ok) {
        response.transform(utf8.decoder).listen((data) {
          onData(data);
          _makeRequest();
        });
      } else {
        print('Error: ${response.statusCode}');
        _timer = Timer(
            Duration(seconds: 5), () => _makeRequest()
        );
      }
    } catch (e) {
      print('Error: $e');
      _timer = Timer(
          Duration(seconds: 5), () => _makeRequest()
      );
    }
  }

  void stop() {
    _timer?.cancel();
    _client.close();
  }
}