// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:tezda_task/core/core.dart';
import 'package:http/http.dart' as http;

class HTTP {
  static String baseUrl = EnvironmentPath.baseUrl;

  // static String apiUrl = "https://api.escuelajs.co/api/v1";

  static String apiUrl = 'https://dummyjson.com';

  static final Map<String, String> _headers = Map<String, String>.from(
    {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    },
  );

  static List<String> headerLog = [];

  static addHeader({required String key, required String value}) {
    _headers[key] = value;
    headerLog.add("$key: $value");
  }

  static removeHeader({required String key}) {
    _headers.remove(key);
    headerLog.removeWhere((entry) => entry.startsWith('$key:'));
  }

  static Future<http.Response> post(
    String endpoint, {
    required Map<String, dynamic>? body,
  }) async {
    String url = "$apiUrl/$endpoint";
    final r = await http.post(
      Uri.parse(url),
      headers: _headers,
      body: json.encode(body),
    );
    return r;
  }

  static Future<http.Response> get(
    String endpoint,
  ) async {
    String url = "$apiUrl/$endpoint";
    final r = await http.get(
      Uri.parse(url),
      headers: _headers,
    );
    return r;
  }

  static Future<http.Response> update(
    String endpoint, {
    required Map<String, dynamic>? body,
  }) async {
    String url = "$apiUrl/$endpoint";
    final r = await http.put(
      Uri.parse(url),
      headers: _headers,
      body: json.encode(body),
    );
    return r;
  }

  static Future<http.Response> delete(
    String endpoint, {
    required Map<String, dynamic>? body,
  }) async {
    String url = "$apiUrl/$endpoint";
    final r = await http.delete(
      Uri.parse(url),
      headers: _headers,
      body: json.encode(body),
    );
    return r;
  }
}

class ApiResponse<T> {
  final String message;
  final int status;
  final T? data;

  const ApiResponse({
    required this.data,
    required this.message,
    required this.status,
  });
}
