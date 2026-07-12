import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lafetch_ecom/data/models/product_model.dart';

class ProductRepo {
  // final http.Client _client;

  // ProductRepo({http.Client? client}) : _client = client ?? http.Client();

  /// Fetch all products from Fake Store API: https://fakestoreapi.com/products
  Future<List<Product>> fetchAllProducts() async {
    try {
      final response = await http.get(
        Uri.parse('https://fakestoreapi.com/products'),
      );
      if (response.statusCode == 200) {
        final dynamic decodedData = jsonDecode(response.body);
        if (decodedData is List) {
          return decodedData
              .map((json) => Product.fromJson(json as Map<String, dynamic>))
              .toList();
        }
        throw Exception('Response data is not a list');
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Fetch single product by id from Fake Store API: https://fakestoreapi.com/products/1
  Future<Product> fetchSingleProduct(int id) async {
    try {
      final response = await http.get(
        Uri.parse('https://fakestoreapi.com/products/$id'),
      );
      if (response.statusCode == 200) {
        final dynamic decodedData = jsonDecode(response.body);
        if (decodedData is Map<String, dynamic>) {
          return Product.fromJson(decodedData);
        }
        throw Exception('Response data is not a JSON object');
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Fetch all categories from Fake Store API: https://fakestoreapi.com/products/categories
  Future<List<String>> fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse('https://fakestoreapi.com/products/categories'),
      );
      if (response.statusCode == 200) {
        final dynamic decodedData = jsonDecode(response.body);
        if (decodedData is List) {
          return decodedData.map((item) => item.toString()).toList();
        }
        throw Exception('Response data is not a list of categories');
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
