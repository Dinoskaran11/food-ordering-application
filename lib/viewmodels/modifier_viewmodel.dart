import 'package:flutter/material.dart';
import 'package:food_order_app/models/ModifierGroupModel';
import 'package:food_order_app/services/dataservice.dart';

class ModifierViewmodel extends ChangeNotifier{
  final Dataservice _modifierService = Dataservice();
  List<ModifierGroups> _modifier = [];

  List<ModifierGroups> get modifier => _modifier;

  Future<void> loadModifier() async{
    _modifier = await _modifierService.fetchModifiers();
    notifyListeners();
  }
}