import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;
  String? _authToken;

  ApiService({required this.baseUrl});

  void setAuthToken(String token) {
    _authToken = token;
  }

  Future<dynamic> _handleRequest(String url, String method,
      {Map<String, String>? headers, dynamic body}) async {
    Uri uri = Uri.parse('$baseUrl$url');
    http.Response response;

    headers = headers ?? {};
    if (_authToken != null) {
      headers['Authorization'] = 'Bearer $_authToken';
    }

    try {
      switch (method.toUpperCase()) {
        case 'GET':
          response = await http.get(uri, headers: headers);
          break;
        case 'POST':
          response =
              await http.post(uri, headers: headers, body: jsonEncode(body));
          break;
        case 'PUT':
          response =
              await http.put(uri, headers: headers, body: jsonEncode(body));
          break;
        case 'PATCH':
          response =
              await http.patch(uri, headers: headers, body: jsonEncode(body));
          break;
        case 'DELETE':
          response = await http.delete(uri, headers: headers);
          break;
        default:
          throw Exception('Unsupported HTTP method');
      }

      return _processResponse(response);
    } catch (e) {
      throw Exception('Failed to make $method request: $e');
    }
  }

  dynamic _processResponse(http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode >= 200 && statusCode < 300) {
      final decoded = jsonDecode(response.body);

      // Retorna a resposta decodificada diretamente
      if (decoded is List) {
        return List<dynamic>.from(decoded);
      } else if (decoded is Map) {
        return Map<String, dynamic>.from(decoded);
      } else {
        throw Exception('Unsupported response type');
      }
    } else {
      throw Exception('Failed with status code: $statusCode');
    }
  }

  Future<dynamic> get(String url, {Map<String, String>? headers}) async {
    return _handleRequest(url, 'GET', headers: headers);
  }

  Future<dynamic> post(String url, dynamic body,
      {Map<String, String>? headers}) async {
    return _handleRequest(url, 'POST', headers: headers, body: body);
  }

  Future<dynamic> put(String url, dynamic body,
      {Map<String, String>? headers}) async {
    return _handleRequest(url, 'PUT', headers: headers, body: body);
  }

  Future<dynamic> patch(String url, dynamic body,
      {Map<String, String>? headers}) async {
    return _handleRequest(url, 'PATCH', headers: headers, body: body);
  }

  Future<dynamic> delete(String url, {Map<String, String>? headers}) async {
    return _handleRequest(url, 'DELETE', headers: headers);
  }
}

String apiUrl = dotenv.env['BASE_API_URL'] ?? 'Default API URL';

ApiService apiService = ApiService(baseUrl: apiUrl);
