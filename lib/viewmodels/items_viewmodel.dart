import 'package:flutter/material.dart';
import 'package:food_order_app/models/ItemsModel';
import 'package:food_order_app/services/dataservice.dart';
import 'package:food_order_app/viewmodels/modifier_viewmodel.dart';

class ItemsViewmodel extends ChangeNotifier {
  final Dataservice _itemsService = Dataservice();
  List<Items> _items = [];
  List<Items> _filteredItems = [];
  final ModifierViewmodel _modifierViewmodel;

  ItemsViewmodel(this._modifierViewmodel);

  List<Items> get items => _filteredItems;

  Future<void> loadItems() async {
    try {
      _items = await _itemsService.fetchMenuItems();
      if (_items.isEmpty) {
        print("No item loaded");
      } else {
        
      }

      notifyListeners();
    } catch (e) {
      print('Error loading items: $e');
    }
  }

  void filterItemsByMenuEntities(List<String> menuEntityIds) {
   

    _filteredItems = _items.where((item) {
      final isMatch = menuEntityIds.contains(item.menuItemId);
    
      return isMatch;
    }).toList();
    
    notifyListeners();
  }

  Map<String, int> countModifiers() {
    final modifiers = _modifierViewmodel.modifier;
    print("Items: $_items"); 
    print("Modifiers: ${_modifierViewmodel.modifier}");
    Map<String, int> modifierCounts = {};

    for (var item in _items) {
      final modifierGroupRules = item.modifierGroupRules?.iDs ?? [];
      int count = modifiers
          .where((modifier) => modifierGroupRules
              .map((id) => id.toLowerCase().trim())
              .contains(modifier.modifierGroupId.toLowerCase().trim()))
          .length;

      modifierCounts[item.id] = count;
    }

    print("Modifier Counts: $modifierCounts");
    return modifierCounts;
  }
}
