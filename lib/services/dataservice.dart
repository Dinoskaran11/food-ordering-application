import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:food_order_app/models/ItemsModel';
import 'package:food_order_app/models/ModifierGroupModel';

import '../models/CategoriesModel';

class Dataservice {
  Future<List<Categories>> fetchCategories() async {
    final response = await rootBundle.loadString('assets/dataset.json');
    final data = json.decode(response);

    List<dynamic> categories = data['Result']['Categories'];
    return categories
        .map((categories) => Categories.fromJson(categories))
        .toList();
  }

  Future<List<Items>> fetchMenuItems() async {
    try {
      final response = await rootBundle.loadString('assets/dataset.json');

      final data = json.decode(response);

      List<dynamic> items = data['Result']['Items'];

      return items.map((items) => Items.fromJson(items)).toList();
    } catch (e) {
      print('Error fetching menu items: $e');
      return [];
    }
  }

  Future<List<ModifierGroups>> fetchModifiers() async {
    try {
      final response = await rootBundle.loadString('assets/dataset.json');
      final data = json.decode(response);

      List<dynamic> modifiers = data['Result']['ModifierGroups'];

      return modifiers
          .map((modifier) => ModifierGroups.fromJson(modifier))
          .toList();
    } catch (e) {
      print('Error fetching modifiersGroups: $e');
      return [];
    }
  }
}
