import 'package:flutter/material.dart';
import 'package:food_order_app/models/CategoriesModel';
import 'package:food_order_app/services/dataservice.dart';
import 'package:food_order_app/viewmodels/items_viewmodel.dart';
import 'package:provider/provider.dart';

class CategoryViewmodel extends ChangeNotifier {
  final Dataservice _categoriesService = Dataservice();
  List<Categories> _categories = [];
  Set<int> selectedIndices = {};
  String? selectedMenuEntitiyId;

  List<Categories> get categories => _categories;

  Future<void> loadCategory(BuildContext context) async {
    _categories = await _categoriesService.fetchCategories();
    if (_categories.isNotEmpty) {
      selectedIndices.add(0);

      final menuEntityIds =
          _categories[0].menuEntities.map((entity) => entity.id).toList();
      

      selectedMenuEntitiyId =
          menuEntityIds.isNotEmpty ? menuEntityIds.first : null;

      // ignore: use_build_context_synchronously
      Provider.of<ItemsViewmodel>(context, listen: false)
          .filterItemsByMenuEntities(menuEntityIds);
    }
    notifyListeners();
  }

  void onSelectedChipView(BuildContext context, int index, bool isSelected) {
    selectedIndices.clear();
    if (isSelected) {
      selectedIndices.add(index);

      // Fetch menuEntities IDs for the selected category
      final menuEntityIds =
          _categories[index].menuEntities.map((entity) => entity.id).toList();
      

      selectedMenuEntitiyId =
          menuEntityIds.isNotEmpty ? menuEntityIds.first : null;

      selectedMenuEntitiyId = _categories[index].menuEntities.isNotEmpty
          ? _categories[index].menuEntities.first.id
          : null;

      Provider.of<ItemsViewmodel>(context, listen: false)
          .filterItemsByMenuEntities(menuEntityIds);
    } else {
      selectedMenuEntitiyId = null;
    }
    notifyListeners();
  }
}
