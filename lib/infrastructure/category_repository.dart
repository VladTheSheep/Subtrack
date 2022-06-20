import 'dart:convert';

import 'package:http/http.dart';
import 'package:subtrack/consts/links.dart';
import 'package:subtrack/database/models/category.dart';

class CategoryRepository {
  final Client _httpClient = Client();
  Future<List<Category>> fetchCategories() async {
    final List<Category> result = [];
    final Response response = await _httpClient.get(Uri.http(apiLink, '/getAllCategories'));

    final List<dynamic> categories = jsonDecode(response.body) as List<dynamic>;
    for (final dynamic cat in categories) {
      final Category category = Category.fromJson(cat as Map<String, dynamic>);
      result.add(category);
    }

    return result;
  }
}
