import 'package:flutter/material.dart';
import 'package:food_order_app/models/MenuModel';
import 'package:food_order_app/services/dataservice.dart';

class MenuViewmodel  extends ChangeNotifier{
  final Dataservice _menuService = Dataservice();
  List<Menu> _menus = [];

  List<Menu> get menus => _menus;

  Future<void> loadMenus() async{
    //_menus = await _menuService.fetchMenus();
    notifyListeners();
  }
}