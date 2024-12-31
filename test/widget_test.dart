// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:spotify_flutter_apk/main.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

void main() async {
  test('Login test', () async {
    await loginUser('yones', 'Setar1fy');

    // Fetching user data
    await fetchUserData();

    // Decoding token
    await decodeToken();

    // Checking token expiry
    await handleTokenExpiry();
  }); // Build our app and trigger a frame.
}

final storage = FlutterSecureStorage(); // Secure storage for JWT

Future<void> loginUser(String username, String password) async {
  final url = Uri.parse('https://spectacular.ir/api/token/');

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'username': username, 'password': password}),
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final acceptToken = data['accept'];
    final refreshToken = data['refresh'];
    await storage.write(
        key: 'accept', value: acceptToken); // Store token securely
    await storage.write(
        key: 'refresh', value: refreshToken); // Store token securely
  } else {
    throw Exception('Failed to login: ${response.body}');
  }
}

Future<Map<String, String>> getAuthHeaders() async {
  final token = await storage.read(key: 'accept');
  return {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
}

Future<void> fetchUserData() async {
  // final url = Uri.parse('https://spectacular.ir/api/$username');
  final url = Uri.parse('https://spectacular.ir/api/songs/?artist=taylor-swift');
  final headers = await getAuthHeaders();

  final response = await http.get(
    url,
    headers: headers,
  );

  if (response.statusCode == 200) {
    final userData = json.decode(response.body);
    print('User Data: $userData');
  } else {
    throw Exception('Failed to fetch user data: ${response.body}');
  }
}

Future<void> decodeToken() async {
  final token = await storage.read(key: 'accept');
  if (token != null) {
    Map<String, dynamic> decoded = JwtDecoder.decode(token);
    print('Decoded Token: $decoded');
  }
}

bool isTokenExpired(String token) {
  return JwtDecoder.isExpired(token);
}

Future<void> handleTokenExpiry() async {
  final token = await storage.read(key: 'accept');
  if (token != null && isTokenExpired(token)) {
    // Redirect to login or refresh the token
    print('Token expired. Please login again.');
  }
}

Future<void> refreshToken() async {
  final url = Uri.parse('https://spectacular.ir/api/token/refresh/');
  final headers = await getAuthHeaders();

  final refreshToken = await storage.read(key: 'refresh');

  final response = await http.post(
    url,
    headers: headers,
    body: jsonEncode(
      {'refresh': refreshToken},
    ),
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final newToken = data['accept'];
    await storage.write(key: 'jwt', value: newToken);
    print('Token refreshed');
  } else {
    throw Exception('Failed to refresh token: ${response.body}');
  }
}
