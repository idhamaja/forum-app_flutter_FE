import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forum_apps/views/home.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:forum_apps/constants/constants.dart';

class AuthenticationController extends GetxController {
  final isLoading = false.obs;
  final token = ''.obs;

  final box = GetStorage();

  /// Register user. Returns the parsed response map on success, otherwise null.
  Future<Map<String, dynamic>?> register({
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      var data = {
        'name': name,
        'username': username,
        'email': email,
        'password': password,
      };

      var response = await http.post(
        Uri.parse('${url}register'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode(data),
      );

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        token.value = responseData['token'];
        box.write('token', token.value);
        isLoading.value = false;

        Get.snackbar(
          'Success',
          'Registration successful!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        return responseData; // Return the response data
      } else {
        isLoading.value = false;
        final errorResponse = json.decode(response.body);
        final errorMessage = _getErrorMessage(errorResponse);

        Get.snackbar(
          'Error',
          errorMessage,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        print(errorResponse);
        return null;
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Network error: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print(e.toString());
      return null;
    }
  }

  /// Login user. Returns parsed response map on success (token/user), otherwise null.
  Future<Map<String, dynamic>?> login({
    required String username,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      var data = {'username': username, 'password': password};

      var response = await http.post(
        Uri.parse('${url}login'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode(data),
      );

      // Fixed: Laravel returns 200 for login, not 201
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        token.value = responseData['token'];
        box.write('token', token.value);
        isLoading.value = false;

        Get.snackbar(
          'Success',
          'Login successful!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.offAll(() => const HomePage());
        return responseData; // Return the response data
      } else {
        isLoading.value = false;
        final errorResponse = json.decode(response.body);
        final errorMessage = _getErrorMessage(errorResponse);

        Get.snackbar(
          'Error',
          errorMessage,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        print(errorResponse);
        return null;
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Network error: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print(e.toString());
      return null;
    }
  }

  /// Helper method to extract error message from response
  String _getErrorMessage(dynamic errorResponse) {
    if (errorResponse is Map<String, dynamic>) {
      // Handle Laravel validation errors
      if (errorResponse.containsKey('errors')) {
        final errors = errorResponse['errors'];
        if (errors is Map<String, dynamic>) {
          // Get the first error message
          final firstError = errors.values.first;
          if (firstError is List && firstError.isNotEmpty) {
            return firstError.first.toString();
          }
          return firstError.toString();
        }
      }
      // Handle message field
      if (errorResponse.containsKey('message')) {
        return errorResponse['message'].toString();
      }
    }

    // Default error message
    return 'Something went wrong. Please try again.';
  }
}
