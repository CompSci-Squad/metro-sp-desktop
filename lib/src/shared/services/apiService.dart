import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'dart:html' as html;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mime/mime.dart';

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

    headers['Content-Type'] = "application/json";

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

  Future< dynamic> get(String url,
      {Map<String, String>? headers}) async {
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

  Future<dynamic> delete(String url,
      {Map<String, String>? headers}) async {
    return _handleRequest(url, 'DELETE', headers: headers);
  }

  Future<Map<String, dynamic>> sendMultipartFormData({
    required String url,
    required Map<String, String> fields,
    required XFile file,
    required String fileFieldName,
    Map<String, String>? headers,
  }) async {
    Uri uri = Uri.parse('$baseUrl$url');
    headers ??= {};
    if (_authToken != null) {
      headers['Authorization'] = 'Bearer $_authToken';
    }

    // Check if the platform is Web or not
    if (kIsWeb) {
      // Web-specific code using html.FormData
      try {
        final mimeType = lookupMimeType(file.name) ?? 'application/octet-stream';
        var completer = Completer<Map<String, dynamic>>();
        final formData = html.FormData();

        // Add fields to FormData
        fields.forEach((key, value) {
          formData.append(key, value);
        });

        // Read file as bytes asynchronously (for Web)
        final bytes = await file.readAsBytes();
        final blob = html.Blob([bytes], mimeType);
        formData.appendBlob('file', blob, 'image.jpg');

        // Create the request
        final request = html.HttpRequest();
        request.open('POST', uri.toString());

        // Set headers
        headers.forEach((key, value) {
          request.setRequestHeader(key, value);
          if (key.toLowerCase() != 'content-type') {
            request.setRequestHeader(key, value);
          }
        });

        request.onLoadEnd.listen((e) async {
          if (request.status == 201) {
            final responseBody = request.responseText;
            try {
              completer.complete(jsonDecode(responseBody!));
            } catch (e) {
              completer.completeError('Failed to parse response body: $e');
            }
          } else {
            completer
                .completeError('Failed with status code: ${request.status}');
          }
        });

        // Send the request
        request.send(formData);

        return completer.future;
      } catch (e) {
        throw Exception('Failed to send multipart form data (Web): $e');
      }
    } else {
      // Non-Web (Mobile/Desktop) code using http.MultipartRequest
      var request = http.MultipartRequest('POST', uri);

      // Add fields to the request
      fields.forEach((key, value) {
        request.fields[key] = value;
      });

      // Add the image file to the request
      request.files
          .add(await http.MultipartFile.fromPath(fileFieldName, file.path));

      // Add headers
      request.headers.addAll(headers);

      try {
        // Send the request and get the response
        var response = await request.send();

        if (response.statusCode >= 200 && response.statusCode < 300) {
          var responseBody = await response.stream.bytesToString();
          try {
            return jsonDecode(responseBody);
          } catch (e) {
            throw Exception('Failed to parse response body: $e');
          }
        } else {
          throw Exception('Failed with status code: ${response.statusCode}');
        }
      } catch (e) {
        throw Exception('Failed to send multipart form data (Non-Web): $e');
      }
    }
  }
}

String apiUrl = dotenv.env['BASE_API_URL'] ?? 'Default API URL';

ApiService apiService = ApiService(baseUrl: apiUrl);
