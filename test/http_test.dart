import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'http_test.mocks.dart';
//teste do http pedido na aatividade :)

@GenerateMocks([http.Client])
void main() {
  group('HTTP Client Tests', () {
    test('Testa a resposta HTTP', () async {
      final client = MockClient();

      when(client.get(Uri.parse('https://example.com')))
          .thenAnswer((_) async => http.Response('{"title": "Test"}', 200));

      final response = await client.get(Uri.parse('https://example.com'));

      expect(response.statusCode, 200);
      expect(response.body, '{"title": "Test"}');
    });
  });
}
